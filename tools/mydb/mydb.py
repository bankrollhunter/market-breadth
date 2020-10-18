# -*- coding:utf-8 -*-

import pandas as pd
from sqlalchemy import create_engine
import mysql.connector as mycon
from ..util.config import config


class MyDB(object):
    # 获取config配置文件
    def __init__(self):
        self.host = config.get('database', 'host')
        self.port = config.getint('database', 'port')
        self.db = config.get('database', 'db')
        self.user = config.get('database', 'user')
        self.password = config.get('database', 'password')
        self.charset = config.get('database', 'charset')
        self.url = 'mysql+pymysql://{}:{}@{}:{}/{}?charset={}'.format(self.user, self.password, self.host, self.port,
                                                                      self.db, self.charset)

    def create_mydb(self):
        self.mydb = mycon.connect(
            host=self.host,  # 数据库主机地址
            port=self.port,
            user=self.user,  # 数据库用户名
            password=self.password,  # 数据库密码
            database=self.db,
            auth_plugin='mysql_native_password'
        )

    # 1. upsert_table 写入或者更新表
    #    table_name ： 写入的表明
    #    sql_columns ：写入的列
    #    sql_df ： dataframe 数据集
    def upsert_table(self, table_name, sql_columns, sql_df):
        self.create_mydb()
        mycursor = self.mydb.cursor()
        # `date` = VALUES(`date`)
        set_keys = map(lambda i: '`' + i + '` = VALUES(`' + i + '`)', sql_columns)
        # 记录在表中不存在则进行插入，如果存在则进行更新
        sql = '''
                INSERT INTO `{}` (`{}`) VALUES ({})
                ON DUPLICATE KEY UPDATE {};
            '''.format(table_name,
                       '`,`'.join(sql_columns),
                       ",".join('%s' for i in range(len(sql_columns))),
                       ", ".join(set_keys)
                       )
        sql_df = sql_df.reindex(columns=sql_columns)
        sql_df = sql_df.where(pd.notnull(sql_df), None)
        sql_values = sql_df.to_numpy().tolist()
        # 批量插入使用executement
        mycursor.executemany(sql, sql_values)
        self.mydb.commit()

    def read_data(self, table_name, sql_columns):
        db_engine = create_engine(self.url)
        # 记录在表中不存在则进行插入，如果存在则进行更新
        sql = '''
                SELECT `{}` FROM `{}`;
            '''.format('`,`'.join(sql_columns), table_name)
        return pd.read_sql(sql, db_engine)

    def read_from_sql(self, sql):
        db_engine = create_engine(self.url)
        return pd.read_sql(sql, db_engine)

    def truncate_table(self, table_name):
        self.create_mydb()
        mycursor = self.mydb.cursor()
        # 记录在表中不存在则进行插入，如果存在则进行更新
        sql = '''
                TRUNCATE TABLE {};
            '''.format(table_name)

        print('清空表数据：' + sql)
        # 批量插入使用executement
        mycursor.execute(sql)
        self.mydb.commit()

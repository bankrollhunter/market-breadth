# -*- coding:utf-8 -*-

from .mydb import MyDB

mydb = MyDB()


def upsert_table(table, columns, df):
    mydb.upsert_table(table_name=table, sql_columns=columns, sql_df=df)


def read_data(table, columns):
    mydb.read_data(table_name=table, sql_columns=columns)


def read_data_from_sql(sql):
    mydb.read_from_sql(sql=sql)


def truncate_table(table):
    mydb.truncate_table(table_name=table)

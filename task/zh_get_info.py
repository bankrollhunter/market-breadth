# -*- coding:utf-8 -*-

from opendatatools import swindex
import os
import sys

path = os.path.dirname(__file__) + os.sep + '..' + os.sep
sys.path.append(path)

from ..tools.util import *
from ..tools.mydb import *

ts.set_token(config.get('tushare', 'token'))
pro = ts.pro_api()

df = pro.stock_basic()
df.rename(columns={'symbol': 'code'}, inplace=True)

table = 'zh_stocks_info'
columns = ['code', 'ts_code', 'name', 'industry', 'area', 'market', 'list_date']
df = df[columns]
df = df[df['code'].str.isdigit()]
mydb.upsert_table(table, columns, df)

df, msg = swindex.get_index_list()
df1 = df.loc[df['section_name'] == "一级行业"]
ind1_list = df1.index_code

sw_columns = ['code', 'name', 'sw_ind1', 'sw_ind1_weight']
j = 0
for i in ind1_list:
    j = j + 1
    print('processing [' + str(j) + '/' + str(ind1_list.size) + '] : ' + i)
    stock_data, msg = swindex.get_index_cons(i)
    stock_data.rename(columns={'stock_code': 'code', 'stock_name': 'name', 'weight': 'sw_ind1_weight'},
                      inplace=True)
    stock_data.loc[:, 'sw_ind1'] = df1.query('index_code == "{}"'.format(i)).index_name.values[0]
    stock_data = stock_data[sw_columns]
    upsert_table(table, sw_columns, stock_data)

# -*- coding:utf-8 -*-

from opendatatools import usstock
import os
import sys

path = os.path.dirname(__file__) + os.sep + '..' + os.sep
sys.path.append(path)

from ..tools.util import *
from ..tools.mydb import *

def us_total_cap(x):
    if isinstance(x, str) and x.endswith('B'):
        return float(x[1:-1]) * 10
    elif isinstance(x, str) and x.endswith('M'):
        return float(x[1:-1]) / 100
    else:
        return None

start = datetime.now()

info_table = 'us_stocks_info'
# 更新 标普500 权重股
spx_columns = ['code', 'name', 'is_spx', 'sp_sector']
mydb.upsert_table(info_table, spx_columns, us.get_spx())
spx2_columns = ['code', 'name', 'spx_weight']
mydb.upsert_table(info_table, spx2_columns, us.get_spx2())
# 更新 纳斯达克100 权重股
ndx_columns = ['code', 'name', 'is_ndx', 'ndx_weight']
mydb.upsert_table(info_table, ndx_columns, us.get_ndx())
# 更新 道琼斯 权重股
dji_columns = ['code', 'name', 'is_dji', 'dji_weight']
mydb.upsert_table(info_table, dji_columns, us.get_dji())

# 全美股市场股票
symbols, msg = usstock.get_symbols()
if symbols is not None:
    columns = ['code', 'name', 'sector', 'industry', 'total_cap']
    symbols.rename(columns={'Symbol': 'code', 'Name': 'name', 'Sector': 'sector', 'MarketCap': 'total_cap'},
                   inplace=True)
    symbols = symbols[columns].set_index(['code']).drop_duplicates().reset_index()
    symbols.total_cap = symbols.total_cap.map(us_total_cap)
    mydb.upsert_table(info_table, columns, symbols)

end = datetime.now()
print('Download Data use {}'.format(end - start))

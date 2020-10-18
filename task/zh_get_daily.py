# -*- coding:utf-8 -*-

import os
import sys

path = os.path.dirname(__file__) + os.sep + '..' + os.sep
sys.path.append(path)

from tools.util import *
from tools.mydb import *

start_date = date.get_2year_ago('%Y%m%d')
end_date = date.get_end_day('%Y%m%d')

list_sql = '''
            select * from zh_stocks_info where ts_code is not null;
           '''

start = datetime.now()
stk_info = mydb.read_from_sql(list_sql)
stk_codes = stk_info.ts_code.copy()
stk_info = stk_info.set_index(['ts_code'])

table = 'zh_stocks_d'
mydb.truncate_table(table)

columns = ['code', 'date', 'name', 'industry', 'sw_ind1', 'sw_ind1_weight', 'area', 'market',
           'open', 'high', 'low', 'close', 'pre_close', 'is_gap',
           'vol', 'ma_vol', 'vol_rate', 'amount', 'ma_amt', 'amt_rate',
           's_ma', 'm_ma', 'l_ma', 's_ema', 'm_ema', 'l_ema',
           'ecs', 'esm', 'pesm', 'is_esm_over',
           'eml', 'peml', 'is_eml_over', 'ebais',
           'cs', 'pcs', 'is_cs_over',
           'sm', 'psm', 'is_sm_over',
           'ml', 'pml', 'is_ml_over', 'bais',
           's_close', 's_pre_close', 'is_s_up',
           'm_close', 'm_pre_close', 'is_m_up',
           'l_close', 'l_pre_close', 'is_l_up'
           ]
# 获取日K线数据
num = stk_codes.size
j = 0
for i in stk_codes:
    j = j + 1
    if i is None:
        print('processing [' + str(j) + '/' + str(num) + '] is None; Continue!')
        continue
    print('processing [' + str(j) + '/' + str(num) + '] : ' + i)
    df = zh.get_daily(ts_code=i, start_date=start_date, end_date=end_date)
    if df is None:
        continue
    df = df.tail(500)
    stock = stk_info.loc[i]
    df['ts_code'] = i
    df['code'] = stock.get('code')
    df.rename(columns={'trade_date': 'date'}, inplace=True)
    df.date = df.date.map(lambda x: date.date_convert(x, '%Y%m%d', '%Y-%m-%d'))
    df = df[~np.isnan(df['close'])]
    df = analysis.stock_zh_analysis(df, 20, 60, 120)
    if df is None:
        continue
    df['name'] = stock.get('name')
    df['sector'] = stock.get('sector')
    df['industry'] = stock.get('industry')
    df['sw_ind1'] = stock.get('sw_ind1')
    df['sw_ind1_weight'] = stock.get('sw_ind1_weight')
    df['area'] = stock.get('area')
    df['market'] = stock.get('market')
    df = df[~np.isnan(df['l_close'])]
    df = df[columns]
    mydb.upsert_table(table, columns, df)

end = datetime.now()
print('Download Data use {}'.format(end - start))

# A 股市场宽度
df = mydb.read_from_sql('SELECT * FROM zh_stocks_industries_d ORDER BY date desc;')
a_mb_name = path + 'data/Market-Breadth-ZH.jpg'
analysis.market_breadth(df, a_mb_name)

# A 股市场宽度-申万
df = mydb.read_from_sql('SELECT * FROM zh_stocks_sector_sw_d ORDER BY date desc;')
a_sw_mb = path + 'data/Market-Breadth-ZH-SW.jpg'
analysis.market_breadth(df, a_sw_mb)


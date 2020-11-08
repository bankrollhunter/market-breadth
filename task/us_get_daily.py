# -*- coding:utf-8 -*-

import os
import sys

path = os.path.dirname(__file__) + os.sep + '..' + os.sep
sys.path.append(path)

from ..tools.util import *
from ..tools.mydb import *

list_sql = '''
            select * from us_stocks_info
            where total_cap > 10 or is_spx = 'Y' or is_ndx = 'Y' or is_dji = 'Y';
           '''

start = datetime.now()
stk_info = mydb.read_from_sql(list_sql)
stk_codes = stk_info.code.copy()
stk_info = stk_info.set_index(['code'])

table = 'us_stocks_d'
mydb.truncate_table(table)

columns = ['code', 'date', 'name', 'sector', 'sp_sector', 'industry', 'total_cap',
           'is_spx', 'spx_weight', 'is_ndx', 'ndx_weight', 'is_dji', 'dji_weight',
           'open', 'high', 'low', 'close', 'pre_close', 'is_gap',
           'vol', 'ma_vol', 'vol_rate',
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
batch = 40
num = 0
for n in range(0, len(stk_codes), batch):
    num += 1
    print('Processing 第 {} 批 【{}~{}/{}】...'.format(num, n, n+batch, len(stk_codes)))
    sub_codes = stk_codes[n: n+batch]
    symbol_list = ' '.join(sub_codes)
    # data = yf.download(symbol_list, start=date.get_year_ago(), end=date.get_end_day(),
    #                    group_by="ticker", threads=True, auto_adjust=True,
    #                    interval='1d')
    data = us.download(symbol_list=symbol_list, start=date.get_year_ago(), end=date.get_end_day(),
                        interval='1d')
    for i in sub_codes:
        if i in data.columns:
            stock = stk_info.loc[i]
            df = data[i]
            if df is None:
                continue
            df = df.tail(250)
            df = df.reset_index()
            df.rename(columns={'Date': 'date', 'Open': 'open', 'High': 'high', 'Low': 'low',
                               'Close': 'close', 'Volume': 'vol'},
                      inplace=True)
            df = df[~np.isnan(df['close'])]
            df['code'] = i
            df = analysis.stock_analysis(df, 20, 60, 120)
            if df is None:
                continue
            df['name'] = stock.get('name')
            df['sector'] = stock.get('sector')
            df['sp_sector'] = stock.get('sp_sector')
            df['industry'] = stock.get('industry')
            df['total_cap'] = stock.get('total_cap')
            df['is_spx'] = stock.get('is_spx')
            df['spx_weight'] = stock.get('spx_weight')
            df['is_ndx'] = stock.get('is_ndx')
            df['ndx_weight'] = stock.get('ndx_weight')
            df['is_dji'] = stock.get('is_dji')
            df['dji_weight'] = stock.get('dji_weight')
            df = df[~np.isnan(df['l_close'])]
            df = df[columns]
            mydb.upsert_table(table, columns, df)

end = datetime.now()
print('Download Data use {}'.format(end - start))


# US 股市场宽度
df = mydb.read_from_sql('SELECT * FROM us_stocks_sector_d ORDER BY date desc;')
mb_name = path + './data/Market-Breadth-US.jpg'
analysis.market_breadth(df, mb_name)

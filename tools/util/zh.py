# -*- coding:utf-8 -*-

import tushare as ts
import time
from ..util.config import config
from ..util.date import *
import baostock as bs
import pandas as pd

token = config.get('tushare', 'token')
ts.set_token(token)


def _baostock_get_kline(ts_code='', freq='d', start_date='', end_date='', adj='2'):
    # # 登陆系统
    # lg = bs.login()
    # # 显示登陆返回信息
    # if lg.error_code is not '0':
    #     print('login respond error_code:' + lg.error_code)
    #     print('login respond error_msg:' + lg.error_msg)

    bao_code = ts_code.split('.')[1] + '.' + ts_code.split('.')[0]

    fields = "date,code,open,high,low,close,volume,amount" \
        if freq in "d w m" \
        else "date,time,code,open,high,low,close,volume,amount"
    # 获取沪深A股历史K线数据
    # 详细指标参数，参见“历史行情指标参数”章节；“分钟线”参数与“日线”参数不同。
    # 分钟线指标：date,time,code,open,high,low,close,volume,amount,adjustflag
    # 周月线指标：date,code,open,high,low,close,volume,amount,adjustflag,turn,pctChg
    rs = bs.query_history_k_data_plus(bao_code,
                                      fields,
                                      start_date=start_date, end_date=end_date,
                                      frequency=freq, adjustflag=adj)
    if rs.error_code is not '0':
        print('query_history_k_data_plus respond error_code:' + rs.error_code)
        print('query_history_k_data_plus respond  error_msg:' + rs.error_msg)
    #
    # # 登出系统
    # bs.logout()
    # 打印结果集
    data_list = []
    while (rs.error_code == '0') & rs.next():
        # 获取一条记录，将记录合并在一起
        data_list.append(rs.get_row_data())
    data = pd.DataFrame(data_list, columns=rs.fields)
    stk_columns = ['date', 'open', 'high', 'low', 'close', 'vol', 'amount']
    if 'time' in fields:
        data.rename(columns={'date': 'day', 'time': 'date', 'volume': 'vol'},
                    inplace=True)
        data = data[stk_columns]
        data['date'] = data.date.apply(lambda x: date_convert(x, '%Y%m%d%H%M%S%f', '%Y-%m-%d %H:%M:%S'))
    else:
        data.rename(columns={'volume': 'vol'},
                    inplace=True)
        data = data[stk_columns]
    data[["date"]] = data[["date"]].astype(str)
    data[["open"]] = data[["open"]].astype(float)
    data[["high"]] = data[["high"]].astype(float)
    data[["low"]] = data[["low"]].astype(float)
    data[["close"]] = data[["close"]].astype(float)
    data[["vol"]] = data[["vol"]].astype(int)
    data[["amount"]] = data[["amount"]].astype(float)
    return data


def get_15min(ts_code='', start_date='', end_date='', retry=20, pause=0.1):
    return _baostock_get_kline(ts_code=ts_code, freq='15', start_date=start_date, end_date=end_date)


def get_hour(ts_code='', start_date='', end_date='', retry=20, pause=0.1):
    return _baostock_get_kline(ts_code=ts_code, freq='60', start_date=start_date, end_date=end_date)


def get_daily(ts_code='', start_date='', end_date='', retry=20, pause=0.1):
    for _ in range(retry):
        try:
            return ts.pro_bar(ts_code=ts_code, adj='qfq', start_date=start_date, end_date=end_date)
        except:
            time.sleep(pause)


def get_week(ts_code='', start_date='', end_date='', retry=20, pause=0.1):
    for _ in range(retry):
        try:
            return ts.pro_bar(ts_code=ts_code, adj='qfq', freq='W', start_date=start_date, end_date=end_date)
        except:
            time.sleep(pause)


if __name__ == '__main__':
    print(get_15min(ts_code='600000.SH', start_date='2020-01-01', end_date='2020-08-19'))
    print(get_hour(ts_code='600000.SH', start_date='2020-01-01', end_date='2020-08-19'))
    # print(get_daily(ts_code='600000.SH', start_date='2020-01-01', end_date='2020-08-19'))

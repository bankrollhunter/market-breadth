# -*- coding:utf-8 -*-

import requests
import pandas as pd
import bs4 as bs
import yfinance as yf
import time


headers = {
    "User-Agent": 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
                  + 'AppleWebKit/537.36 (KHTML, like Gecko) '
                  + 'Chrome/83.0.4103.116 Safari/537.36'
}


def get_proxies():
    http_proxy = "http://127.0.0.1:10808"
    https_proxy = "https://127.0.0.1:10808"
    return {
        "http": http_proxy,
        "https": https_proxy
    }


def get_spx():
    url = 'http://en.wikipedia.org/wiki/List_of_S%26P_500_companies'
    request = requests.get(url, headers=headers)
    soup = bs.BeautifulSoup(request.text, 'lxml')
    table = soup.find('table', {'class': 'wikitable sortable'})

    symbol_list = []
    name_list = []
    sector_list = []
    industry_list = []
    for i in table.findAll('tr')[1:]:
        symbol_list.append(i.find_all('td')[0].get_text().replace('\n', ''))
        name_list.append(i.find_all('td')[1].get_text().replace('\n', ''))
        sector_list.append(i.find_all('td')[3].get_text().replace('\n', ''))
        industry_list.append(i.find_all('td')[4].get_text().replace('\n', ''))
    return pd.DataFrame({'code': symbol_list, 'name': name_list, 'is_spx': 'Y', 'sp_sector': sector_list})


def get_spx2():
    url = 'https://www.slickcharts.com/sp500'
    request = requests.get(url, headers=headers)
    data = pd.read_html(request.text)[0]
    # 『Symbol』就是股票代码
    return pd.DataFrame({'code': data.Symbol, 'name': data.Company, 'spx_weight': data.Weight})


def get_ndx():
    url = 'https://www.slickcharts.com/nasdaq100'
    request = requests.get(url, headers=headers)
    data = pd.read_html(request.text)[0]
    # 『Symbol』就是股票代码
    return pd.DataFrame({'code': data.Symbol, 'name': data.Company, 'is_ndx': 'Y', 'ndx_weight': data.Weight})


def get_dji():
    url = 'https://www.slickcharts.com/dowjones'
    request = requests.get(url, headers=headers)
    data = pd.read_html(request.text)[0]
    # 『Symbol』就是股票代码
    return pd.DataFrame({'code': data.Symbol, 'name': data.Company, 'is_dji': 'Y', 'dji_weight': data.Weight})


def download(symbol_list, start, end, interval, retry=10, pause=2):
    for _ in range(retry):
        try:
            return yf.download(symbol_list, start=start, end=end,
                       group_by="ticker", threads=True, auto_adjust=True,
                       interval=interval)
        except:
            time.sleep(pause)

    return yf.download(symbol_list, start=start, end=end,
                       group_by="ticker", threads=True, auto_adjust=True,
                       interval=interval)

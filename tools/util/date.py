# -*- coding:utf-8 -*-

from datetime import datetime
import calendar
from dateutil.relativedelta import *

lastday_map = {}


def now(format="%Y-%m-%d %H:%M:%S"):
    curr_date = datetime.now()
    return datetime.strftime(curr_date, format)


def get_current_day(format="%Y-%m-%d"):
    curr_date = datetime.now()
    return datetime.strftime(curr_date, format)


def get_end_day(format="%Y-%m-%d"):
    today = datetime.today()
    end_day = today + relativedelta(days=+1)
    return datetime.strftime(end_day, format)


def get_week_ago(format="%Y-%m-%d"):
    today = datetime.today()
    week_ago = today + relativedelta(days=-7)
    return datetime.strftime(week_ago, format)


def get_2week_ago(format="%Y-%m-%d"):
    today = datetime.today()
    week_ago = today + relativedelta(days=-14)
    return datetime.strftime(week_ago, format)


def get_month_ago(format="%Y-%m-%d"):
    today = datetime.today()
    month_ago = today + relativedelta(months=-1)
    return datetime.strftime(month_ago, format)


def get_2month_ago(format="%Y-%m-%d"):
    today = datetime.today()
    month_ago = today + relativedelta(months=-2)
    return datetime.strftime(month_ago, format)


def get_3month_ago(format="%Y-%m-%d"):
    today = datetime.today()
    month_ago = today + relativedelta(months=-3)
    return datetime.strftime(month_ago, format)


def get_year_ago(format="%Y-%m-%d"):
    today = datetime.today()
    year_ago = today + relativedelta(years=-1)
    return datetime.strftime(year_ago, format)

def get_2year_ago(format="%Y-%m-%d"):
    today = datetime.today()
    two_year_ago = today + relativedelta(years=-2)
    return datetime.strftime(two_year_ago, format)

def get_3year_ago(format="%Y-%m-%d"):
    today = datetime.today()
    three_year_ago = today + relativedelta(years=-3)
    return datetime.strftime(three_year_ago, format)


def get_current_day(format="%Y-%m-%d"):
    curr_date = datetime.now()
    return datetime.strftime(curr_date, format)


def date_convert(date, format, target_format):
    return datetime.strftime(datetime.strptime(date, format), target_format)


def get_month_firstday_and_lastday(year=None, month=None):
    """
    :param year: 年份，默认是本年，可传int或str类型
    :param month: 月份，默认是本月，可传int或str类型
    :return: firstDay: 当月的第一天，datetime.date类型
              lastDay: 当月的最后一天，datetime.date类型
    """
    if year:
        year = int(year)
    else:
        year = datetime.today().year

    if month:
        month = int(month)
    else:
        month = datetime.today().month

    # 获取当月第一天的星期和当月的总天数
    firstDayWeekDay, monthRange = calendar.monthrange(year, month)

    # 获取当月的第一天
    firstDay = datetime(year=year, month=month, day=1)
    lastDay = datetime(year=year, month=month, day=monthRange)

    return firstDay, lastDay


def get_month_lastday(datestr, format="%Y-%m-%d"):
    if datestr in lastday_map:
        return lastday_map[datestr]

    date = datetime.strptime(datestr, format)
    year = date.year
    month = date.month
    firstDay, lastDay = get_month_firstday_and_lastday(year, month)
    result = datetime.strftime(lastDay, format)
    lastday_map[datestr] = result
    return result


def get_target_date2(date, span, format="%Y-%m-%d"):
    curr_date = datetime.strptime(date, format)
    target = curr_date + relativedelta(days=span)
    return datetime.strftime(target, format)


def get_target_date(span, format="%Y-%m-%d"):
    today = datetime.today()
    target = today + relativedelta(days=span)
    return datetime.strftime(target, format)


def split_date(datestr, format="%Y-%m-%d"):
    date = datetime.strptime(datestr, format)
    return date.year, date.month, date.day


if __name__ == '__main__':
    print(get_target_date(0))
    print(get_target_date(10))
    print(get_target_date(-1))

# -*- coding:utf-8 -*-

import os
from configparser import RawConfigParser

config = RawConfigParser()
config_path = os.path.split(os.path.realpath(__file__))[0] + '/../../config/config.conf'
config.read(config_path)


if __name__ == '__main__':
    print(config.get('database', 'host'))

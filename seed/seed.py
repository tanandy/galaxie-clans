#! /usr/bin/env python
import datetime
from seed.config import Config
from seed.object import Object


class Seed(Object, Config):
    def __init__(self):
        Object.__init__(self)
        Config.__init__(self)

        self.__date_format = None

        self.date_format = "%Y-%m-%d %H:%M:%S"

    @property
    def date_format(self):
        return self.__date_format

    @date_format.setter
    def date_format(self, value):
        if type(value) != str:
            raise TypeError('"date_format" must be a str type')

        if self.date_format != value:
            self.__date_format = value

    @property
    def date(self):
        return datetime.datetime.now().strftime(self.date_format)


#! /usr/bin/env python
import datetime
from seed.config import Config
from seed.object import Object
import os

class Seed(Object, Config):
    def __init__(self):
        Object.__init__(self)
        Config.__init__(self)

        self.__date_format = None

        self.date_format = "%Y-%m-%d %H:%M:%S"

    @property
    def playbooks(self):
        list_to_return = []
        for item in os.listdir(self.playbooks_directory):
            if os.path.isfile(os.path.join(self.playbooks_directory, item)):
                filename, file_extension = os.path.splitext(os.path.join(self.playbooks_directory, item))
                if file_extension == '.yml':
                    list_to_return.append(item)
        return list_to_return

    @property
    def roles(self):
        list_to_return = []
        for item in os.listdir(self.roles_directory):
            if os.path.isdir(os.path.join(self.roles_directory, item)):
                list_to_return.append(item)
        return list_to_return

    @property
    def roles_directory(self):
        return os.path.join(self.working_directory, 'roles')

    @property
    def playbooks_directory(self):
        return os.path.join(self.working_directory, 'playbooks')

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

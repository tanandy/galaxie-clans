#! /usr/bin/env python
import os


class Config(object):
    def __init__(self):
        self.__working_directory = None

    @property
    def current_directory(self):
        return os.path.abspath(os.path.dirname(__file__))

    @property
    def working_directory(self):
        return os.path.abspath(os.path.join(self.current_directory, '..'))


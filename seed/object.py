#! /usr/bin/env python


class Object(object):
    def __init__(self):
        self.__verbose = None
        self.__verbose_level = None
        self.__debug = None
        self.__debug_level = None

        self.verbose = False
        self.verbose_level = 0
        self.debug = False
        self.debug_level = 0

    @property
    def verbose(self):
        return self.__verbose

    @verbose.setter
    def verbose(self, value):
        if type(value) != bool:
            raise TypeError('"verbose" must be a boolean type')

        if self.verbose != value:
            self.__verbose = value

    @property
    def verbose_level(self):
        return self.__verbose_level

    @verbose_level.setter
    def verbose_level(self, value):
        if type(value) != int:
            raise TypeError('"verbose_level" must be a int type')

        if self.verbose_level != value:
            self.__verbose_level = value

    @property
    def debug(self):
        return self.__debug

    @debug.setter
    def debug(self, value):
        if type(value) != bool:
            raise TypeError('"debug" must be a boolean type')

        if self.debug != value:
            self.__debug = value

    @property
    def debug_level(self):
        return self.__debug_level

    @debug_level.setter
    def debug_level(self, value):
        if type(value) != int:
            raise TypeError('"debug_level" must be a int type')

        if self.debug_level != value:
            self.__debug_level = value

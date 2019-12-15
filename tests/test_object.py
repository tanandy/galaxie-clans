import unittest
from seed.object import Object


class TestObject(unittest.TestCase):
    def test_verbose(self):
        my_object = Object()
        self.assertFalse(my_object.verbose)
        my_object.verbose = True
        self.assertTrue(my_object.verbose)
        self.assertRaises(TypeError, setattr, my_object, 'verbose', 42)

    def test_verbose_level(self):
        my_object = Object()
        self.assertEqual(0, my_object.verbose_level)
        my_object.verbose_level = 42
        self.assertEqual(42, my_object.verbose_level)
        self.assertRaises(TypeError, setattr, my_object, 'verbose_level', 'Hello')

    def test_debug(self):
        my_object = Object()
        self.assertFalse(my_object.debug)
        my_object.debug = True
        self.assertTrue(my_object.debug)
        self.assertRaises(TypeError, setattr, my_object, 'debug', 42)

    def test_debug_level(self):
        my_object = Object()
        self.assertEqual(0, my_object.debug_level)
        my_object.debug_level = 42
        self.assertEqual(42, my_object.debug_level)
        self.assertRaises(TypeError, setattr, my_object, 'debug_level', 'Hello')


if __name__ == '__main__':
    unittest.main()

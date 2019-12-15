import unittest
import datetime
from seed.seed import Seed


class TestSeed(unittest.TestCase):
    def test_date_format(self):
        seed = Seed()
        self.assertEqual("%Y-%m-%d %H:%M:%S", seed.date_format)
        seed.date_format = "%Y"
        self.assertEqual("%Y", seed.date_format)
        self.assertRaises(TypeError, setattr, seed, 'date_format', 42)

    def test_date(self):
        seed = Seed()
        self.assertEqual(seed.date, datetime.datetime.now().strftime(seed.date_format))


if __name__ == '__main__':
    unittest.main()

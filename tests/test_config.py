import unittest
import os
from seed.config import Config


class TestConfig(unittest.TestCase):
    def test_current_directory(self):
        config = Config()
        self.assertEqual('seed', os.path.basename(config.current_directory))

    def test_working_directory(self):
        config = Config()
        self.assertEqual('galaxie', os.path.basename(config.working_directory))

if __name__ == '__main__':
    unittest.main()

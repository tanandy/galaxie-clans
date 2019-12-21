import unittest
import datetime
import os
from seed.seed import Seed


class TestSeed(unittest.TestCase):
    def test_playbooks(self):
        seed = Seed()
        # self.assertEqual(list, type(seed.playbooks))
        # self.assertTrue('banner.yml' in seed.playbooks)
        # self.assertEqual(
        #     len(seed.roles), len(seed.playbooks)
        # )
        # self.assertEqual(len(seed.roles), len(seed.playbooks))
        self.assertTrue((len(seed.roles) >= len(seed.playbooks)))
        # for playbook in seed.playbooks:
        #     self.assertTrue(
        #         os.path.isfile(
        #             os.path.join(
        #                 seed.roles_directory,
        #                 playbook
        #             )
        #         )
        #     )

    def test_roles(self):
        seed = Seed()
        self.assertEqual(list, type(seed.roles))
        self.assertTrue('banner' in seed.roles)
        self.assertEqual(39, len(seed.roles))

        for role in seed.roles:
            self.assertTrue(
                os.path.isdir(
                    os.path.join(
                        seed.roles_directory,
                        role
                    )
                )
            )

    def test_roles_directory(self):
        seed = Seed()
        self.assertTrue(os.path.isdir(seed.roles_directory))
        self.assertEqual('roles', os.path.basename(seed.roles_directory))

    def test_playbooks_directory(self):
        seed = Seed()
        self.assertTrue(os.path.isdir(seed.playbooks_directory))
        self.assertEqual('playbooks', os.path.basename(seed.playbooks_directory))

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

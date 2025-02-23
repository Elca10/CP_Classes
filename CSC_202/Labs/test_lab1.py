import unittest
from lab1 import *

class testDoublyOrderedList(unittest.TestCase):
    # setUp

    # tearDown

    def test_add(self):
        dol = doubly_Ordered_List()
        dol.add(10)
        self.assertEqual(dol.python_list(), [10])
        dol.add(12)
        self.assertEqual(dol.python_list(), [10,12])
        dol.add(11)
        self.assertEqual(dol.python_list(), [10,11,12])
        self.assertFalse(dol.add(11))
        dol.add(4)
        self.assertEqual(dol.python_list(), [4,10,11,12])

    def test_is_empty(self):
        dol = doubly_Ordered_List()
        self.assertTrue(dol.is_empty())
        dol.add(10)
        self.assertFalse(dol.is_empty())
        dol.remove(10)
        self.assertTrue(dol.is_empty())
        dol.add(None)
        self.assertFalse(dol.is_empty())
        # IS A NODE WITH A "NONE" VALUE A NODE?
    
    def test_remove(self):
        dol = doubly_Ordered_List()
        dol.add(10)
        self.assertTrue(dol.remove(10))
        self.assertFalse(dol.remove(1000))

    def test_pop(self):
        dol = doubly_Ordered_List()
        dol.add(10)
        self.assertEqual(dol.pop(0), 10)
        with self.assertRaises(IndexError):
            dol.pop(1000)

    def test_search(self):
        dol = doubly_Ordered_List()
        self.assertFalse(dol.search(1000))
        dol.add(10)
        self.assertTrue(dol.search(10))
        self.assertFalse(dol.search(15))
        dol.add(11)
        dol.add(15.5)
        self.assertTrue(dol.search(11))
        self.assertTrue(dol.search(15.5))
        self.assertFalse(dol.search(16))

    def test_python_list_reversed(self):
        dol = doubly_Ordered_List()
        dol.add(10)
        dol.add(11)
        dol.add(12)
        dol.add(13)
        self.assertEqual(dol.python_list_reversed(), [13,12,11,10])

    def test_size(self):
        dol = doubly_Ordered_List()
        dol.add(10)
        self.assertEqual(dol.size(), 1)

    def test_index(self):
        dol = doubly_Ordered_List()
        dol.add(10)
        self.assertEqual(dol.index(10), 0)


if __name__ == '__main__':
    unittest.main()


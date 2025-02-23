import unittest 
from lab4 import *

class TestAVL_Tree(unittest.TestCase):
    def test_insert(self):
        tree = AVL_Tree()
        root = None

        # Test adding elements in sorted order
        for value in range(1, 10):
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test adding elements in reverse sorted order
        for value in range(10, 0, -1):
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test adding elements in random order
        values = [3, 1, 2, 5, 4]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test with negative numbers
        values = [-3, -1, -5, -2, -4]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test with duplicate numbers
        values = [3, 2, 1, 3, 2, 1]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

    def test_deletion(self):
        tree = AVL_Tree()
        root = None

        # Test deleting leaves of the tree
        root = AVLNode(7)
        for value in range(1, 6):
            root = tree.insert(root, value)
        root = tree.deleteNode(root, 1)
        root = tree.deleteNode(root, 5)
        self.assertEqual(tree.isAVL(root), True)

        # Test deleting nodes with one child
        root = tree.deleteNode(root, 4)
        self.assertEqual(tree.isAVL(root), True)

        # Test deleting nodes with two children
        root = tree.deleteNode(root, 3)
        self.assertEqual(tree.isAVL(root), True)

        # Test deleting root node
        root = tree.deleteNode(root, 2)
        self.assertEqual(tree.isAVL(root), True)

        # Test deleting non-existent elements
        root = tree.deleteNode(root, 10)
        self.assertEqual(tree.isAVL(root), True)

    def test_rotate(self):
        tree = AVL_Tree()
        root = None

        # Test rotating left when the tree is unbalanced to the right
        root = AVLNode(3)
        values = [2, 1]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test rotating right when the tree is unbalanced to the left
        values = [1, 2, 3]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test left-right rotation
        values = [3, 1, 2]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

        # Test right-left rotation
        values = [1, 3, 2]
        for value in values:
            root = tree.insert(root, value)
        self.assertEqual(tree.isAVL(root), True)

    def test_isAVL(self):
        tree = AVL_Tree()
        root = None

        # Test an empty tree
        self.assertEqual(tree.isAVL(root), True)

        # Test a single node tree
        root = AVLNode(5)
        self.assertEqual(tree.isAVL(root), True)

        # Test a balanced tree
        values = [3, 2, 1, 5, 4, 6]
        root = AVLNode(7)
        for value in values:
            root = tree.insert(root, value)
        x = tree.isAVL(root)
        self.assertEqual(x, True)

        # Test an unbalanced tree
        root = AVLNode(5)
        root.left_child = AVLNode(4)
        root.left_child.left_child = AVLNode(3)
        self.assertEqual(tree.isAVL(root), False)


    def test_balanceFactor(self):
        tree = AVL_Tree()

        # Test balance factor for an empty tree
        self.assertEqual(tree.balanceFactor(None), 0)

        # Test balance factor for a single node tree
        root = AVLNode(5)
        self.assertEqual(tree.balanceFactor(root), 0)

        # Test balance factor for a left heavy tree
        root = AVLNode(5)
        root.left_child = AVLNode(4)
        self.assertEqual(tree.balanceFactor(root), 1)

        # Test balance factor for a right heavy tree 
        root = AVLNode(5)
        root.right_child = AVLNode(6)
        self.assertEqual(tree.balanceFactor(root), -1)

        # Test balance factor for a balanced tree 
        root = AVLNode(5)
        root.left_child = AVLNode(4)
        root.right_child = AVLNode(6)
        self.assertEqual(tree.balanceFactor(root), 0)




if __name__ == "__main__":
    unittest.main()











# Note: Test cases are modified from a Chat GPT response
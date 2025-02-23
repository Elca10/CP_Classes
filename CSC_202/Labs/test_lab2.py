import unittest
from lab2 import *

class testDoublyOrderedList(unittest.TestCase):


    def test_Node(self):
        test_node1 = TreeNode(4, None, None)
        test_node2 = TreeNode(1,TreeNode(5, None, None), TreeNode(2, None, None))
        self.assertEqual(test_node1.value, 4)
        self.assertEqual(test_node2.left_child.value, 5)
        self.assertEqual(test_node2.right_child.value, 2)
        self.assertEqual(test_node2.right_child.right_child, None)

    def test_BinaryTree(self):
        test_tree1 = BST()
        test_tree2 = BST(root=9)
        self.assertEqual(test_tree1.root, None)
        self.assertEqual(test_tree2.root, 9)

#isBST() test case
    def test_isBST_empty_tree(self):
        # Test the behavior when the binary tree is empty
        test_tree = BST()
        self.assertTrue(test_tree.isBST())

    def test_isBST_single_node_tree(self):
        # Test the behavior when the binary tree has only one node
        test_tree = BST()
        test_tree.insert(5)
        self.assertTrue(test_tree.isBST())

    def test_isBST_two_nodes_tree(self):
        # Test the behavior when the binary tree has only two nodes
        test_tree = BST()
        test_tree.insert(5)
        test_tree.insert(3)
        self.assertTrue(test_tree.isBST())

    def test_isBST_duplicate_values(self):
        # Test the behavior when the binary tree contains duplicate values
        test_tree = BST()
        test_tree.insert(5)
        test_tree.insert(5)
        self.assertTrue(test_tree.isBST())

    def test_isBST_unbalanced_tree(self):
        # Test the behavior when the binary tree is unbalanced
        test_tree = BST()
        test_tree.insert(5)
        test_tree.insert(4)
        test_tree.insert(3)
        test_tree.insert(2)
        self.assertTrue(test_tree.isBST())

    def test_isBST_invalid_structure(self):
        # Test the behavior when the binary tree has an invalid structure
        test_tree = BST()
        test_tree.root = TreeNode(5)
        test_tree.root.left_child = TreeNode(7)  # Invalid: Left child has a greater value than the root
        test_tree.root.right_child = TreeNode(3)  # Invalid: Right child has a lesser value than the root
        self.assertFalse(test_tree.isBST())

    # def test_isBST_null_values(self):
    #     # Test the behavior when the binary tree contains null values
    #     test_tree = BinaryTree()
    #     test_tree.insert(5)
    #     test_tree.root.left_child = None
    #     test_tree.root.right_child = Node(3)
    #     self.assertTrue(test_tree.isBST())

    def test_isBST_negative_values(self):
        # Test the behavior when the binary tree contains negative values
        test_tree = BST()
        test_tree.insert(5)
        test_tree.insert(-3)
        test_tree.insert(-7)
        self.assertTrue(test_tree.isBST())

    def test_isBST_only_left_child(self):
        # Test the behavior when some nodes in the binary tree have only a left child
        test_tree = BST()
        test_tree.insert(5)
        test_tree.insert(4)
        test_tree.root.left_child.left_child = Node(3)
        self.assertTrue(test_tree.isBST())
#test make to sorted array
        
    def test_convertToSortedArray_empty_tree(self):
        # Test the behavior when the binary tree is empty
        test_tree = BST()
        self.assertEqual(test_tree.convertToSortedArray(), [])

    def test_convertToSortedArray_single_node_tree(self):
        # Test the behavior when the binary tree has only one node
        test_tree = BST()
        test_tree.insert(5)
        self.assertEqual(test_tree.convertToSortedArray(), [5])

    def test_convertToSortedArray_balanced_tree(self):
        # Test the behavior for a balanced binary search tree
        test_tree = BST()
        elements = [5, 3, 7, 2, 4, 6, 8]
        for element in elements:
            test_tree.insert(element)
        self.assertEqual(test_tree.convertToSortedArray(), [2, 3, 4, 5, 6, 7, 8])

    def test_convertToSortedArray_left_skewed_tree(self):
            # Test the behavior for a left-skewed binary tree
            test_tree = BST()
            elements = [5, 4, 3, 2, 1]
            for element in elements:
                test_tree.insert(element)
            self.assertEqual(test_tree.convertToSortedArray(), [1, 2, 3, 4, 5])

    def test_convertToSortedArray_negative_values(self):
        # Test the behavior when the binary tree contains negative values
        test_tree = BST()
        elements = [-5, -3, -7, -2, -4]
        for element in elements:
            test_tree.insert(element)
        self.assertEqual(test_tree.convertToSortedArray(), [-7, -5, -4, -3, -2])

    # def test_convertToSortedArray_duplicate_values(self):
    #     # Test the behavior when the binary tree contains duplicate values
    #     test_tree = BinaryTree()
    #     elements = [5, 3, 5, 2, 3, 4, 2]
    #     for element in elements:
    #         test_tree.insert(element)
    #     self.assertEqual(test_tree.convertToSortedArray(), [2, 2, 3, 3, 4, 5, 5])


#lowest common ancestor
    def test_lowestCommonAncestor(self):
        # Create a binary search tree
        binary_tree = BST()
        elements = [10, 5, 15, 3, 7, 12, 17]
        for element in elements:
            binary_tree.insert(element)

        # Test case 1: Both nodes are present in the tree
        node1 = binary_tree.root.left_child.left_child  # Node with value 3
        node2 = binary_tree.root.left_child.right_child  # Node with value 7
        lca = binary_tree.lowestCommonAncestor(node1, node2)
        self.assertEqual(lca.value, 5)

        # Test case 2: One node is the ancestor of the other
        node1 = binary_tree.root.left_child  # Node with value 5
        node2 = binary_tree.root.left_child.left_child  # Node with value 3
        lca = binary_tree.lowestCommonAncestor(node1, node2)
        self.assertEqual(lca.value, 5)

        # Test case 3: One node is the root node
        node1 = binary_tree.root  # Root node with value 10
        node2 = binary_tree.root.right_child.right_child  # Node with value 17
        lca = binary_tree.lowestCommonAncestor(node1, node2)
        self.assertEqual(lca.value, 10)

        # Test case 4: Both nodes are the same
        node1 = binary_tree.root.right_child.left_child  # Node with value 12
        node2 = binary_tree.root.right_child.left_child  # Node with value 12
        lca = binary_tree.lowestCommonAncestor(node1, node2)
        self.assertEqual(lca.value, 12)

#delete tree
        
    def test_deleteTree(self):
        # Create a binary search tree
        binary_tree = BST()
        elements = [10, 5, 15, 3, 7, 12, 17]
        for element in elements:
            binary_tree.insert(element)

        # Verify that the tree is not empty before deletion
        self.assertIsNotNone(binary_tree.root)

        # Delete the entire tree
        binary_tree.deleteTree()

        # Verify that the tree is empty after deletion
        self.assertIsNone(binary_tree.root)




    def test_lowestCommonAncestor(self):
        # Test null inputs
        x = BST(None).lowestCommonAncestor(1,2)
        self.assertEqual(x, None)

        # Positive test case
        b = BST()
        elements = [44, 17, 88, 8, 32, 65, 97,54,82,93,78,80]
        for element in elements:
            b.insert(element)
        lca = b.lowestCommonAncestor(82,80)
        self.assertEqual(lca.value, 44)

        # invalid nodes
        #lca = b.lowestCommonAncestor(82,1)
        #self.assertEqual(lca, None)

        # one node is ancestor of another
        lca = b.lowestCommonAncestor(82,44)
        self.assertEqual(lca.value, 44)



    def test_deleteTree(self):
        # Testing null
        x = BST(None)
        x.deleteTree()
        y = None
        self.assertEqual(x.root, y)
    
        # Testing one value
        a = BST(TreeNode(44))
        a.deleteTree()
        self.assertEqual(a.root.value, y)


        # Testing multiple values
        b = BST()
        elements = [44, 17, 88, 8, 32, 65, 97,54,82,93,78,80]
        for element in elements:
            b.insert(element)
        b.deleteTree()
        self.assertEqual(b.root.value,y)



if __name__ == '__main__':
    unittest.main()


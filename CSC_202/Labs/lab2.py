from dataclasses import dataclass

@dataclass
class TreeNode:
    value: int
    left_child: 'TreeNode' = None
    right_child: 'TreeNode' = None

@dataclass
class BST:
    root: TreeNode = None
    # binary tree


    def insert(self, value):
        if not self.root:
            self.root = TreeNode(value)
        else:
            self._insert_recursive(self.root, value)
    
    def _insert_recursive(self, current_node, value):
        if value < current_node.value:
            if current_node.left_child is not None:
                self._insert_recursive(current_node.left_child, value)
            else:
                current_node.left_child = TreeNode(value)
        elif value > current_node.value:
            if current_node.right_child is not None:
                self._insert_recursive(current_node.right_child, value)
            else:
                current_node.right_child = TreeNode(value)
        else:
            # Value already exists in the tree, handle as per your requirement.
            pass
    
    def search(self, value):
        return self._search_recursive(self.root, value)
    
    def _search_recursive(self, current_node, value):
        if not current_node:
            return False
        if current_node.value == value:
            return True
        elif value < current_node.value:
            return self._search_recursive(current_node.left_child, value)
        else:
            return self._search_recursive(current_node.right_child, value)
    
    def delete(self, value):
        self.root = self._delete_recursive(self.root, value)
    
    def _delete_recursive(self, current_node, value):
        if current_node is None:
            return current_node # If the tree is empty or the node is not found, return None.
        # Recursive calls for ancestors of the node to be deleted.
        if value < current_node.value:
            current_node.left_child = self._delete_recursive(current_node.left_child, value)
            # Recur down the left subtree if the value is smaller.
        elif value > current_node.value:
            current_node.right_child = self._delete_recursive(current_node.right_child, value) 
            # Recur down the left subtree if the value is greator.
        else:
            # Node with only one child or no child
            if current_node.left_child is None:
                temp_node = current_node.right_child
                del current_node
                return temp_node
            elif current_node.right_child is None:
                temp_node = current_node.left_child
                del current_node
                return temp_node
            # Node with two children: Get the inorder successor (smallest in the right subtree)
            current_node.value = self._find_min_value(current_node.right_child)
            
            # Delete the inorder successor
            current_node.right_child = self._delete_recursive(current_node.right_child, current_node.value)
        
        return current_node
    
    def _find_min_value(self, node):
        current = node
        while current.left_child is not None:
            current = current.left_child
        return current.value






    def traverse_postOrder(self, current=0, postOrderList=[]):
        if current==0:
            current = self.root

        if current.left_child:
            self.traverse_postOrder(current.left_child,postOrderList)
        if current.right_child:
            self.traverse_postOrder(current.right_child, postOrderList)
        
        #print(current.value, end=", ")
        postOrderList.append(current)
        return postOrderList


    def traverse_inOrder(self, current=0, inOrderList=[]):
        if current==0:
            current = self.root

        if current.left_child:
            self.traverse_inOrder(current.left_child,inOrderList)
        
        #print(current.value, end=", ")
        inOrderList.append(current.value)
        
        if current.right_child:
            self.traverse_inOrder(current.right_child, inOrderList)
        
        return inOrderList

    def traverse_preOrder(self, current=0, preOrderList=[]):
        if current==0:
            current = self.root

        #print(current.value, end=", ")
        preOrderList.append(current)
        
        if current.left_child:
            self.traverse_preOrder(current.left_child,preOrderList)

        if current.right_child:
            self.traverse_preOrder(current.right_child, preOrderList)
        
        return preOrderList




    def isBST(self):
        # check if the given binary tree is a valid BST
        # check all left values are < and right values are >

        # can probably do this recursively and more efficiently
        current = self.root
        while current.left_child is not None:
            if current.left_child.value >= current.value:
                return False
            current = current.left_child
        current = self.root
        while current.right_child is not None:
            if current.right_child.value <= current.value:
                return False
            current = current.right_child
        return True


    def convertToSortedArray(self):
        # convert the BST into a sorted array
        # traverse in order (LOR, print when seeing for the 2nd time), recursive

        # Note: returning a list of TreeNodes, not values!
        return self.traverse_inOrder()
    

    def lowestCommonAncestor(self, node1, node2, current=0):
        # find the lowest common ancestor of two nodes in the BST
        # Lowest common ancestor is the ancestor you find while going down in the depth of a tree or the levels down from root node

        # edge case: one node is an ancestor if the other
        # edge case: a node is not in the BST
        # edge case: node is root
        
        if current == 0:
            current = self.root

        if current is None:
            return None
        
        if type(node1) == TreeNode:
            node1 = node1.value
        if type(node2) == TreeNode:
            node2 = node2.value

        nodes = self.traverse_inOrder()
        if node1 not in nodes or node2 not in nodes:
            return None
        # determine which side of tree they're both on --> LCA
        if node1 > current.value and node2 > current.value:
            # on the right side (both greater than current root)
            self.lowestCommonAncestor(node1, node2, current.right_child)
        if node1 < current.value and node2 < current.value:
            # on the left
            self.lowestCommonAncestor(node1, node2, current.left_child)

        return current



    def deleteTree(self, current=0):
        if self.root is None:
            return None
        if current==0:
            current = self.root
        elif current is None or current.value == None:
            return None
        if current.left_child:
            self.deleteTree(current.left_child)
        if current.right_child:
            self.deleteTree(current.right_child)
        
        current.left_child = None
        current.right_child = None
        current.value = None

        # this return is unnecessary
        return




# # Example usage:
# if __name__ == "__main__":
#     binary_search_tree = BST()
#     elements = [44, 17, 88, 8, 32, 65, 97,54,82,93,78,80]

    
#     for element in elements:
#         binary_search_tree.insert(element)
#     print(binary_search_tree.isBST())
#     #binary_search_tree.root.value = 100
#     #print(binary_search_tree.isBST())
#     #x = binary_search_tree.traverse_preOrder()
#     #print(x)

#     print(binary_search_tree.lowestCommonAncestor(82,80).value)
#     binary_search_tree.traverse_postOrder()
#     binary_search_tree.deleteTree()
#     print("\nAFTER:")
#     binary_search_tree.traverse_postOrder()
#     print(binary_search_tree)













        # def deleteTree1(self, current = 0):
    #     # delete the entire BST. Delete nodes one by one from leaf nodes to root
    #     # also traversing
    #     #print(current)
    #     #if not current:
    #     #    return
        
    #     if current == self.root:
    #         current = None
    #         self.root = None
    #     if current==0:
    #         current = self.root

    #     if current.left_child:
    #         self.deleteTree(current.left_child)
    #     if current.right_child:
    #         self.deleteTree(current.right_child)
        
    #     print(current.value, end=", ")
    #     # delete current
    #     current.left_child = None
    #     current.right_child = None
    #     if current == self.root:
    #         self.root = None
    #         return
    

    # def deleteTree7(self, current=0):
    #     if current != 0 and current.value == self.root.value:
    #         return
    #     else:
    #         if current==0:
    #             current = self.root

    #         if current.left_child:
    #             self.deleteTree(current.left_child)
    #         if current.right_child:
    #             self.deleteTree(current.right_child)
            
    #         current.left_child = None
    #         current.right_child = None
    #         current.value = None

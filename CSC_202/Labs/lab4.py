# A large portion of this code was modified from the provided "AVL Tree Insertion Deletion ops" code.

class AVLNode():
    ''' A class named AVLNode to represent each node in the AVL tree, including attributes
        for value, left child, right child, and height. '''
    def __init__(self, value:int) -> None:
        self.value = value
        self.left_child:AVLNode = None
        self.right_child:AVLNode = None
        self.height:int = 1

# AVL tree class which supports the Insert operation
class AVL_Tree:
    ''' Implement a class named AVLTree to represent the AVL tree and include all required
        methods within this class: isAVL(), balanceFactor(), rotateLeft(), rotateRight(), and deleteNode().'''
    # Recursive function to insert value in
    # subtree rooted with node and returns
    # new root of the subtree.
    # def __init__(self, root:AVLNode=None) -> None:
    #     self.root = root

    def insert(self, root: AVLNode, value: int) -> AVLNode:

        # Step 1 - Perform normal BST
        if not root:
            return AVLNode(value)
        # elif value == root.value:
        #     return root
        elif value < root.value:
            root.left_child = self.insert(root.left_child, value)
        else:
            root.right_child = self.insert(root.right_child, value)

        # Step 2 - Update the height of the ancestor node
        root.height = 1 + max(self.getHeight(root.left_child),self.getHeight(root.right_child))

        # Step 3 - Get the balance factor
        balance = self.balanceFactor(root)

        # Step 4 - If the node is unbalanced,
        # then try out the 4 cases
        # Case 1 - left_child left_child
        if balance > 1 and value < root.left_child.value:
            return self.rotateRight(root)

        # Case 2 - right_child right_child
        if balance < -1 and value > root.right_child.value:
            return self.rotateLeft(root)

        # Case 3 - left_child right_child
        if balance > 1 and value > root.left_child.value:
            root.left_child = self.rotateLeft(root.left_child)
            return self.rotateRight(root)

        # Case 4 - right_child left_child
        if balance < -1 and value < root.right_child.value:
            root.right_child = self.rotateRight(root.right_child)
            return self.rotateLeft(root)

        return root

    def rotateLeft(self, z: AVLNode) -> AVLNode:
        y = z.right_child
        T2 = y.left_child

        # Perform rotation
        y.left_child = z
        z.right_child = T2

        # Update heights
        z.height = 1 + max(self.getHeight(z.left_child),
                           self.getHeight(z.right_child))
        y.height = 1 + max(self.getHeight(y.left_child),
                           self.getHeight(y.right_child))

        # Return the new root
        return y

    def rotateRight(self, z: AVLNode) -> AVLNode:
        y = z.left_child
        T3 = y.right_child

        # Perform rotation
        y.right_child = z
        z.left_child = T3

        # Update heights
        z.height = 1 + max(self.getHeight(z.left_child),
                           self.getHeight(z.right_child))
        y.height = 1 + max(self.getHeight(y.left_child),
                           self.getHeight(y.right_child))

        # Return the new root
        return y

    def getHeight(self, root: AVLNode) -> int:
        if not root:
            return 0

        return root.height

    def balanceFactor(self, root: AVLNode) -> int:
        if not root:
            return 0

        return self.getHeight(root.left_child) - self.getHeight(root.right_child)

    def deleteNode(self, root: AVLNode, value: int) -> AVLNode:
        if not root:
            return root

        # Perform regular binary search tree deletion
        if value < root.value:
            root.left_child = self.deleteNode(root.left_child, value)
        elif value > root.value:
            root.right_child = self.deleteNode(root.right_child, value)
        else:
            # Node to be deleted is found
            if not root.left_child:
                temp = root.right_child
                root = None
                return temp
            elif not root.right_child:
                temp = root.left_child
                root = None
                return temp

            # Node to be deleted has two children
            temp = self.find_min_node(root.right_child)
            root.value = temp.value
            root.right_child = self.deleteNode(root.right_child, temp.value)

        # Update height of the current node
        root.height = 1 + max(self.getHeight(root.left_child), self.getHeight(root.right_child))

        # Get the balance factor
        balance = self.balanceFactor(root)

        # Perform rotations if the node is unbalanced
        # Case 1 - left_child left_child means left-left insertion
        if balance > 2 and self.balanceFactor(root.left_child) == 1 or 0:
            return self.rotateRight(root)

        # Case 2 - right_child right_child means right-right insertion
        if balance < -2 and self.balanceFactor(root.right_child) ==-1 or 0:
            return self.rotateLeft(root)

        # Case 3 - left_child right_child means left-right insertion
        if balance > 2 and self.balanceFactor(root.left_child) ==-1:
            root.left_child = self.rotateLeft(root.left_child)
            return self.rotateRight(root)

        # Case 4 - right_child left_child means right-left insertion
        if balance < -2 and self.balanceFactor(root.right_child) ==1:
            root.right_child = self.rotateRight(root.right_child)
            return self.rotateLeft(root)

        return root

    def find_min_node(self, node: AVLNode) -> AVLNode:
        current = node
        while current.left_child:
            current = current.left_child
        return current

    def preOrder(self, root: AVLNode, items=[], balancefactors=[]) -> None:
        if not root:
            return
        items.append(root.value)
        balancefactors.append(self.balanceFactor(root))
        print(f"{root.value}({root.height}) ",end="")
        #print("{0} ".format(root.value), end="")
        self.preOrder(root.left_child, items,balancefactors)
        self.preOrder(root.right_child, items,balancefactors)
        return items, balancefactors



    # def isAVL(self, current):
    #     '''Returns True if the tree is a proper AVL tree (satisfies the conditions). Returns False otherwise.'''
    #     if type(current) != AVLNode:
    #         return False
    #     if not current:
    #         return True # an empty AVL tree is by default a valid tree
    #     if abs(self.balanceFactor(current)) > 1:
    #         return False
    #     self.isAVL(current.left_child)
    #     self.isAVL(current.right_child)
    #     return True

    def isAVL(self, current):
        # if empty tree
        if not current:
            print("~~~ TREE IS EMPTY: True")
            return True
        
        # if root is not a valid root
        if type(current) != AVLNode:
            print("~~~ ROOT IS NOT A NODE: False")
            return False    
        
        # If duplicates
        items, balances = self.preOrder(current, [], [])
        print(items, balances)
        if len(set(items)) != len(items):
            print("~~~ DUPLICATES: False")
            return False  

        # Tree has no nodes, or only 1
        if len(items) <= 1:
            print("~~~ TREE IS EMPTY OR ONLY 1 NODE: True")
            return True
        
        # Unbalanced node somewhere
        balances = [abs(value) for value in balances]
        if max(balances) > 1 :
            print("~~~ TREE IS UNBALANCED: False")
            return False
        
        return True


# # Driver program to test above function
# myTree = AVL_Tree()
# root = None

# root = myTree.insert(root, 10)
# root = myTree.insert(root, 20)
# root = myTree.insert(root, 30)
# root = myTree.insert(root, 40)
# root = myTree.insert(root, 50)
# root = myTree.insert(root,25)

# # Preorder Traversal
# print("Preorder traversal of the",
#       "constructed AVL tree is")
# x,y = myTree.preOrder(root)
# print()
# print(x)


# # Delete node with value 30
# root = myTree.deleteNode(root, 30)
# print("Preorder traversal of the constructed AVL tree is")
# myTree.preOrder(root)
# print()
# print(myTree.isAVL(root))


# # TESTING INVALID TREE
# node = AVLNode(100)
# node.right_child = root
# root = node
# myTree.preOrder(root)
# print()
# print(myTree.isAVL(root))
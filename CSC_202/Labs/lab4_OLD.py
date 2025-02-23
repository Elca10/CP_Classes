# INSTRUCTIONS: https://canvas.calpoly.edu/courses/123669/assignments/918832



class AVLNode():
    ''' A class named AVLNode to represent each node in the AVL tree, including attributes
        for value, left child, right child, and height. '''
    def __init__(self, value:int, height:int=1) -> None:
        self.value = value
        self.left_child:AVLNode = None
        self.right_child:AVLNode = None
        self.height:int = height



class AVLTree():
    ''' Implement a class named AVLTree to represent the AVL tree and include all required
        methods within this class: isAVL(), balanceFactor(), rotateLeft(), rotateRight(), and deleteNode().'''
    def __init__(self, root:AVLNode=None) -> None:
        self.root = root


    def isAVL(self):
        pass

    def balanceFactor(self, root: AVLNode=0) -> int:
        if root == 0:
            root = self.root
        if not root:
            return 0
        print(f"{self.getHeight(root.left_child)} - {self.getHeight(root.right_child)}")
        return self.getHeight(root.left_child) - self.getHeight(root.right_child)

    def getHeight(self, root: AVLNode) -> int:
        if not root:
            return 0
        return root.height


    def rotateLeft(self, z: AVLNode) -> AVLNode:
        print("left rotate")
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
        print('right rotate')
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






    def deleteNode(self, value):
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






    def insert(self, value:int) -> None:
        self.BSTinsert(value)

        self.root.height = 1 + max(self.getHeight(self.root.left_child), self.getHeight(self.root.right_child))

        balance = self.balanceFactor()
        print(balance)

        if balance > 1 and value < self.root.left_child.value:
            return self.rotateRight(self.root)

        # Case 2 - right_child right_child
        if balance < -1 and value > self.root.right_child.value:
            return self.rotateLeft(self.root)

        # Case 3 - left_child right_child
        if balance > 1 and value > self.root.left_child.value:
            self.root.left_child = self.rotateLeft(self.root.left_child)
            return self.rotateRight(self.root)

        # Case 4 - right_child left_child
        if balance < -1 and value < self.root.right_child.value:
            self.root.right_child = self.rotateRight(self.root.right_child)
            return self.rotateLeft(self.root)




    def BSTinsert(self, value:int) -> None:
        if not self.root:
            self.root = AVLNode(value)
        else:
            self._BSTinsert_recursive(self.root, value)
    
    def _BSTinsert_recursive(self, current_node:AVLNode, value:int):
        if value < current_node.value:
            if current_node.left_child is not None:
                self._BSTinsert_recursive(current_node.left_child, value)
            else:
                current_node.left_child = AVLNode(value)
                current_node.height += 1
        elif value > current_node.value:
            if current_node.right_child is not None:
                self._BSTinsert_recursive(current_node.right_child, value)
            else:
                current_node.right_child = AVLNode(value)
                current_node.height += 1
        else:
            # Value already exists in the tree, handle as per your requirement.
            pass







COUNT = [5]

def print2DUtil(root, space):
 
    # Base case
    if (root == None):
        return
 
    # Increase distance between levels
    space += COUNT[0]
 
    # Process right child first
    print2DUtil(root.right_child, space)
 
    # Print current node after space
    # count
    print()
    for i in range(COUNT[0], space):
        print(end=" ")
    print(f"{root.value}({root.height})")
 
    # Process left child
    print2DUtil(root.left_child, space)
 
# Wrapper over print2DUtil()
 
 
def print2D(root):
 
    # space=[0]
    # Pass initial space count as 0
    print2DUtil(root, 0)








x = AVLTree(AVLNode(10))
# print(x.root.value)
for i in [10,5,6,15,3,12,1,9,8,7,4,2]:
    x.insert(i)
    print2D(x.root)
    print("------------------")
# print(x.root.value, x.root.left_child.value, x.root.right_child.value)

print2D(x.root)
x.deleteNode(5)
print("----")
print2D(x.root)
x.deleteNode(10)
print("----")
print2D(x.root)
x.deleteNode(1)
print("----")
print2D(x.root)
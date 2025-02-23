from dataclasses import dataclass

# Generic tree node class
@dataclass
class TreeNode:
    val: int
    left_child: 'TreeNode' = None
    right_child: 'TreeNode' = None
    height: int = 1


# AVL tree class which supports the Insert operation
@dataclass
class AVL_Tree:

    # Recursive function to insert value in
    # subtree rooted with node and returns
    # new root of the subtree.
    def insert(self, root: TreeNode, value: int) -> TreeNode:

        # Step 1 - Perform normal BST
        if not root:
            return TreeNode(value)
        elif value < root.val:
            root.left_child = self.insert(root.left_child, value)
        else:
            root.right_child = self.insert(root.right_child, value)

        # Step 2 - Update the height of the ancestor node
        root.height = 1 + max(self.getHeight(root.left_child),self.getHeight(root.right_child))

        # Step 3 - Get the balance factor
        balance = self.getBalance(root)

        # Step 4 - If the node is unbalanced,
        # then try out the 4 cases
        # Case 1 - left_child left_child
        if balance > 1 and value < root.left_child.val:
            return self.right_childRotate(root)

        # Case 2 - right_child right_child
        if balance < -1 and value > root.right_child.val:
            return self.left_childRotate(root)

        # Case 3 - left_child right_child
        if balance > 1 and value > root.left_child.val:
            root.left_child = self.left_childRotate(root.left_child)
            return self.right_childRotate(root)

        # Case 4 - right_child left_child
        if balance < -1 and value < root.right_child.val:
            root.right_child = self.right_childRotate(root.right_child)
            return self.left_childRotate(root)

        return root

    def left_childRotate(self, z: TreeNode) -> TreeNode:
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

    def right_childRotate(self, z: TreeNode) -> TreeNode:
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

    def getHeight(self, root: TreeNode) -> int:
        if not root:
            return 0

        return root.height

    def getBalance(self, root: TreeNode) -> int:
        if not root:
            return 0

        return self.getHeight(root.left_child) - self.getHeight(root.right_child)

    def delete(self, root: TreeNode, value: int) -> TreeNode:
        if not root:
            return root

        # Perform regular binary search tree deletion
        if value < root.val:
            root.left_child = self.delete(root.left_child, value)
        elif value > root.val:
            root.right_child = self.delete(root.right_child, value)
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
            root.val = temp.val
            root.right_child = self.delete(root.right_child, temp.val)

        # Update height of the current node
        root.height = 1 + max(self.getHeight(root.left_child), self.getHeight(root.right_child))

        # Get the balance factor
        balance = self.getBalance(root)

        # Perform rotations if the node is unbalanced
        # Case 1 - left_child left_child means left-left insertion
        if balance > 2 and self.getBalance(root.left_child) == 1 or 0:
            return self.right_childRotate(root)

        # Case 2 - right_child right_child means right-right insertion
        if balance < -2 and self.getBalance(root.right_child) ==-1 or 0:
            return self.left_childRotate(root)

        # Case 3 - left_child right_child means left-right insertion
        if balance > 2 and self.getBalance(root.left_child) ==-1:
            root.left_child = self.left_childRotate(root.left_child)
            return self.right_childRotate(root)

        # Case 4 - right_child left_child means right-left insertion
        if balance < -2 and self.getBalance(root.right_child) ==1:
            root.right_child = self.right_childRotate(root.right_child)
            return self.left_childRotate(root)

        return root

    def find_min_node(self, node: TreeNode) -> TreeNode:
        current = node
        while current.left_child:
            current = current.left_child
        return current

    def preOrder(self, root: TreeNode) -> None:
        if not root:
            return

        print("{0} ".format(root.val), end="")
        self.preOrder(root.left_child)
        self.preOrder(root.right_child)


# Driver program to test above function
myTree = AVL_Tree()
root = None

root = myTree.insert(root, 10)
root = myTree.insert(root, 20)
root = myTree.insert(root, 30)
root = myTree.insert(root, 40)
root = myTree.insert(root, 50)
root = myTree.insert(root,25)

# Preorder Traversal
print("Preorder traversal of the",
      "constructed AVL tree is")
myTree.preOrder(root)
print()

# Delete node with value 30
root = myTree.delete(root, 30)
print("Preorder traversal of the", "constructed AVL tree is")
myTree.preOrder(root)
print()
from dataclasses import dataclass
@dataclass
class Node:
    value: int
    prev_node: 'Node' = None
    next_node: 'Node' = None


@dataclass
class DoublyLinkedList:
    head: 'Node' = None
    tail: 'Node' = None

    def append(self, value):
        new_node = Node(value)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
        else:
            new_node.prev_node = self.tail
            self.tail.next_node = new_node
            self.tail = new_node
    
    def traverse_forward(self):
        current_node = self.head
        while current_node is not None:
            print(current_node.value, end=" ")
            current_node = current_node.next_node
        print()
    
    def traverse_backward(self):
        current_node = self.tail
        while current_node is not None:
            print(current_node.value, end=" ")
            current_node = current_node.prev_node
        print()

    def add_begin(self, value):
        new_node = Node(value)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
        else:
            new_node.next_node = self.head
            self.head.prev_node = new_node
            self.head = new_node
    
    def add_end(self, value):
        new_node = Node(value)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
        else:
            new_node.prev_node = self.tail
            self.tail.next_node = new_node
            self.tail = new_node

    def add_in_between(self, value, after_value):
        new_node = Node(value)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
        else:
            current_node = self.head
            while current_node is not None:
                if current_node.value == after_value:
                    new_node.prev_node = current_node
                    new_node.next_node = current_node.next_node
                    if current_node.next_node is not None:
                        current_node.next_node.prev_node = new_node
                    current_node.next_node = new_node
                    if current_node == self.tail:
                        self.tail = new_node
                    break
                current_node = current_node.next_node

    def delete_at_beginning(self):
        if self.head is None:
            return
        if self.head == self.tail:
            self.head = None
            self.tail = None
        else:
            self.head = self.head.next_node
            self.head.prev_node = None

    def delete_at_end(self):
        if self.tail is None:
            return
        if self.head == self.tail:
            self.head = None
            self.tail = None
        else:
            self.tail = self.tail.prev_node
            self.tail.next_node = None

    def delete_in_between(self, value):
        if self.head is None:
            return
        if self.head == self.tail and self.head.value == value:
            self.head = None
            self.tail = None
            return
        
        current_node = self.head
        while current_node is not None:
            if current_node.value == value:
                if current_node == self.head:
                    self.head = current_node.next_node
                    self.head.prev_node = None
                elif current_node == self.tail:
                    self.tail = current_node.prev_node
                    self.tail.next_node = None
                else:
                    current_node.prev_node.next_node = current_node.next_node
                    current_node.next_node.prev_node = current_node.prev_node
                break
            current_node = current_node.next_node

    def print_list(self):
        current_node = self.head
        while current_node is not None:
            print(current_node.value, end="<->")
            current_node = current_node.next_node
        print()


# Create a new doubly linked list
dll = DoublyLinkedList()
dll.append(23)
dll.append(54)
dll.append(78)
dll.append(90)
dll.add_begin(10)
dll.add_end(100)
dll.add_in_between(200,23)
dll.delete_at_beginning()
dll.delete_at_end()
dll.delete_in_between(54)
# Print the list
#dll.print_list()
#dll.traverse_forward()
#dll.traverse_backward()
# Delete a node from the list
#dll.delete(54)
# Print the updated list
dll.print_list()

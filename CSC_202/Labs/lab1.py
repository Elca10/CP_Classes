#from doubly_linked_list import DoublyLinkedList

from dataclasses import dataclass
@dataclass
class Node:
    value: int
    prev_node: None
    next_node: None


@dataclass
class doubly_Ordered_List:
    '''A doubly-linked ordered list of items, from lowest (head of list) to highest (tail of
    list)'''
    #linked: 'DoublyLinkedList' = DoublyLinkedList()
    head: 'Node' = None
    tail: 'Node' = None

    def is_empty(self):
        '''Returns True if OrderedList is empty
        MUST have O(1) performance'''

        if self.head == None:
            return True
        return False


    def add(self, item):
        '''Adds an item to OrderedList, in the proper location based on ordering of items
        from lowest (at head of list) to highest (at tail of list) and returns True.
        If the item is already in the list, do not add it again and return False.
        MUST have O(n) average-case performance'''
        new_node = Node(item, None, None)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
            return True
        else:
            current_node = self.head
            while current_node is not None: #and current_node.value < new_node.value:
                # if item is in the list already
                if current_node.value == new_node.value:
                    return False
                # if at the end of the list, add node to the end (biggest number) 
                if current_node.next_node is None and current_node.value < new_node.value:
                    new_node.prev_node = current_node
                    self.tail = new_node
                    current_node.next_node = new_node
                    return True
                # keep going while it's smaller
                if current_node.value < new_node.value:
                    current_node = current_node.next_node
                else:
                    # add it in the spot
                    new_node.next_node = current_node
                    new_node.prev_node = current_node.prev_node
                    # if adding it to the beginning of the list
                    if current_node.prev_node is None:
                        self.head = new_node
                    else:
                        current_node.prev_node.next_node = new_node
                    current_node.prev_node = new_node
                    return True


    def remove(self, item):
        '''Removes the first occurrence of an item from OrderedList. If item is removed (was
        in the list) returns True. If item was not removed (was not in the list) returns False
        MUST have O(n) average-case performance'''

        current_node = self.head
        while current_node is not None:
            if current_node.value == item:
                # item is only item in the list
                #       None - N1 - None
                if current_node.prev_node is None and current_node.next_node is None:
                    self.tail = None
                    self.head = None
                # item is at beginning of list
                #       None - N1 - N2
                elif current_node.prev_node is None:
                    self.head = current_node.next_node
                    current_node.next_node.prev_node = self.head
                # item is at the end of the list
                #       N2 - N3 - None
                elif current_node.next_node is None:
                    self.tail = current_node.prev_node
                    current_node.prev_node.next_node = self.tail
                # item is between two nodes
                #       N1 - N2 - N3
                else:
                    current_node.prev_node.next_node = current_node.next_node
                    current_node.next_node.prev_node = current_node.prev_node
                return True
            current_node = current_node.next_node
        return False



    def index(self, item):
        '''Returns index of the first occurrence of an item in OrderedList (assuming head of
        list is index 0).
        If item is not in list, return None
        MUST have O(n) average-case performance'''
        current_node = self.head
        index = 0
        while current_node is not None:
            if current_node.value == item:
                return index
            index += 1
            current_node = current_node.next_node
        return None

    def pop(self, index):
        '''Removes and returns item at index (assuming head of list is index 0).
        If index is negative or >= size of list, raises IndexError
        MUST have O(n) average-case performance'''
        if index < 0:
            raise IndexError # this might not be the right formatting
        current_node = self.head
        current_index = 0

        while current_node is not None:
            if current_index == index:
                # - return current_node.value
                # - prev_node.next_node = next_node
                # - next_node.prev_node = prev_node



                # item is only item in the list
                #       None - N1 - None
                if current_node.prev_node is None and current_node.next_node is None:
                    self.tail = None
                    self.head = None
                # item is at index 1 - beginning of list
                #       None - N1 - N2
                elif current_node.prev_node is None:
                    self.head = current_node.next_node
                    current_node.next_node.prev_node = self.head
                # item is at the end of the list
                #       N2 - N3 - None
                elif current_node.next_node is None:
                    self.tail = current_node.prev_node
                    current_node.prev_node.next_node = self.tail
                # item is between two nodes
                #       N1 - N2 - N3
                else:
                    current_node.prev_node.next_node = current_node.next_node
                    current_node.next_node.prev_node = current_node.prev_node

                # if current_node.prev_node is not None:
                #     current_node.prev_node.next_node = current_node.next_node
                # current_node.next_node.prev_node = current_node.prev_node
                return current_node.value
            current_index += 1
            current_node = current_node.next_node

        # if we've gone through the list, and we still haven't reached the index, that means index >= size of list
        raise IndexError



    def search(self, item, current_node=0): # added current_node=head
        '''Searches OrderedList for item, returns True if item is in list, False otherwise"
        To practice recursion, this method must call a RECURSIVE method that
        will search the list
        MUST have O(n) average-case performance'''
        # first starting out
        if current_node == 0:
            current_node = self.head

        if current_node is None:
            return False
        if current_node.value == item:
            return True
        
        return self.search(item, current_node.next_node)

    def python_list(self):
        '''Return a Python list representation of OrderedList, from head to tail
        For example, list with integers 1, 2, and 3 would return [1, 2, 3]
        MUST have O(n) performance'''
        l = []
        current_node = self.head
        while current_node is not None:
            l.append(current_node.value)
            current_node = current_node.next_node
        return l


    def python_list_reversed(self, l=None, current_node=0):# added l=[], current_node = tail
        '''Return a Python list representation of OrderedList, from tail to head, using
        recursion
        For example, list with integers 1, 2, and 3 would return [3, 2, 1]
        To practice recursion, this method must call a RECURSIVE method that
        will return a reversed list
        MUST have O(n) performance'''
        
        # at the start
        if current_node == 0:
            current_node = self.tail
        if l is None:
            l = []

        l.append(current_node.value)
        if current_node.prev_node is None:
            return l
        
        return self.python_list_reversed(l, current_node.prev_node)



    def size(self, s=0, current_node=0): # added s=0, current_node=head
        '''Returns number of items in the OrderedList
        To practice recursion, this method must call a RECURSIVE method that
        will count and return the number of items in the list
        MUST have O(n) performance'''
        if current_node == 0:
            current_node = self.head
        
        
        if current_node is None:
            return s
        
        s += 1

        return self.size(s, current_node.next_node)


    #### ADDED THIS FROM doubly_linked_list.py
    def print_list(self):
        current_node = self.head
        while current_node is not None:
            print(current_node.value, end="<->")
            current_node = current_node.next_node
        print()







# TEST CASES
# HEADERS
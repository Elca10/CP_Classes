from dataclasses import dataclass


class MaxHeap:
# ⭐
    def __init__(self, capacity:int=0):
        self.capacity = capacity
        self.heap_array = []#[None]*self.capacity
    
# ⭐ 
    def enqueue(self, item):
        '''inserts "item" into the heap, returns true if successful, false
        if there is no room in the heap
        "item" can be any primitive or ***object*** that can be
        compared with other
        items using the < operator'''

        # THE TEST CASES DON'T LINE UP WITH THIS:
        # # no room in heap
        # if self.is_full():
        #     return False
        if self.is_full():
            self.capacity += 1

        # add item to the end of the heap
        self.heap_array.append(item)
        # restore heap structure
        self.perc_up(len(self.heap_array)-1) # last item


        return True
        

# ⭐
    def peek(self):
        '''returns max without changing the heap, returns None if the heap
        is empty'''
        if self.is_empty():
            return None
        return self.heap_array[0]


# ⭐  
    def dequeue(self):
        '''returns max and removes it from the heap and restores the heap
        property
        returns None if the heap is empty'''
        if self.is_empty():
            return None

        # swap first and last items, remove the last (which is the max)
        self.heap_array[0], self.heap_array[-1] = self.heap_array[-1], self.heap_array[0]
        max = self.heap_array.pop(-1)

        # bubble down
        self.perc_down(0)

        return max


# ⭐
    def contents(self):
        '''returns a list of contents of the heap in the order it is
        stored internal to the heap.
        (This may be useful for in testing your implementation.)'''
        return self.heap_array

# ⭐ 
    def build_heap(self, alist):
        '''Discards all items in the current heap and builds a heap from
        the items in alist using the bottom-up construction method.
        If the capacity of the current heap is less than the number of
        items in alist, the capacity of the heap will be increased to
        accommodate the items in alist'''

        # erase existing heap and overwrite with empty heap of appropriate size
        self.capacity = len(alist)
        self.heap_array = []#[None] * self.capacity

        # build heap
        for item in alist:
            # insert item into heap
            self.enqueue(item) # don't have to worry about this not working, since the capacity will be the right size


# ⭐
    def is_empty(self):
        '''returns True if the heap is empty, false otherwise'''
        if len(self.heap_array) == 0:
            return True
        # # if all values are None (i.e. heap is empty)
        # if self.heap_array.count(None) == self.capacity:
        #     return True
        # # heap has items already
        return False

# ⭐
    def is_full(self):
        '''returns True if the heap is full, false otherwise'''
        # # still at least one empty slot
        # if None in self.heap_array:
        #     return False
        
        if len(self.heap_array) < self.capacity:
            return False
        # heap is full
        return True

# ⭐
    def get_capacity(self):
        '''this is the maximum number of a entries the heap can hold
        1 less than the number of entries that the array allocated to hold
        the heap can hold'''
        return self.capacity

# ⭐
    def get_size(self):
        '''the actual number of elements in the heap, not the capacity'''
        size = 0
        for item in self.heap_array:
            if item: # if it's not None
                size += 1
        return size

# ⭐ 
    def perc_down(self, i):
        '''where the parameter i is an index in the heap and perc_down
        moves the element stored
        at that location to its proper place in the heap rearranging
        elements as it goes.'''
        if i < 0 or i >= len(self.heap_array):
            return

        current = self.heap_array[i]
        left_child_index = 2 * i + 1
        if left_child_index < len(self.heap_array):
            left_child = self.heap_array[left_child_index]
        else:
            left_child = None
        right_child_index = 2 * i + 2
        if right_child_index < len(self.heap_array):
            right_child = self.heap_array[right_child_index]
        else:
            right_child = None
        
        heaped = False
        while not heaped:
            # current = 2, right_child = 5, left_child = 6
            if right_child and current < right_child:
                if not left_child or right_child > left_child:
                    # swap
                    self.heap_array[i], self.heap_array[right_child_index] = self.heap_array[right_child_index], self.heap_array[i]
                    # update vars
                    i = right_child_index
                    current = self.heap_array[i]
                    right_child_index = 2 * i + 1
                    if right_child_index >= len(self.heap_array):
                        heaped = True
                    else:
                        right_child = self.heap_array[right_child_index]
            if left_child and current < left_child:
                # swap 
                self.heap_array[i], self.heap_array[left_child_index] = self.heap_array[left_child_index], self.heap_array[i]
                # update vars
                i = left_child_index
                current = self.heap_array[i]
                left_child_index = 2 * i + 1
                if left_child_index >= len(self.heap_array):
                    heaped = True
                else:
                    left_child = self.heap_array[left_child_index]
            else: #if current >= left_child and current >= right_child:
                heaped = True


# ⭐ 
    def perc_up(self, i):
        '''where the parameter i is an index in the heap and perc_up moves
        the element stored
        at that location to its proper place in the heap rearranging
        elements as it goes.'''
        if i < 0 or i >= len(self.heap_array):
            return 
        current = self.heap_array[i]
        parent_index = (i - 1) // 2
        parent = self.heap_array[parent_index]

        while current > parent and i > 0:
            # swap them 
            self.heap_array[i], self.heap_array[parent_index] = self.heap_array[parent_index], self.heap_array[i]
            i = parent_index
            current = self.heap_array[i]
            parent_index = (i-1)//2
            parent = self.heap_array[parent_index]
        

    def heap_sort_ascending(self, alist):
        '''perform heap sort on input alist in ascending order
        This method will discard the current contents of the heap, build a
        new heap using
        the items in alist, then mutate alist to put the items in
        ascending order'''
        self.build_heap(alist)
        sorted_list = []
        while len(self.heap_array) >=1:
            sorted_list.append(self.dequeue())
        return sorted_list[::-1] # reversed for ascending order




test_heap = MaxHeap(7)

class MaxHeap:
    def __init__(self):
        self.heap = []

    def __str__(self):
        return ' '.join([str(i) for i in self.heap])

    def parent(self, i):
        return (i - 1) // 2

    def left_child(self, i):
        return 2 * i + 1

    def right_child(self, i):
        return 2 * i + 2

    def swap(self, i, j):
        self.heap[i], self.heap[j] = self.heap[j], self.heap[i]

    def insert(self, data):
        self.heap.append(data)
        current_index = len(self.heap) - 1
        while current_index > 0 and self.heap[current_index] > self.heap[self.parent(current_index)]:
            parent_index = self.parent(current_index)
            self.swap(current_index, parent_index)
            current_index = parent_index

    def extract_max(self):
        if not self.heap:
            raise IndexError("Heap is empty")
        max_element = self.heap[0]
        last_element = self.heap.pop()
        if self.heap:
            self.heap[0] = last_element
            self.heapify(0)
        return max_element

    def heapify(self, i):
        largest = i
        left_child_index = self.left_child(i)
        right_child_index = self.right_child(i)
        if left_child_index < len(self.heap) and self.heap[left_child_index] > self.heap[largest]:
            largest = left_child_index
        if right_child_index < len(self.heap) and self.heap[right_child_index] > self.heap[largest]:
            largest = right_child_index
        if largest != i:
            self.swap(i, largest)
            self.heapify(largest)


# Example usage:
max_heap = MaxHeap()
max_heap.insert(12)
max_heap.insert(10)
max_heap.insert(15)
max_heap.insert(20)
print(max_heap)  # Output: 20 12 15 10

print(max_heap.extract_max())  # Output: 20
print(max_heap)  # Output: 15 12 10

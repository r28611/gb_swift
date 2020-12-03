class Queue<T> {
    private var elements: [T] = []
    
    func pop() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeFirst()
    }
    
    func push(_ element: T) {
        elements.append(element)
    }
    
    func filter(predicate: (T) -> Bool ) -> [T] {
        var tmpArray = [T]()
        for element in elements {
            if predicate(element) {
                tmpArray.append(element)
            }
        }
        return tmpArray
    }
    
    subscript(indices: UInt ...) -> [T?] {
        var tmpArray = [T?]()
        for index in indices {
            if index > self.elements.count {
                tmpArray.append(nil)
            } else {
                tmpArray.append(self.elements[Int(index)])
            }
        }
        return tmpArray
    }
}

let array = [1, 3, 5, 55, 2, 3, 6]
let queue = Queue<Int>()
for item in array {
    queue.push(item)
}

queue[1, 2, 10, 6]

queue.filter {
    (element: Int) -> Bool in
    return (element + 1) != 3
}

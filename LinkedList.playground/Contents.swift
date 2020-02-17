import Foundation
import SpriteKit
import PlaygroundSupport

public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    //MARK: - Head
    private var head: Node?
    
    //MARK: - isEmpty
    public var isEmpty: Bool {
        return head == nil
    }
    
    //MARK: - First and Last
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    //MARK: - Count
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    //MARK: - Append, insert, removeAll, removeLast, removeAt
    public func append(_ value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func insert(_ node: Node, atIndex index: Int) {
        let newNode = node
        if index == 0 {
            newNode.next = self.head
            self.head?.previous = newNode
            self.head = newNode
        } else {
            let prev = self.node(atIndex: index-1)
            let next = prev.next
            
            newNode.previous = prev
            newNode.next = next
            prev.next = newNode
            next?.previous = newNode
        }
    }
    
    public func removeAll() {
        self.head = nil
    }
    
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func removeLast() -> T {
        assert(!self.isEmpty)
        return remove(node: self.last!)
    }
    
    public func removeAt(_ index: Int) -> T {
        let node = self.node(atIndex: index)
//        assert(node != nil)
        return remove(node: node)
    }
    
    //MARK: - Recover a Node
    public func node(atIndex index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { // Index Out of Bounds
                    break
                }
            }
            return node!
        }
    }
    
    //MARK: - Subscript
    public subscript(index: Int) -> T {
        let node = self.node(atIndex: index)
        return node.value
    }
    
    //MARK: - Reverse
    fileprivate func reverse() {
        var node = self.head
        // tail = node // Needs a tail
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            self.head = currentNode
        }
    }
    
    //MARK: - Map, Filter
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while node != nil {
            result.append(transform(node!.value))
            node = node!.next
        }
        return result
    }
    
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while node != nil {
            if predicate(node!.value) {
                result.append(node!.value)
            }
            node = node!.next
        }
        return result
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = self.head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", "}
        }
        return s + "]"
    }
}

//let list = LinkedList<String>()
//list.append("Hello")
//list.append("World!")
//
//let m = list.map { s -> Int in
//    return s.count
//}
//print(m)
//
//list.insert(LinkedListNode<String>(value: "Swift"), atIndex: 1)
//
//list[0]
//list[1]
//list[2]



PlaygroundPage.current.finishExecution()

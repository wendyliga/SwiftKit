/**
SwiftKit

Copyright (c) 2020 Wendy Liga. Licensed under the MIT license, as follows:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation

/**
 Add ability to type to have traceable history.
 property with this propertyWrapper will automatically have version. if propery is set, the set value will enter history.
 
 example
 ```swift
 struct User {
     @Traceable
     var name: String
 }
 ```
 
 to see more, check `Traceable+Tests.swift`
 */
@propertyWrapper
public struct Traceable<Type> {
    private let maxSize: Int

    private(set) var cursor: Int

    // minimum 1 value
    private(set) var versions: [Type] = []

    public var wrappedValue: Type {
        set {
            insert(newValue: newValue)
        } get {
            versions[cursor]
        }
    }

    public init(wrappedValue: Type, maxSize: Int = 50) {
        self.maxSize = maxSize
        cursor = 0
        versions.append(wrappedValue)
    }

    /**
     Insert new history to stack
     
     - Parameter newValue: new history
     */
    private mutating func insert(newValue: Type) {
        versions.append(newValue)
        cursor += 1

        // if over max size, remove the oldest
        if versions.count > maxSize {
            versions.removeFirst()
            cursor -= 1
        }
    }

    /**
     Remove last history
     */
    public mutating func revert() {
        guard versions.endIndex > 1 else { return }

        versions.removeLast()
        cursor -= 1
    }

    /**
     Move cursor to spesific index
     
     - Parameter cursor: index of history
     */
    public mutating func checkout(_ cursor: Int) {
        guard versions.startIndex < cursor, cursor < versions.endIndex else { return }

        self.cursor = cursor
    }

    /**
     Remove all history, and left 1 last element
     */
    public mutating func flush() {
        guard versions.endIndex > 1 else { return }

        // only 2 items
        guard versions.endIndex != 1 else {
            versions.remove(at: 0)
            cursor = 0
            return
        }

        // more than 2 items
        let range = versions.startIndex ... (versions.endIndex - 2)
        versions.removeSubrange(range)
        cursor = 0
    }

    /**
     Safely access history, if index is out of bounds, will return nil
     
     - Parameter safe: index of history
     - Returns: history based on index
     */
    public subscript(safe index: Int) -> Type? {
        versions[safe: index]
    }

    /**
     Get first history
     - Returns: First history
     */
    public func first() -> Type? {
        versions.first
    }

    /**
     Get first item that meet condition
     
     - Parameter predicate: Condition, if true, will return spesific history
     - Returns: History that meet given condition
     */
    public func first(where predicate: (Type) throws -> Bool) rethrows -> Type? {
        try versions.first(where: predicate)
    }
    
    /**
     Get last history
     - Returns: Last history
     */
    public func last() -> Type? {
        versions.last
    }

    /**
     Get last item that meet condition
     
     - Parameter predicate: Condition, if true, will return spesific history
     - Returns: History that meet given condition
     */
    public func last(where predicate: (Type) throws -> Bool) rethrows -> Type? {
        try versions.last(where: predicate)
    }
    
    /**
     Get all version
     
     - Returns: All version on current value
     */
    public func all() -> [Type] {
        versions
    }
}

extension Traceable: Equatable where Type: Equatable {}
extension Traceable: Hashable where Type: Hashable {}

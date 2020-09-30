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
 
 property with this propertyWrapper will aumatically have version. if propery is set, the set value will enter history.
 */
@propertyWrapper
internal struct Traceable<Type> {
    private let maxSize: Int

    internal private(set) var cursor: Int

    // minimum 1 value
    internal private(set) var versions: [Type] = []

    internal var wrappedValue: Type {
        set {
            insert(newValue: newValue)
        } get {
            versions[cursor]
        }
    }

    internal init(wrappedValue: Type, maxSize: Int = 50) {
        self.maxSize = maxSize
        cursor = 0
        versions.append(wrappedValue)
    }

    private mutating func insert(newValue: Type) {
        versions.append(newValue)
        cursor += 1

        // if over max size, remove the oldest
        if versions.count > maxSize {
            versions.removeFirst()
            cursor -= 1
        }
    }

    internal mutating func revert() {
        guard versions.endIndex > 1 else { return }

        versions.removeLast()
        cursor -= 1
    }

    internal mutating func checkout(_ cursor: Int) {
        guard versions.startIndex < cursor, cursor < versions.endIndex else { return }

        self.cursor = cursor
    }

    /**
     Remove all history, and left 1 last element
     */
    internal mutating func flush() {
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

    internal subscript(safe index: Int) -> Type? {
        versions[safe: index]
    }

    internal func first() -> Type? {
        versions.first
    }

    internal func first(where predicate: (Type) throws -> Bool) rethrows -> Type? {
        try versions.first(where: predicate)
    }

    internal func last() -> Type? {
        versions.last
    }

    internal func last(where predicate: (Type) throws -> Bool) rethrows -> Type? {
        try versions.last(where: predicate)
    }
}

extension Traceable: Equatable where Type: Equatable {}
extension Traceable: Hashable where Type: Hashable {}

/**
 SwiftKit
 
 Copyright (c) 2021 Wendy Liga. Licensed under the MIT license, as follows:
 
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
 Property wrapper to set default value if spesific condition is fulfilled
 
 example
 ```swift
 struct User {
     @DefaultValue(if: { $0.isEmpty }, then: "admin", initialValue: "")
     var password: String
 }
 ```
 
 if everytime password is set, and empty, then we use "admin" as default value
 */
@propertyWrapper
public struct DefaultValue<T> {
    public typealias Condition = (T) -> Bool
    public let condition: Condition
    public let defaultValue: T
    var _wrappedValue: T
    public var wrappedValue: T {
        get {
            _wrappedValue
        }
        set {
            _wrappedValue = Self.validate(condition: condition, then: defaultValue, else: newValue)
        }
    }
    
    public init(if condition: @escaping Condition, then defaultValue: T, initialValue: T) {
        self.condition = condition
        self.defaultValue = defaultValue
        self._wrappedValue = Self.validate(condition: condition, then: defaultValue, else: initialValue)
    }
    
    public static func validate(
        condition: @escaping Condition,
        then defaultValue: @autoclosure () throws -> T,
        else newValue: @autoclosure () throws -> T
    ) rethrows -> T {
        let newValue = try newValue()
        
        if condition(newValue) {
            return try defaultValue()
        } else {
            return newValue
        }
    }
}

extension DefaultValue: Equatable where T: Equatable {
    public static func == (lhs: DefaultValue<T>, rhs: DefaultValue<T>) -> Bool {
        lhs._wrappedValue == rhs._wrappedValue
    }
}

extension DefaultValue: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_wrappedValue)
    }
}


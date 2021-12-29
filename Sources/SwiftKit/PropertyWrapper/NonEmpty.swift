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
 `NonEmpty` as `PropertyWrapper`
 
 example
 ```swift
 internal struct User {
     @NonEmpty
     var email: String?
     
     internal init(email: String?) {
         self.email = email
     }
 }
 ```
 
 if value email is string empty, then it will automatically set to `nil`
 */
@propertyWrapper
public struct NonEmpty {
    private var _wrappedValue: String?
    public var wrappedValue: String? {
        get {
            _wrappedValue
        }
        set {
            _wrappedValue = newValue?.nonEmpty
        }
    }
    
    public init(_ wrappedValue: String?) {
        _wrappedValue = wrappedValue?.nonEmpty
    }
}

extension NonEmpty: Equatable {
    public static func == (lhs: NonEmpty, rhs: NonEmpty) -> Bool {
        lhs._wrappedValue == rhs._wrappedValue
    }
}

extension NonEmpty: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_wrappedValue)
    }
}

extension NonEmpty: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

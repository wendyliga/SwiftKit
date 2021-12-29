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

import XCTest
@testable import SwiftKit

final class DefaultValueTests: XCTestCase {
    static var allTests = [
        ("test_defaultValue_condition_fulfilled", test_defaultValue_condition_fulfilled),
        ("test_defaultValue_condition_not_fulfilled", test_defaultValue_condition_not_fulfilled),
        ("test_defaultValue_equatable", test_defaultValue_equatable),
        ("test_defaultValue_hashable", test_defaultValue_hashable)
    ]
  
    struct User {
        @DefaultValue(if: { $0.isEmpty }, then: "admin", initialValue: "")
        var password: String
        
        init(password: String) {
            self.password = password
        }
    }
    
    func test_defaultValue_condition_fulfilled() {
        let user = User(password: "")
        XCTAssertEqual(user.password, "admin")
    }
    
    func test_defaultValue_condition_not_fulfilled() {
        let user = User(password: "password")
        XCTAssertEqual(user.password, "password")
    }
    
    func test_defaultValue_equatable() {
        let user = User(password: "hello_world")
        XCTAssertEqual(user.password, "hello_world")
    }
    
    func test_defaultValue_hashable() {
        let rawString = "hello_world"
        let user = User(password: "hello_world")
        
        XCTAssertEqual(rawString.hashValue, user.password.hashValue)
    }
}

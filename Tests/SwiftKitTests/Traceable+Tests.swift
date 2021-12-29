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

final class TraceableTests: XCTestCase {
    static var allTests = [
        ("test_traceable_revert", test_traceable_revert),
        ("test_traceable_checkout", test_traceable_checkout),
        ("test_traceable_flush", test_traceable_flush),
        ("test_traceable_subscript_inbounds", test_traceable_subscript_inbounds),
        ("test_traceable_subscript_out_of_bounds", test_traceable_subscript_out_of_bounds),
        ("test_traceable_first_and_last", test_traceable_first_and_last),
        ("test_traceable_first_and_last_with_condition", test_traceable_first_and_last_with_condition),
    ]
  
    struct User {
        @Traceable
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        // helper access propertyWrapper function
        mutating func revert() {
            _name.revert()
        }
        
        mutating func checkout(index: Int) {
            _name.checkout(index)
        }
        
        func getItemWithSubscript(index: Int) -> String? {
            _name[safe: index]
        }
        
        mutating func flush() {
            _name.flush()
        }
        
        var all: [String] {
            _name.all()
        }
        
        var first: String? {
            _name.first()
        }
        
        var last: String? {
            _name.last()
        }
        
        func first(where condition: (String) throws -> Bool) rethrows -> String? {
            try _name.first(where: condition)
        }
        
        func last(where condition: (String) throws -> Bool) rethrows -> String? {
            try _name.last(where: condition)
        }
    }
    
    func test_traceable_revert() {
        var user = User(name: "jhon doe")
        user.name = "alice"
        user.revert()
        
        XCTAssertEqual(user.name, "jhon doe")
    }
    
    func test_traceable_checkout() {
        var user = User(name: "jhon doe")
        user.name = "alice"
        user.name = "gaben"
        user.name = "chiri"
        
        // move cursor to index 1, to move back to alice
        user.checkout(index: 1)
        
        XCTAssertEqual(user.name, "alice")
        XCTAssertEqual(user.all, ["jhon doe", "alice", "gaben", "chiri"])
    }
    
    func test_traceable_flush() {
        var user = User(name: "jhon doe")
        user.name = "alice"
        user.name = "gaben"
        user.name = "chiri"
        
        // move cursor to index 1, to move back to alice
        user.flush()
        
        XCTAssertEqual(user.name, "chiri")
        XCTAssertEqual(user.all, ["chiri"])
    }
    
    func test_traceable_subscript_inbounds() {
        var user = User(name: "jhon doe")
        user.name = "alice"
        user.name = "gaben"
        user.name = "chiri"
        
        XCTAssertEqual(user.getItemWithSubscript(index: 1), "alice")
    }
    
    func test_traceable_subscript_out_of_bounds() {
        var user = User(name: "jhon doe")
        user.name = "alice"
        user.name = "gaben"
        user.name = "chiri"
        
        XCTAssertEqual(user.getItemWithSubscript(index: 100), nil)
    }
    
    func test_traceable_first_and_last() {
        var user = User(name: "jhon doe")
        user.name = "alice"
        user.name = "gaben"
        user.name = "chiri"
        
        XCTAssertEqual(user.first, "jhon doe")
        XCTAssertEqual(user.last, "chiri")
    }
    
    func test_traceable_first_and_last_with_condition() {
        var user = User(name: "jhon doe")
        user.name = "xxxxx"
        user.name = "alice"
        user.name = "gaben"
        user.name = "chiri"
        user.name = "abcba"
        
        
        let firstPalindrome = user.first(where: { $0 == String($0.reversed()) })
        let lastPalindrome = user.last(where: { $0 == String($0.reversed()) })
        
        XCTAssertEqual(firstPalindrome, "xxxxx")
        XCTAssertEqual(lastPalindrome, "abcba")
    }
}

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

internal final class NonEmptyTests: XCTestCase {
    internal static var allTests = [
        ("test_non_empty_fulfilled", test_non_empty_fulfilled),
        ("test_non_empty_not_fulfilled", test_non_empty_not_fulfilled),
        ("test_non_empty_equatable", test_non_empty_equatable),
        ("test_non_empty_hashable", test_non_empty_hashable)
    ]
  
    internal struct User {
        @NonEmpty
        var email: String?
    }
    
    internal func test_non_empty_fulfilled() {
        let user = User(email: "")
        XCTAssertEqual(user.email, nil)
    }
    
    internal func test_non_empty_not_fulfilled() {
        let user = User(email: "user@email.com")
        XCTAssertEqual(user.email, "user@email.com")
    }
    
    internal func test_non_empty_equatable() {
        let user = User(email: "user@email.com")
        XCTAssertEqual(user.email, "user@email.com")
    }
    
    internal func test_non_empty_hashable() {
        let rawString: String? = "hello_world"
        let user = User(email: "hello_world")
        
        XCTAssertEqual(rawString.hashValue, user.email.hashValue)
    }
}

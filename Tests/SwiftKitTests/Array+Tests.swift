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

final class ArrayTests: XCTestCase {
    
    static var allTests = [
        ("test_arraySafeSubscript_withValidValue", test_arraySafeSubscript_withValidValue),
        ("test_arraySafeSubscript_withOutOfBoundValue", test_arraySafeSubscript_withOutOfBoundValue),
        ("test_arraySafeSubscript_withNegatifValue", test_arraySafeSubscript_withNegatifValue),
        ("test_arrayAfterSubscript_withValidValue", test_arrayAfterSubscript_withValidValue),
        ("test_arrayAfterSubscript_withOutOfBoundValue", test_arrayAfterSubscript_withOutOfBoundValue),
        ("test_arrayAfterSubscript_withNegatifValue", test_arrayAfterSubscript_withNegatifValue),
        ("test_isNotEmpty_withNonEmptyArray",test_isNotEmpty_withNonEmptyArray),
        ("test_isNotEmpty_withEmptyArray",test_isNotEmpty_withEmptyArray),
    ]
    
    func test_arraySafeSubscript_withValidValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[safe: 3], 4)
    }
    
    func test_arraySafeSubscript_withOutOfBoundValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[safe: 100], nil)
    }
    
    func test_arraySafeSubscript_withNegatifValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[safe: -1], nil)
    }
    
    func test_arrayAfterSubscript_withValidValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[after: 3], 5)
    }
    
    func test_arrayAfterSubscript_withOutOfBoundValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[after: 100], nil)
    }
    
    func test_arrayAfterSubscript_withNegatifValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[after: -1], nil)
    }
    
    func test_isNotEmpty_withNonEmptyArray() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array.isNotEmpty, true)
    }
    
    func test_isNotEmpty_withEmptyArray() {
        let array: [String] = []
        
        XCTAssertEqual(array.isNotEmpty, false)
    }
}

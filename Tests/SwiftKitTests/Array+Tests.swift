import XCTest

@testable import SwiftKit

internal final class ArrayTests: XCTestCase {
    
    internal static var allTests = [
        ("test_arraySafeSubscript_withValidValue", test_arraySafeSubscript_withValidValue),
        ("test_arraySafeSubscript_withOutOfBoundValue", test_arraySafeSubscript_withOutOfBoundValue),
        ("test_arraySafeSubscript_withNegatifValue", test_arraySafeSubscript_withNegatifValue),
        ("test_arrayAfterSubscript_withValidValue", test_arrayAfterSubscript_withValidValue),
        ("test_arrayAfterSubscript_withOutOfBoundValue", test_arrayAfterSubscript_withOutOfBoundValue),
        ("test_arrayAfterSubscript_withNegatifValue", test_arrayAfterSubscript_withNegatifValue),
        ("test_isNotEmpty_withNonEmptyArray",test_isNotEmpty_withNonEmptyArray),
        ("test_isNotEmpty_withEmptyArray",test_isNotEmpty_withEmptyArray),
    ]
    
    internal func test_arraySafeSubscript_withValidValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[safe: 3], 4)
    }
    
    internal func test_arraySafeSubscript_withOutOfBoundValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[safe: 100], nil)
    }
    
    internal func test_arraySafeSubscript_withNegatifValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[safe: -1], nil)
    }
    
    internal func test_arrayAfterSubscript_withValidValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[after: 3], 5)
    }
    
    internal func test_arrayAfterSubscript_withOutOfBoundValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[after: 100], nil)
    }
    
    internal func test_arrayAfterSubscript_withNegatifValue() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array[after: -1], nil)
    }
    
    internal func test_isNotEmpty_withNonEmptyArray() {
        let array = [1,2,3,4,5]
        
        XCTAssertEqual(array.isNotEmpty, true)
    }
    
    internal func test_isNotEmpty_withEmptyArray() {
        let array: [String] = []
        
        XCTAssertEqual(array.isNotEmpty, false)
    }
}

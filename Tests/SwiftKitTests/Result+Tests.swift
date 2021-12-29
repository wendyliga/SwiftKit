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

final class ResultTests: XCTestCase {
    static var allTests = [
        ("test_successValue_onSuccessResult", test_successValue_onSuccessResult),
        ("test_successValue_onFailureResult", test_successValue_onFailureResult),
        ("test_failureValue_onSuccessResult", test_failureValue_onSuccessResult),
        ("test_failureValue_onFailureResult", test_failureValue_onFailureResult),
    ]
    
    func dummySuccessResult() -> Result<Int, GeneralError> {
        return .success(0)
    }
    
    func dummyFailureResult() -> Result<Int, GeneralError> {
        return .failure(GeneralError.unidentifiedError)
    }
    
    func test_successValue_onSuccessResult() {
        XCTAssertEqual(dummySuccessResult().successValue, 0)
    }
    
    func test_successValue_onFailureResult() {
        XCTAssertEqual(dummyFailureResult().successValue, nil)
    }
    
    func test_failureValue_onSuccessResult() {
        XCTAssertEqual(dummySuccessResult().failureValue, nil)
    }
    
    func test_failureValue_onFailureResult() {
        XCTAssertEqual(dummyFailureResult().failureValue, GeneralError.unidentifiedError)
    }
}

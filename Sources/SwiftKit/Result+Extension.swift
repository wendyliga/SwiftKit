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

extension Result {
    /// Get non success Result, if current Result is success return nil, if not return self
    public var nonSuccessResult: Self? {
        if case .failure(_) = self {
            return self
        }
        
        return nil
    }
    
    /// Get non failure Result, if current Result is failure return nil, if not return self
    public var nonFailureResult: Self? {
        if case .success(_) = self {
            return self
        }
        
        return nil
    }
    
    /// Force get value from Result, make sure you make sure your Result is not failure.
    public var value: Success! {
        return try! self.get()
    }
    
    /// Get error value from Result
    public var error: Error! {
        do {
            let result = try self.get()
            
            assertionFailure("\(result) is not failure")
            return GeneralError.unidentifiedError
        } catch let error {
            return error
        }
    }
    
    /// Get result value and discard the returnable value
    ///
    /// This function is wrapper of `get` function with discardable result
    @discardableResult
    public func getAndForget() throws -> Success {
        try get()
    }
}


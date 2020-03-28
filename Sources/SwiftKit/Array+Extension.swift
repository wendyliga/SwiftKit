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

extension Array {
    /**
     Access Array item safely, get rid of out of range fatal error
     
     - Parameter index: Array index you want to access
     
     ## How to Use:
     ```
     let array = [1,2,3,4,5,6,7,8,9]
     
     print(array[safe: 3]) -> result 4
     print(array[safe: 100]) -> result nil
     ```
     
     ## Testing:
     I do several test on this function, you can check it here https://gist.github.com/wendyliga/7e9d97eea01dcabf3d65664a294f40a0
     */
    public subscript(safe index: Int) -> Element? {
        guard startIndex <= index && index < endIndex else {
            return nil
        }
        
        return self[index]
    }
    
    /**
     Access array item at after index safely
     
     - parameter after: array index after that you want to access
     
     ## How to Use:
     ```
     let array = [1,2,3,4,5,6,7,8,9]
     
     print(array[after: 3]) -> result 5
     print(array[after: 100]) -> result nil
     ```
     */
    public subscript(after index: Int) -> Element? {
        guard startIndex <= index && index < endIndex else {
            return nil
        }
        
        return self[index + 1]
    }
    
    /**
     Array that's not empty will be true
     */
    public var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

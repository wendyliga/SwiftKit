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

public enum GeneralError: Error, LocalizedError, Equatable {
    /**
     Multiple Error Generalization
     
     with this you can output one error from several errors
     */
    case multipleError([Error])
    
    /**
     Default unidentified Error
     */
    case unidentifiedError
    
    public var errorDescription: String? {
        switch self {
        case .multipleError(let errors):
            return errors.map { $0.localizedDescription }.stringValue()
        case .unidentifiedError:
            return "Unidentified Error"
        }
    }
    
    private var rawValue: Int {
        switch self {
        case .unidentifiedError:
            return 0
        /**
         need more improvement, as array of error should be checked
         */
        case .multipleError:
            return 1
        }
    }
    
    public static func == (lhs: GeneralError, rhs: GeneralError) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

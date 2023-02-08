/**
 SwiftKit
 
 Copyright (c) 2023 Wendy Liga. Licensed under the MIT license, as follows:
 
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

extension Shell {
    @available(macOS 10.13, *)
    @available(*, deprecated, message: "use execute with 'executableURL'")
    @discardableResult
    public static func execute(
        launchPath: String,
        currentDirectoryURL: URL? = nil,
        arguments: [String],
        stream result: @escaping (Shell.ResultStream) -> Void
    ) -> Shell.TerminationStatus {
        execute(
            executableURL: URL(fileURLWithPath: launchPath),
            currentDirectoryURL: currentDirectoryURL,
            arguments: arguments,
            stream: result
        )
    }
    
    @available(macOS 10.13, *)
    @discardableResult
    @available(*, deprecated, message: "use execute with 'executableURL'")
    public static func execute(
        launchPath: String,
        currentDirectoryURL: URL? = nil,
        arguments: [String]
    ) -> Shell.Result {
        Shell.execute(
            executableURL: URL(fileURLWithPath: launchPath),
            currentDirectoryURL: currentDirectoryURL,
            arguments: arguments
        )
    }
}

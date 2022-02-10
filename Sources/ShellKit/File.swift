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
import SwiftKit

public enum Shell {
    public typealias Result = (status: Int32, output: String?, errorOuput: String?)
    public typealias ResultStream = (output: String?, errorOuput: String?)
    public typealias TerminationStatus = Int32

    @discardableResult
    public static func execute(
        launchPath: String = "/usr/bin/env",
        arguments: [String],
        stream result: @escaping (Shell.ResultStream) -> Void
    ) -> Shell.TerminationStatus {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe

        let errorPipe = Pipe()
        task.standardError = errorPipe

        task.launch()
        
        // set observer
        let stdOutReading = pipe.fileHandleForReading
        stdOutReading.waitForDataInBackgroundAndNotify()
        
        let stdErrReading = pipe.fileHandleForReading
        stdErrReading.waitForDataInBackgroundAndNotify()
        
        // set listener
        var stdOutObserver: NSObjectProtocol!
        stdOutObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: stdOutReading,
            queue: nil
        ) { _ -> Void in
            let data = stdOutReading.availableData

            if data.count > 0 {
                if let output = String(data: data, encoding: String.Encoding.utf8) {
                    result((output: output.trim(), errorOuput: nil))
                }
                
                stdOutReading.waitForDataInBackgroundAndNotify()
            } else {
                // That means we've reached the end of the input.
                NotificationCenter.default.removeObserver(stdOutObserver!)
            }
        }
        
        var stdErrObserver: NSObjectProtocol!
        stdErrObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: stdErrReading,
            queue: nil
        ) { _ -> Void in
            let data = stdErrReading.availableData

            if data.count > 0 {
                if let output = String(data: data, encoding: String.Encoding.utf8) {
                    result((output: nil, errorOuput: output.trim()))
                }
                
                stdErrReading.waitForDataInBackgroundAndNotify()
            } else {
                // That means we've reached the end of the input.
                NotificationCenter.default.removeObserver(stdErrObserver!)
            }
        }
        
        // task runloop until finish
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    @discardableResult
    public static func execute(
        launchPath: String = "/usr/bin/env",
        arguments: [String]
    ) -> Shell.Result {
        var outputs = [String]()
        var errors = [String]()
        
        let terminationStatus = Shell.execute(launchPath: launchPath, arguments: arguments) { (output, error) in
            if let output = output {
                outputs.append(output)
            }
            
            if let error = error {
                errors.append(error)
            }
        }
        
        return (
            status: terminationStatus,
            output: outputs.joined(separator: "\n"),
            errorOuput: errors.joined(separator: "\n")
        )
    }
}


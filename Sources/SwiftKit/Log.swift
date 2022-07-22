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

/**
 A helper to send output to console/terminal/process
 */
public enum ConsoleLog {
    public enum ANSIColor: String {
        case black = "\u{001B}[0;30m"
        case red = "\u{001B}[0;31m"
        case green = "\u{001B}[0;32m"
        case yellow = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case magenta = "\u{001B}[0;35m"
        case cyan = "\u{001B}[0;36m"
        case white = "\u{001B}[0;37m"
        case clear = "\u{001B}[0;0m"
    }
    
    /// send error log to console/terminal/process
    /// - Parameters:
    ///   - value: error log
    ///   - _prefix: the prefix before the log, by default `Error: my error message`
    ///   - _prefixColor: ANSI color for the prefix
    public static func error(_ value: String, prefix _prefix: String? = "Error", _prefixColor: ANSIColor = .red) {
        var prefix = ""
        if let _prefix = _prefix {
            prefix += _prefixColor.rawValue + _prefix + ANSIColor.clear.rawValue + ": "
        }

        fputs(prefix + value + "\n", stderr)
    }

    /// send error log to console/terminal/process
    /// - Parameters:
    ///   - value: debug message
    ///   - _prefix: the prefix before the log, example `Foo: my message`
    ///   - _prefixColor: ANSI color for the prefix
    public static func debug(_ value: String, prefix _prefix: String? = nil, _prefixColor: ANSIColor = .green) {
        var prefix = ""
        if let _prefix = _prefix {
            prefix += _prefixColor.rawValue + _prefix + ANSIColor.clear.rawValue + ": "
        }

        fputs(prefix + value + "\n", stdout)
    }
}

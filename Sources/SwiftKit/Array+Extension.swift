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

extension Result {
    public var nonSuccessResult: Self? {
        if case .failure(_) = self {
            return self
        }
        
        return nil
    }
    
    public var nonFailureResult: Self? {
        if case .success(_) = self {
            return self
        }
        
        return nil
    }
    
    public var value: Success! {
        return try! self.get()
    }
    
    public var error: Error! {
        do {
            let result = try self.get()
            
            assertionFailure("\(result) is not failure")
            return GeneralError.unidentifiedError
        } catch let error {
            return error
        }
    }
}


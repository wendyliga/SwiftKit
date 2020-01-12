import Foundation

public enum GeneralError: Error, LocalizedError {
    case multipleError([Error])
    case unidentifiedError
    
    public var errorDescription: String? {
        switch self {
        case .multipleError(let errors):
            return errors.map { $0.localizedDescription }.stringValue()
        case .unidentifiedError:
            return "Unidentified Error"
        }
    }
}

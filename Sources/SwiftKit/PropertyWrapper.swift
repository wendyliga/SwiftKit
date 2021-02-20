import Foundation

@propertyWrapper
public struct Localized {
    private let value: String
    private let bundle: Bundle
    private let tableName: String
    
    public var wrappedValue: String {
        return NSLocalizedString(value, tableName: tableName, bundle: bundle, value: "**\(value)**", comment: "")
    }
    
    public init(
        wrappedValue value: String,
        _ bundle: Bundle,
        tableName: String
    ) {
        self.value = value
        self.bundle = bundle
        self.tableName = tableName
    }
    
    public init(wrappedValue value: String) {
        self.value = value
        self.bundle = .main
        self.tableName = "Localizable"
    }
}

@propertyWrapper
struct NoWhiteSpace {
    var value: String
    
    var wrappedValue: String {
        get {
            return value
        }
        set {
            value = newValue
        }
    }
    
    init(wrappedValue value: String) {
        self.value = value
    }
}


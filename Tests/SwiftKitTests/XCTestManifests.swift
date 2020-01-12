import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ArrayTests.allTests),
        testCase(StringTests.allTests),
        testCase(ResultTests.allTests),
    ]
}
#endif

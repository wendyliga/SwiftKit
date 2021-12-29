import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ArrayTests.allTests),
        testCase(DefaultValueTests.allTests),
        testCase(NonEmptyTests.allTests),
        testCase(ResultTests.allTests),
        testCase(StringTests.allTests),
    ]
}
#endif

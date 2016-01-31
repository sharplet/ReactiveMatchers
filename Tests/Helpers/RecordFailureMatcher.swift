import Quick
import Nimble

private struct TestFailure: CustomStringConvertible {
  var description: String
  var file: String
  var line: UInt
  var expected: Bool
}

class FailureRecordingSpec: QuickSpec {
  private static var recordFailures = false
  private static var lastRecordedFailure: TestFailure?

  override func recordFailureWithDescription(description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
    guard FailureRecordingSpec.recordFailures else {
      super.recordFailureWithDescription(description, inFile: filePath, atLine: lineNumber, expected: expected)
      return
    }

    let failure = TestFailure(description: description.trimmed(), file: filePath, line: lineNumber, expected: expected)
    FailureRecordingSpec.lastRecordedFailure = failure
  }
}

func recordFailure(description: String? = nil) -> MatcherFunc<Any> {
  return MatcherFunc { expression, failureMessage throws in
    failureMessage.postfixMessage = "record failure"
    failureMessage.actualValue = nil

    FailureRecordingSpec.recordFailures = true
    defer {
      FailureRecordingSpec.lastRecordedFailure = nil
      FailureRecordingSpec.recordFailures = false
    }

    try expression.evaluate()

    guard let failure = FailureRecordingSpec.lastRecordedFailure else {
      return false
    }

    failureMessage.actualValue = "<\(failure.description)>"

    if let description = description {
      failureMessage.postfixMessage = "record failure with description <\(description)>"
      return description == failure.description
    } else {
      return true
    }
  }
}

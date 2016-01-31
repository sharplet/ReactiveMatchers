import Nimble
import ReactiveCocoa

public func complete<Value, Error: ErrorType>() -> NonNilMatcherFunc<SignalProducer<Value, Error>> {
  return NonNilMatcherFunc { actual, failureMessage throws in
    failureMessage.expected = "expected producer"
    failureMessage.postfixMessage = "complete"
    failureMessage.actualValue = nil

    let producer: SignalProducer<Value, Error>! = try actual.evaluate()

    var completed = false
    producer.startWithCompleted {
      completed = true
    }
    return completed
  }
}

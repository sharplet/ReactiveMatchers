import Nimble
import ReactiveCocoa

public func complete<Value, Error: ErrorType>() -> NonNilMatcherFunc<Signal<Value, Error>> {
  return NonNilMatcherFunc { actual, failureMessage throws in
    failureMessage.expected = "expected signal"
    failureMessage.postfixMessage = "complete"
    failureMessage.actualValue = nil

    let signal: Signal<Value, Error>! = try actual.evaluate()

    var completed = false
    signal.observeCompleted {
      completed = true
    }
    return completed
  }
}

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

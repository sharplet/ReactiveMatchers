import Nimble
import ReactiveCocoa

public func complete<Value, Error: ErrorType>() -> NonNilMatcherFunc<Signal<Value, Error>> {
  var completed = false
  var disposable: Disposable!

  return NonNilMatcherFunc { actual, failureMessage throws in
    failureMessage.expected = "expected signal"
    failureMessage.postfixMessage = "complete"
    failureMessage.actualValue = nil

    if disposable == nil {
      let signal: Signal<Value, Error>! = try actual.evaluate()

      disposable = signal.observeCompleted {
        completed = true
      }
    }

    return completed
  }
}

public func complete<Value, Error: ErrorType>() -> NonNilMatcherFunc<SignalProducer<Value, Error>> {
  var completed = false
  var disposable: Disposable!

  return NonNilMatcherFunc { actual, failureMessage throws in
    failureMessage.expected = "expected producer"
    failureMessage.postfixMessage = "complete"
    failureMessage.actualValue = nil

    if disposable == nil {
      let producer: SignalProducer<Value, Error>! = try actual.evaluate()

      disposable = producer.startWithCompleted {
        completed = true
      }
    }

    return completed
  }
}

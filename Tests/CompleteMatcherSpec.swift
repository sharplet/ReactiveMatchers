import Quick
import Nimble
import ReactiveCocoa
@testable import ReactiveMatchers

final class CompleteMatcherSpec: FailureRecordingSpec {
  override func spec() {

    describe("complete()") {
      it("fails if a signal doesn't complete") {
        let (signal, _) = Signal<Int, NoError>.pipe()
        expect {
          expect(signal).to(complete())
        }.to(recordFailure("failed - expected signal to complete"))
      }

      it("fails if a signal producer doesn't complete") {
        let producer: SignalProducer<Int, NoError> = .never
        expect {
          expect(producer).to(complete())
        }.to(recordFailure("failed - expected producer to complete"))
      }

      it("passes if a signal asynchronously completes") {
        let (signal, observer) = Signal<Int, NoError>.pipe()
        let delayed = signal.delay(0.1, onScheduler: QueueScheduler())

        observer.sendCompleted()

        expect {
          expect(delayed).toEventually(complete())
        }.toNot(recordFailure())
      }

      it("passes if a signal producer asynchronously completes") {
        let delayed = SignalProducer<Int, NoError>.empty.delay(0.1, onScheduler: QueueScheduler())
        expect {
          expect(delayed).toEventually(complete())
        }.toNot(recordFailure())
      }
    }

  }
}

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
    }

  }
}

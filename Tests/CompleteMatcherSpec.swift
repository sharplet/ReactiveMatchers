import Quick
import Nimble
import ReactiveCocoa
@testable import ReactiveMatchers

final class CompleteMatcherSpec: FailureRecordingSpec {
  override func spec() {

    describe("complete()") {
      it("fails if the signal producer doesn't complete") {
        let producer: SignalProducer<Int, NoError> = .never
        expect {
          expect(producer).to(complete())
        }.to(recordFailure("failed - expected producer to complete"))
      }
    }

  }
}

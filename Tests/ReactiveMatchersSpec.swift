import Quick
import Nimble
@testable import ReactiveMatchers

final class ReactiveMatchersSpec: QuickSpec {
  override func spec() {
    describe("ReactiveMatchers") {
      it("has a spec") {
        let greeting = ["hello", "world"].joinWithSeparator(" ")
        expect(greeting) == "hello world"
      }
    }
  }
}

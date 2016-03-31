import XCTest
@testable import DemoNinja

class ScriptTests: XCTestCase {

    func testScriptCanHaveTitleAndSections() {
        let section1 = ScriptSection(title: "Grand Plan", steps: ["Collect Underpants", "???", "Profit"])
        let script = Script(title: "Underpants Gnomes", sections: [section1])
        XCTAssertEqual(script.title, "Underpants Gnomes")
        XCTAssertEqual(script.sections.count, 1)
        XCTAssertEqual(script.sections[0].title, "Grand Plan")
    }

}

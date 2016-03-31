import XCTest
@testable import DemoNinja

class ScriptSectionTests: XCTestCase {
    
    
    
    func testDemoScriptSectionCanHaveTitleAndSteps() {
        let section1 = ScriptSection(title: "Grand Plan", steps: ["Collect Underpants", "???", "Profit"])
        XCTAssertEqual(section1.title, "Grand Plan")
        XCTAssertEqual(section1.steps.count, 3)
        XCTAssertEqual(section1.steps[0], "Collect Underpants")
        XCTAssertEqual(section1.steps[1], "???")
        XCTAssertEqual(section1.steps[2], "Profit")
    }

}

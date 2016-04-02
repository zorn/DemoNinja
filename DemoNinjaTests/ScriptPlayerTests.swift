import XCTest
@testable import DemoNinja

class ScriptPlayerTests: XCTestCase {

    func testScriptPlayerCanProgressThroughSteps() {
        let simple = DemoScriptStore.simpleDemoScript
        // Simpel Demo, 2 sections, 3, steps each.
        let scriptPlayer = ScriptPlayer(script: simple)
        XCTAssertEqual(scriptPlayer.currentScriptSection, simple.sections[0])
        XCTAssertEqual(scriptPlayer.stepIndex, 0)
        
        scriptPlayer.incrementStep(1)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 1)
        
        scriptPlayer.incrementStep(1)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 2)
        
        scriptPlayer.incrementStep(1)
        XCTAssertEqual(scriptPlayer.sectionIndex, 1)
        XCTAssertEqual(scriptPlayer.stepIndex, 0)
    }
    
    func testScriptPlayerCanProgressThroughMultipleSectionsAtTime() {
        let simple = DemoScriptStore.simpleDemoScript
        // Simpel Demo, 2 sections, 3, steps each.
        let scriptPlayer = ScriptPlayer(script: simple)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 0)
        
        scriptPlayer.incrementStep(4)
        XCTAssertEqual(scriptPlayer.sectionIndex, 1)
        XCTAssertEqual(scriptPlayer.stepIndex, 1)
    }
    
    func testScriptPlayerCanUnProgressThroughSteps() {
        
        let simple = DemoScriptStore.simpleDemoScript
        // Simpel Demo, 2 sections, 3, steps each.
        let scriptPlayer = ScriptPlayer(script: simple)
        scriptPlayer.incrementStep(2)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 2)
        scriptPlayer.decrementStep(1)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 1)
    }
    
    func testScriptPlayerCanUnProgressThroughMultipleSectionsAtTime() {
        let simple = DemoScriptStore.simpleDemoScript
        // Simpel Demo, 2 sections, 3, steps each.
        let scriptPlayer = ScriptPlayer(script: simple)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 0)
        
        scriptPlayer.incrementStep(4)
        XCTAssertEqual(scriptPlayer.sectionIndex, 1)
        XCTAssertEqual(scriptPlayer.stepIndex, 1)
        
        scriptPlayer.decrementStep(2)
        XCTAssertEqual(scriptPlayer.sectionIndex, 0)
        XCTAssertEqual(scriptPlayer.stepIndex, 2)
    }
    
}

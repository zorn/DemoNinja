import XCTest
@testable import DemoNinja

class ScriptImporterTests: XCTestCase {

    func testExample() {
        
//        let bundle = NSBundle(forClass: self.classForCoder)
        let bundle = NSBundle.mainBundle()
        let url = bundle.URLForResource("Demo Programmatic Views", withExtension: "md")
        //let contents = String(contentsOfURL: url!)
        
        let importer = ScriptImporter()
        let script = try! importer.scriptFromURL(url!)
        XCTAssertEqual("Demo: Programmatic Views", script.title)
        
    }

}

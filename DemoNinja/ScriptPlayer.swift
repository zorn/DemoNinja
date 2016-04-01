import Foundation

public class ScriptPlayer {
    
    let script: Script
    private(set) var sectionIndex: Int {
        willSet {
            
        }
    }
    private(set) var stepIndex: Int {
        didSet {
            print("stepIndex changed to: \(stepIndex)")
        }
    }
    var currentScriptSection: ScriptSection {
        get {
            if sectionIndex < script.sections.count {
                return script.sections[sectionIndex]
            } else {
                return script.sections.last!
            }
        }
    }
    var atEnd: Bool {
        get {
            return sectionIndex >= script.sections.count
        }
    }
    
    init(script: Script) {
        self.script = script
        sectionIndex = 0
        stepIndex = 0
    }

    public func incrementStep(count: Int) {
        var stepsToIncrement = count
        while atEnd == false && stepsToIncrement > 0 {
            // if current section can be progresses
            let possibleNewStepIndex = stepIndex+stepsToIncrement
            if currentScriptSection.steps.count > possibleNewStepIndex {
                stepIndex += stepsToIncrement
                stepsToIncrement = 0
            } else { // move to next section
                let stepsRemainingOnCurrentSection = currentScriptSection.steps.count - stepIndex
                stepsToIncrement -= stepsRemainingOnCurrentSection
                sectionIndex += 1
                stepIndex = 0
            }
        }
    }

//    func nextScriptSection() -> ScriptSection? {
//        if script.sections.indices.contains(newSectionIndex) {
//            return script.sections[newSectionIndex]
//        } else {
//            return nil
//        }
//    }
    
}

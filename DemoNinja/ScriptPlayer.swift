import Foundation

protocol ScriptPlayerDelegate {
    func progressDidChangeForScript(script: Script)
}

public class ScriptPlayer {
    
    let script: Script
    var delegate: ScriptPlayerDelegate?
    private(set) var sectionIndex: Int {
        willSet {
            
        }
    }
    private(set) var stepIndex: Int {
        didSet {
            //print("stepIndex changed to: \(stepIndex)")
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
    var atStart: Bool {
        get {
            return sectionIndex == 0 && stepIndex == 0
        }
    }
    
    var numberOfCompletedSteps: Int {
        get {
            var total = 0
            for index in 0..<sectionIndex {
                total += script.sections[index].steps.count
            }
            total += stepIndex
            print("numberOfCompletedSteps: \(total)")
            return total
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
        delegate?.progressDidChangeForScript(script)
    }
    
    public func decrementStep(count: Int) {
        var stepsToDecrement = count
        // while we still have steps to remove and have not hit the start
        while atStart == false && stepsToDecrement > 0 {
            // test to see if we can remove steps from the current section
            let possibleNewStepIndex = stepIndex-stepsToDecrement
            if possibleNewStepIndex >= 0 {
                stepIndex = possibleNewStepIndex
                stepsToDecrement = 0
            } else {
                stepsToDecrement -= stepIndex
                sectionIndex -= 1
                stepIndex = script.sections[sectionIndex].steps.count
            }
        }
        delegate?.progressDidChangeForScript(script)
    }

//    func nextScriptSection() -> ScriptSection? {
//        if script.sections.indices.contains(newSectionIndex) {
//            return script.sections[newSectionIndex]
//        } else {
//            return nil
//        }
//    }
    
}

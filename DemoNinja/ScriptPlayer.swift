import Foundation

class ScriptPlayer {
    
    let script: Script
    
    var currentScriptSection: ScriptSection
    var currentStepIndex: Int
    
    init(script: Script) {
        self.script = script
        currentScriptSection = script.sections.first!
        currentStepIndex = 0
    }
}
import Foundation

struct ScriptSection {
    
    let title: String
    let steps: [String]
    
    init(title: String, steps: [String]) {
        self.title = title
        self.steps = steps
    }
    
}

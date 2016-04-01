import Foundation

struct ScriptSection: Equatable {
    
    let title: String
    let steps: [String]
    
    init(title: String, steps: [String]) {
        self.title = title
        self.steps = steps
    }
    
}

func ==(lhs: ScriptSection, rhs: ScriptSection) -> Bool {
    return (
        lhs.title == rhs.title &&
        lhs.steps == rhs.steps
    )
}

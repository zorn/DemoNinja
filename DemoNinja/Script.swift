import Foundation

struct Script {
    
    let title: String
    let sections: [ScriptSection]
    
    init(title: String, sections: [ScriptSection]) {
        self.title = title
        self.sections = sections
    }
}

import Foundation

struct Script {
    
    let title: String
    let sections: [ScriptSection]
    var totalNumberOfSectionSteps: Int {
        get {
            var total = 0
            for s in sections {
                total += s.steps.count
            }
            return total
        }
    }
    /**
     Creates and returns a new Script given a title and sections.
     
     - parameter title:    User displayd title.
     - parameter sections: Array of script sections. Must have at least 1 section.
     
     - returns: New Script instance.
     */
    init(title: String, sections: [ScriptSection]) {
        precondition(sections.count > 0, "sections must have at least one section")
        self.title = title
        self.sections = sections
    }
    
    
}

import Foundation

struct ScriptImporter {
    
    func scriptFromURL(url: NSURL) throws -> Script {
        
        let h3 = "###"
        let h2 = "##"
        let h1 = "#"
        let code = "````"
        let step = "* "
        
        
        let contents = try String(contentsOfURL: url)
        let lines = contents.componentsSeparatedByString("\n")
        
        var ignoreCode = false
        var title: String = ""
        var sectionTitle: String = ""
        var steps = [String]()
        var sections = [ScriptSection]()
        for line in lines {
            
            if line.characters.count == 0 {
                continue
            }
            
            let peek4 = peekWithIndex(4, forString: line)
            let peek3 = peekWithIndex(3, forString: line)
            let peek2 = peekWithIndex(2, forString: line)
            let peek1 = peekWithIndex(1, forString: line)
            
            if ignoreCode == true {
                if peek4 == code {
                    ignoreCode = false
                }
                continue
            }
            
            if peek4 == code {
                ignoreCode = true
                continue
            }
            
            if peek3 == h3 {
                if steps.count > 0 {
                    let newSection = ScriptSection(title: sectionTitle, steps: steps)
                    sections.append(newSection)
                }
                
                let newSectionTitle = line.substringWithRange(line.startIndex.advancedBy(3)..<line.endIndex)
                
                sectionTitle = newSectionTitle
                steps = [String]()
            }
            
            if peek2 == h2 {
                // skip
                continue
            } else if peek2 == step {
                let newStep = line.substringWithRange(line.startIndex.advancedBy(2)..<line.endIndex)
                steps.append(newStep)
                continue
            }
            
            if peek1 == h1 {
                let newTitle = line.substringWithRange(line.startIndex.advancedBy(2)..<line.endIndex)
                title = newTitle
                continue
            }
        }
        
        let script = Script(title: title, sections: sections)
        return script
        
        //let section = ScriptSection(title: "Test Section", steps: ["one", "two"])
        //return Script(title: "Test", sections: [section])
    }
    
    private func peekWithIndex(index: Int, forString string: String) -> String {
        if string.characters.count < index {
            return ""
        } else {
            return (string as NSString).substringToIndex(index)
        }
    }
    
}
import Foundation

struct DemoScriptStore {
    
    static let simpleDemoScript: Script = {
        let section1 = ScriptSection(title: "Section 1", steps: ["One", "Two", "Three"])
        let section2 = ScriptSection(title: "Section 2", steps: ["Four", "Five", "Six"])
        let script = Script(title: "Simple Demo", sections: [section1, section2])
        return script
    }()
    
}

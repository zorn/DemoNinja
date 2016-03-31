import UIKit

class ScriptPlayerTableDisplayAdaptor: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let player: ScriptPlayer
    
    init(player: ScriptPlayer) {
        self.player = player
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.currentScriptSection.steps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScriptStepCell", forIndexPath: indexPath) as! ScriptSectionTableViewCell
        
        let dynamicLabelString = "Section \(indexPath.section) Row \(indexPath.row)"
        var fullString = ""
        for _ in 0...indexPath.row {
            fullString += dynamicLabelString
        }
        
        cell.stepDescriptionLabel?.text = fullString
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.player.currentScriptSection.title
    }

}

import UIKit

class ScriptPlayerTableDisplayAdaptor: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let player: ScriptPlayer
    weak var tableView: UITableView?
    
    init(player: ScriptPlayer, tableView: UITableView) {
        self.player = player
        self.tableView = tableView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let extras = self.estimatedRowCountToFillScreen(44)
        return extras + player.currentScriptSection.steps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row <= player.currentScriptSection.steps.count {
            return buildAndConfigureScriptSectionTableViewCellForTableView(tableView, indexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Empty", forIndexPath: indexPath)
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
    func buildAndConfigureScriptSectionTableViewCellForTableView(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
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
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    

}


// Empty Row Calculations
extension ScriptPlayerTableDisplayAdaptor {
    
    func estimatedRowCountToFillScreen(estimatedRowHeight: Double) -> Int {
        if let tableView = self.tableView {
            let x = Double(tableView.frame.size.height) / estimatedRowHeight
            return Int(round(x))
        } else if let window = UIApplication.sharedApplication().keyWindow {
            let x = Double(window.frame.size.height) / estimatedRowHeight
            return Int(round(x))
        } else {
            return 12
        }
    }
    
}

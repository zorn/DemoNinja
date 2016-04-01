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
        
        if indexPath.row < player.currentScriptSection.steps.count {
            return buildAndConfigureScriptSectionTableViewCellForTableView(tableView, indexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Empty", forIndexPath: indexPath)
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
    func buildAndConfigureScriptSectionTableViewCellForTableView(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScriptStepCell", forIndexPath: indexPath) as! ScriptSectionTableViewCell
        
        cell.stepDescriptionLabel?.text = player.currentScriptSection.steps[indexPath.row]
        
        if indexPath.row == player.currentStepIndex {
            cell.contentView.backgroundColor = UIColor(hex: 0x97FBA8)
        } else {
            cell.contentView.backgroundColor = UIColor.whiteColor()
        }
        
        if indexPath.row >= player.currentStepIndex {
            cell.doneButton?.setTitle("O", forState: .Normal)
            cell.doneButton?.enabled = true
            cell.doneButton?.alpha = 1.0
            cell.stepDescriptionLabel?.alpha = 1.0

        } else {
            cell.doneButton?.setTitle("X", forState: .Normal)
            cell.doneButton?.enabled = false
            cell.doneButton?.alpha = 0.3
            cell.stepDescriptionLabel?.alpha = 0.3
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.player.currentScriptSection.title
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }

}

extension ScriptPlayerTableDisplayAdaptor: ScriptSectionTableViewCellDelegate {
    func buttonPressedFromCell(cell: UITableViewCell) {
        if let indexPath = tableView?.indexPathForCell(cell) {
            
            var pathsToReload = [NSIndexPath]()
            for i in player.currentStepIndex...indexPath.row+1 {
                let newPath = NSIndexPath(forRow: i, inSection: indexPath.section)
                print("adding path section: \(newPath.section) row:\(newPath.row)")
                pathsToReload.append(newPath)
            }
            
            player.currentStepIndex = indexPath.row + 1
            tableView?.reloadRowsAtIndexPaths(pathsToReload, withRowAnimation:.Fade)
            //let newTopPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
            tableView?.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        }
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

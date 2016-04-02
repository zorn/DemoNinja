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
        
        if indexPath.row == player.stepIndex && !player.atEnd {
            cell.contentView.backgroundColor = UIColor(hex: 0x97FBA8)
        } else {
            cell.contentView.backgroundColor = UIColor.whiteColor()
        }
        
        if indexPath.row >= player.stepIndex && !player.atEnd {
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
    
    func currentScrollPosition() -> NSIndexPath {
        if player.stepIndex == 0 {
            return NSIndexPath(forRow: 0, inSection: 0)
        } else {
            return NSIndexPath(forRow: player.stepIndex-1, inSection: 0)
        }
    }

}

extension ScriptPlayerTableDisplayAdaptor: ScriptSectionTableViewCellDelegate {
    func buttonPressedFromCell(cell: UITableViewCell) {
        
        if let indexPath = tableView?.indexPathForCell(cell) {
            
            let count = indexPath.row - player.stepIndex + 1
            
            player.incrementStep(count)
            tableView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
            
            let topPath = currentScrollPosition()
            tableView?.scrollToRowAtIndexPath(topPath, atScrollPosition: .Top, animated: true)
            
        }
        
        
//        if let indexPath = tableView?.indexPathForCell(cell) {
//            
//            var pathsToReload = [NSIndexPath]()
//            for i in player.stepIndex...indexPath.row+1 {
//                let newPath = NSIndexPath(forRow: i, inSection: indexPath.section)
//                print("adding path section: \(newPath.section) row:\(newPath.row)")
//                pathsToReload.append(newPath)
//            }
//            
//            player.incrementStep(indexPath.row + 1)
//            
//            if (player.stepIndex >= player.currentScriptSection.steps.count) {
//                
//            } else {
//                tableView?.reloadRowsAtIndexPaths(pathsToReload, withRowAnimation:.Fade)
//                tableView?.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
//            }
//            
//            
//        }
    }
    
    func progressPlayerWithCommitmentAtIndexPath(indexPath: NSIndexPath) {
        
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

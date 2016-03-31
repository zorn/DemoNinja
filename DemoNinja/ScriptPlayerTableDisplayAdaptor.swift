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
        let cell = tableView.dequeueReusableCellWithIdentifier("ScriptStepCell", forIndexPath: indexPath)
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }

}

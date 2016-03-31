import UIKit

class ScriptRunnerViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView?
    
    var script: Script?
    var scriptPlayer: ScriptPlayer?
    var scriptPlayerTableDisplayAdaptor: ScriptPlayerTableDisplayAdaptor?
    var presentationDelegate: MenuPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let script = self.script {
            scriptPlayer = ScriptPlayer(script: script)
            scriptPlayerTableDisplayAdaptor = ScriptPlayerTableDisplayAdaptor(player: scriptPlayer!)
            self.tableView?.dataSource = scriptPlayerTableDisplayAdaptor
            self.tableView?.delegate = scriptPlayerTableDisplayAdaptor
        }
    }
    
    @IBAction func doneScript(sender: UIBarButtonItem) {
        presentationDelegate?.dismissRequestFromViewController(self)
    }
    
}

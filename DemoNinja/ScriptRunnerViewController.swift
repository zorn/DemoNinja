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
            title = script.title
            scriptPlayer = ScriptPlayer(script: script)
            scriptPlayerTableDisplayAdaptor = ScriptPlayerTableDisplayAdaptor(player: scriptPlayer!)
            tableView?.dataSource = scriptPlayerTableDisplayAdaptor
            tableView?.delegate = scriptPlayerTableDisplayAdaptor
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.estimatedRowHeight = 75.0
        }
    }
    
    @IBAction func doneScript(sender: UIBarButtonItem) {
        presentationDelegate?.dismissRequestFromViewController(self)
    }
    
}

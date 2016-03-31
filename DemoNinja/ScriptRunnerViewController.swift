import UIKit

class ScriptRunnerViewController : UIViewController {
    
    var script: Script?
    var presentationDelegate: MenuPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }
    
    @IBAction func doneScript(sender: UIBarButtonItem) {
        presentationDelegate?.dismissRequestFromViewController(self)
    }
    
}

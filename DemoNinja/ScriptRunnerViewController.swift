import UIKit

class ScriptRunnerViewController : UIViewController {
    
    var presentationDelegate: MenuPresentation?
    
    @IBAction func doneScript(sender: UIBarButtonItem) {
        presentationDelegate?.dismissRequestFromViewController(self)
    }
    
}

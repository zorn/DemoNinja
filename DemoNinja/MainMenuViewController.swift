import UIKit

protocol MenuPresentation {
    func dismissRequestFromViewController(vc: UIViewController)
}

class MainMenuViewController: UIViewController {

    @IBAction func startSampleScript(sender: UIButton) {
        let identifier = StoryboardInfo.Identifiers.ScriptRunnerNavigation
        let navigation = storyboard!.instantiate(controller: identifier, ofType: UINavigationController.self)
        let scriptRunnerVC = navigation.topViewController as! ScriptRunnerViewController
        scriptRunnerVC.presentationDelegate = self
        scriptRunnerVC.script = DemoScriptStore.simpleDemoScript
        presentViewController(navigation, animated: true, completion: nil)
    }

}

extension MainMenuViewController: MenuPresentation {
    
    func dismissRequestFromViewController(vc: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

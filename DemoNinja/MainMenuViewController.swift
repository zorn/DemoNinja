import UIKit

protocol MenuPresentation {
    func dismissRequestFromViewController(vc: UIViewController)
}

class MainMenuViewController: UIViewController {

    @IBAction func startSampleScript(sender: UIButton) {
        let script = DemoScriptStore.simpleDemoScript
        let navigation = instantiateScriptRunnerNavigationWithScript(script)
        presentViewController(navigation, animated: true, completion: nil)
    }
    
    @IBAction func startProgramaticViewsScript(sender: UIButton) {
        let bundle = NSBundle.mainBundle()
        let url = bundle.URLForResource("Demo Programmatic Views", withExtension: "md")
        let importer = ScriptImporter()
        let script = try! importer.scriptFromURL(url!)
        let navigation = instantiateScriptRunnerNavigationWithScript(script)
        presentViewController(navigation, animated: true, completion: nil)

    }
    
    private func instantiateScriptRunnerNavigationWithScript(script: Script) -> UINavigationController {
        let identifier = StoryboardInfo.Identifiers.ScriptRunnerNavigation
        let navigation = storyboard!.instantiate(controller: identifier, ofType: UINavigationController.self)
        let scriptRunnerVC = navigation.topViewController as! ScriptRunnerViewController
        scriptRunnerVC.presentationDelegate = self
        scriptRunnerVC.script = script
        return navigation
    }

}

extension MainMenuViewController: MenuPresentation {
    
    func dismissRequestFromViewController(vc: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

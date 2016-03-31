import UIKit

extension UIStoryboard {
    
    func instantiate<VC: UIViewController, T: RawRepresentable where T.RawValue == String>(controller identifier: T, ofType _: VC.Type) -> VC! {
        return instantiateViewControllerWithIdentifier(identifier.rawValue) as? VC
    }
    
}

struct StoryboardInfo {
    
    enum Identifiers: String {
        case MainMenu = "MainMenuViewController"
        case ScriptRunner = "ScriptRunnerViewController"
        case ScriptRunnerNavigation = "NavigationOfScriptRunnerViewController"
    }
    
}
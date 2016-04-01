import UIKit

class ScriptSectionStepView: UIView, IdentifyingNibViewType {
    
    @IBOutlet var stepDescriptionLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ScriptSectionStepView", bundle: nil)
    }
    
}

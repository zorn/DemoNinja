import UIKit

extension UIView {

    class func buildView(color: UIColor, height: CGFloat, width: CGFloat) -> UIView {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = newView.heightAnchor.constraintEqualToConstant(height)
        heightConstraint.active = true
        let widthConstraint = newView.widthAnchor.constraintEqualToConstant(width)
        widthConstraint.active = true
        newView.backgroundColor = color
        return newView;
    }

}

class ScriptRunnerViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var stackView: UIStackView?

    var script: Script?
    var scriptPlayer: ScriptPlayer?
    var scriptPlayerTableDisplayAdaptor: ScriptPlayerTableDisplayAdaptor?
    var presentationDelegate: MenuPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stackView = self.stackView {
            stackView.backgroundColor = UIColor.orangeColor()
            
            stackView.axis = .Vertical;
            stackView.distribution = UIStackViewDistribution.Fill;
            stackView.alignment = UIStackViewAlignment.Top;
            stackView.spacing = 30;
            
            let redView = createView(ofType: ScriptSectionStepView.self)
            let blueView = createView(ofType: ScriptSectionStepView.self)
            let orangeView = createView(ofType: ScriptSectionStepView.self)
            let yellowView = createView(ofType: ScriptSectionStepView.self)
            
            redView.stepDescriptionLabel.text = "/* When items do not fit (overflow) or fill (underflow) the space available adjustments occur according to compressionResistance or hugging priorities of items, or when that is ambiguous, according to arrangement order. */ case Fill"
            
            blueView.stepDescriptionLabel.text = "/* Items are all the same size. When space allows, this will be the size of the item with the largest intrinsicContentSize (along the axis of the stack). Overflow or underflow adjustments are distributed equally among the items. */ case FillEqually"
                
            orangeView.stepDescriptionLabel.text = "/* Overflow or underflow adjustments are distributed among the items proportional to their intrinsicContentSizes. */ case FillProportionally"
                
            yellowView.stepDescriptionLabel.text = "/* Additional underflow spacing is divided equally in the spaces between the items. Overflow squeezing is controlled by compressionResistance priorities followed by arrangement order. */ case EqualSpacing"
            
            
            stackView.addArrangedSubview(redView)
            stackView.addArrangedSubview(blueView)
            stackView.addArrangedSubview(orangeView)
            stackView.addArrangedSubview(yellowView)
        }
        
        
        if let script = self.script {
            title = script.title
            scriptPlayer = ScriptPlayer(script: script)
            
            
            
//            scriptPlayerTableDisplayAdaptor = ScriptPlayerTableDisplayAdaptor(player: scriptPlayer!)
//            tableView?.dataSource = scriptPlayerTableDisplayAdaptor
//            tableView?.delegate = scriptPlayerTableDisplayAdaptor
//            tableView?.rowHeight = UITableViewAutomaticDimension
//            tableView?.estimatedRowHeight = 75.0
        }
    }
    
    @IBAction func doneScript(sender: UIBarButtonItem) {
        presentationDelegate?.dismissRequestFromViewController(self)
    }
    
}

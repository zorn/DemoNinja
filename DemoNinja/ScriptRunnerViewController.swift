import UIKit

class ScriptRunnerViewController : UIViewController {
    
    @IBOutlet var progressBaseView: UIView!

    @IBOutlet var tableView: UITableView?
    
    @IBOutlet var doneViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var sectionViewTrailingConstraint: NSLayoutConstraint!
    
    var script: Script?
    var scriptPlayer: ScriptPlayer?
    var scriptPlayerTableDisplayAdaptor: ScriptPlayerTableDisplayAdaptor?
    var presentationDelegate: MenuPresentation?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let script = self.script {
            title = script.title
            scriptPlayer = ScriptPlayer(script: script)
            scriptPlayer!.delegate = self
            
            
            scriptPlayerTableDisplayAdaptor = ScriptPlayerTableDisplayAdaptor(player: scriptPlayer!, tableView: tableView!)
            tableView?.dataSource = scriptPlayerTableDisplayAdaptor
            tableView?.delegate = scriptPlayerTableDisplayAdaptor
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.estimatedRowHeight = 75.0
            tableView?.separatorStyle = .None
            tableView?.scrollEnabled = false
            
            progressDidChangeForScript(script)
        }
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(ScriptRunnerViewController.progressBarTapped(_:)))
        progressBaseView.addGestureRecognizer(tapGR)
    }
    
    @IBAction func doneScript(sender: UIBarButtonItem) {
        presentationDelegate?.dismissRequestFromViewController(self)
    }
    
    private func updateSectionProgressView() {
        let numberOfSections = script!.sections.count
        let currentSectionNumber = scriptPlayer!.sectionIndex + 1
        
        print("currentSectionNumber / numberOfSections: \(currentSectionNumber) \(numberOfSections)")
        
        let totalWidth = view.bounds.size.width
        let widthPerSection = CGFloat(totalWidth) / CGFloat(numberOfSections)
        let currentWidth = CGFloat(currentSectionNumber) * widthPerSection
        let trailingSpace = totalWidth - currentWidth
        if scriptPlayer!.atEnd {
            sectionViewTrailingConstraint.constant = 0
        } else {
            sectionViewTrailingConstraint.constant = trailingSpace
        }
        view.layoutIfNeeded()
    }
    
    private func updateDoneProgressView() {
        let numberOfDoneSections = script!.totalNumberOfSectionSteps
        let numberOfCompletedDoneSections = scriptPlayer!.numberOfCompletedSteps
        
        print("numberOfCompletedDoneSections / numberOfDoneSections: \(numberOfCompletedDoneSections) \(numberOfDoneSections)")
        
        let totalWidth = view.bounds.size.width
        let widthPerDone = CGFloat(totalWidth) / CGFloat(numberOfDoneSections)
        let currentWidth = CGFloat(numberOfCompletedDoneSections) * widthPerDone
        let trailingSpace = totalWidth - currentWidth
        if scriptPlayer!.atEnd {
            doneViewTrailingConstraint.constant = 0
        } else {
            doneViewTrailingConstraint.constant = trailingSpace
        }
        view.layoutIfNeeded()
    }
    
    func progressBarTapped(gesture: UITapGestureRecognizer) {
        
        scriptPlayer!.decrementStep(1)
        progressDidChangeForScript(script!)
        tableView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        
        let topPath = scriptPlayerTableDisplayAdaptor!.currentScrollPosition()
        tableView?.scrollToRowAtIndexPath(topPath, atScrollPosition: .Top, animated: true)
    }
}

extension ScriptRunnerViewController: ScriptPlayerDelegate {
    func progressDidChangeForScript(script: Script) {
        updateSectionProgressView()
        updateDoneProgressView()
    }
}

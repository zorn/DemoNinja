import UIKit

protocol ScriptSectionTableViewCellDelegate {
    func buttonPressedFromCell(cell: UITableViewCell)
}

class ScriptSectionTableViewCell: UITableViewCell {
    
    var delegate: ScriptSectionTableViewCellDelegate?
    
    @IBOutlet var stepDescriptionLabel: UILabel?
    @IBOutlet var doneButton: UIButton?

    override func awakeFromNib() {
        selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        self.delegate?.buttonPressedFromCell(self)
    }
    
}

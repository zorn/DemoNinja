import UIKit

class ScriptSectionTableViewCell: UITableViewCell {
    
    @IBOutlet var stepDescriptionLabel: UILabel?
    
    override func awakeFromNib() {
        selectionStyle = UITableViewCellSelectionStyle.None
    }
    
}

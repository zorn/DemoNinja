import UIKit

protocol IdentifyingNibViewType: class {
    static func nib() -> UINib
}

func createView<View: UIView where View: IdentifyingNibViewType>(ofType _: View.Type) -> View {
    let nib = View.nib()
    let nibContents = nib.instantiateWithOwner(nil, options: nil)
    assert(nibContents.count == 1, "\(nib) should hold only a single view, but found \(nibContents.count) items: \(nibContents)")
    return nibContents.first as! View
}
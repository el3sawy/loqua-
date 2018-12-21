
import UIKit

@IBDesignable
class customeText: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = layer.frame.size.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

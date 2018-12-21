import Foundation
import UIKit

extension UITextField {
    func setIcon (_ image : UIImage){
        let iconView  = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        
        iconView.image = image
        let iconContainerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}
extension Data {
    
    var hex : String {
        
        let hex = map {String (format: "%02.2hhx", $0)}.joined()
        return hex
    }
}






import Foundation
import UIKit

class Messages{
    class  func showMessage( Message : String , view : UIView){
        let lable = UILabel(frame: CGRect(x: 0, y: view.frame.height , width: view.frame.width, height:60))
        view.addSubview(lable)
        lable.textAlignment = .center
        lable.backgroundColor = UIColor.red
        lable.text = Message
        lable.textColor = UIColor.black
        
        UIView.animate(withDuration: 1.0, animations: {
            lable.center.y  -= 60
        }) { (finish) in
            if finish{
                UIView.animate(withDuration: 1.0, delay: 1, options: .curveLinear, animations: {
                    lable.center.y += 60
                }, completion: { (_) in
                    
                })
            }
        }
        // to Show Above the keyboard
        UIApplication.shared.windows[UIApplication.shared.windows.count - 1].addSubview(lable)
    }
    
    private class func animation(lable :UILabel){
        UIView.animate(withDuration: 10.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            lable.alpha = 0.0
        }) { (complete) in
            lable.removeFromSuperview()
        }
        
    }
}

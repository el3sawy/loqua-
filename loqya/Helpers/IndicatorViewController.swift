import Foundation
import UIKit
import NVActivityIndicatorView

class  IndicatorViewController : UIViewController {
    
    private var viewLanch : UIView!
    private  let  viewContainer = UIView()
    private var indicator : NVActivityIndicatorView!
    
    func startIndicatorWithWhiteView (){
        viewLanch = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(viewLanch)
        viewLanch.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        self.activityIndicatorBegin()
    }
    
    func startIndicator (){
        self.activityIndicatorBegin()
    }
    
    func endIncator (){
        self.activityIndicatorEnd()
    }
    func endIndicatroWithWhiteView(){
        self.activityIndicatorEnd()
        self.viewLanch.removeFromSuperview()
        
    }
    private func activityIndicatorBegin(){
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        view.addSubview(viewContainer)
        viewContainer.layer.cornerRadius = 10
        viewContainer.backgroundColor = UIColor.lightGray
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor ).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let frame  = CGRect(x: (viewContainer.frame.midX) + 25  , y: (viewContainer.frame.midY )  + 25 , width: 50 ,  height: 50 )
        indicator =  NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: UIColor.black, padding: 1)
        indicator.startAnimating()
        viewContainer.addSubview(indicator)
    }
    
    private func activityIndicatorEnd (){
        
        if indicator.isAnimating {
            UIApplication.shared.endIgnoringInteractionEvents()
            indicator.stopAnimating()
            self.viewContainer.removeFromSuperview()
        }
    }
}

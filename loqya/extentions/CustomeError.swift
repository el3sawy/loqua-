//
//  File.swift
//  loqya
//
//  Created by Ahmed on 8/24/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import Foundation
import UIKit

class Messages{
    class  func showErrorMessage( errorMessage : String , view : UIView){
        let lable = UILabel()
        lable.frame = CGRect(x: (view.frame.width / 2) - (view.frame.width / 4), y: view.frame.height - 100, width: view.frame.width / 2, height: 40)
        lable.text = errorMessage
        lable.textAlignment = .center
        lable.backgroundColor = #colorLiteral(red: 0.4413372278, green: 0.8248205185, blue: 0.8997080922, alpha: 1).withAlphaComponent(1.0)
        lable.textColor  = UIColor.white
        lable.font = UIFont.boldSystemFont(ofSize: 17)
        lable.numberOfLines = 0
        lable.alpha = 0.5
        lable.layer.cornerRadius = 20
        lable.layer.borderWidth = 1.0
        lable.layer.borderColor = UIColor.clear.cgColor
        lable.clipsToBounds  = true
        
        // to Show Above the keyboard
            UIApplication.shared.windows[UIApplication.shared.windows.count - 1].addSubview(lable)
        
        UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            lable.alpha = 0.0
        }) { (complete) in
            lable.removeFromSuperview()
        }
        
        
        
        
    }
}

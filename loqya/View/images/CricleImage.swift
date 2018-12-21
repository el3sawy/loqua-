//
//  CricleImage.swift
//  loqya
//
//  Created by Ahmed on 8/26/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit

class CricleView: UIView {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
    
    }
}

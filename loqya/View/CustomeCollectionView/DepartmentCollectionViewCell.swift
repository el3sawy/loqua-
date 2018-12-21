//
//  DepartmentCollectionViewCell.swift
//  loqya
//
//  Created by Ahmed on 8/17/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit

class CVCdepartment: UICollectionViewCell {
    
    //outlets
    @IBOutlet  weak var deptName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 1.0
    }
    
    func configrationCell(dept : Department){

        self.deptName.text = dept.deptName
    }
}

//
//  PlacesCollectionViewCell.swift
//  loqya
//
//  Created by Ahmed on 8/15/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit
import Kingfisher

class CVCplaces: UICollectionViewCell {
    
    //Outlets
    
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var placeName: UILabel!
    
    @IBOutlet weak var placeReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
    }
    
    
    func configrationImage(place : Places)  {
        self.placeName.text = place.placeTitle
       // self.placeReview.text = String(place.placeRating)
        
        self.placeImage.kf.indicatorType = .activity
        let path = "\(place.placeImagePath!)\(place.placeImageName!)"
        print(path)
        if let url = URL(string: path){
            self.placeImage.kf.setImage(with: url)
        }
        
    }
    
}

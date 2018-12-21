//
//  VCoffers.swift
//  loqya
//
//  Created by Ahmed on 9/2/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit

class VCoffers: IndicatorViewController {
    
    @IBOutlet weak var collectionViewPlaces: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewPlaces.dataSource = self
        self.collectionViewPlaces.delegate = self
        self.startIndicatorWithWhiteView()
        navigationItem.title = "العرض"
        Api.instance.getOffersData { (success) in
            if success{
                self.endIndicatroWithWhiteView()
                self.collectionViewPlaces.reloadData()
            }
        }
    }
}
extension  VCoffers : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Api.instance.arryOffers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewPlaces.dequeueReusableCell(withReuseIdentifier: "CVCoffers", for: indexPath) as? CVCoffers {
            
            let place  = Api.instance.arryOffers[indexPath.row]
            
            cell.configrationCell(place: place)
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width : CGFloat = 150
        if view.frame.size.width <= 415{width = (collectionViewPlaces.frame.size.width - 40)  / 2}
            
        else{width = (collectionViewPlaces.frame.size.width - 40)  / 3}
        return CGSize(width: width, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeID   =  Api.instance.arryOffers[indexPath.row].placeID
        self.performSegue(withIdentifier: "seg_PlaceDetails", sender: placeID)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeVC = segue.destination as? VCdetailsPlace{
            if let placeid = (sender as? Int){
                placeVC.placID = placeid
            }
        }
    }
}

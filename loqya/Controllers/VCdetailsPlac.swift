//
//  DetailsPlaceVC.swift
//  loqya
//
//  Created by Ahmed on 8/22/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit

class VCdetailsPlace: UIViewController  {
    
    //outLets
    @IBOutlet weak var txtViewplaceDetails: UITextView!
    @IBOutlet weak var pageControlImages: UIPageControl!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var lblPlaceChairs: UILabel!
    @IBOutlet weak var lblPlaceRooms: UILabel!
    @IBOutlet weak var lblPlaceWorker: UILabel!
    @IBOutlet weak var lblPlaceAddress: UILabel!
    @IBOutlet weak var lblPlaceDate: UILabel!
    @IBOutlet weak var lblPlaceArea: UILabel!
    @IBOutlet weak var lblPlacePrice: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var collectionViewImages: UICollectionView!
   
    
    //Vairables
    var placID : Int?
    var places = Places()
    var countImages : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionViewImages.dataSource = self
        self.collectionViewImages.delegate = self
        Api.instance.getDataForSelectedPlace(placeID: placID!) { (error, place) in
            
            if let placeDetails = place{
                self.places = placeDetails
                
                self.collectionViewImages.reloadData()
                self.fillPlaceData(place: placeDetails)
                
                if let arrImages = placeDetails.imagesArray {
                    self.pageControlImages.numberOfPages = arrImages.count
                    self.countImages = arrImages.count
                }
            }
        }
    }
    
    //CollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let arrimages =  self.places.imagesArray{
            return arrimages.count
        }
        else{
            return 0
        }
    }
}
extension VCdetailsPlace : UICollectionViewDelegate , UICollectionViewDataSource  ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if   let cell = collectionViewImages.dequeueReusableCell(withReuseIdentifier: "PlaceDetailsCVC", for: indexPath) as? PlaceDetailsCVC{
            
            if let arrImages = places.imagesArray {
                
                let image = arrImages[indexPath.row]
                cell.configrationCell(place: places, imageName: image)
                return cell
            }
            else {
                return UICollectionViewCell()
            }
            
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.viewContainer.bounds.width, height: self.viewContainer.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControlImages?.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // My Functions
    func fillPlaceData (place : Places){
        navigationItem.title = place.placeTitle
        self.lblPlaceChairs.text = place.placeChair ?? " "
        self.lblPlaceRooms.text = place.placeRoooms ?? " "
        self.lblPlaceWorker.text = place.placeWorker ?? " "
        self.lblPlaceAddress.text = place.placeAddress ?? " "
        self.lblPlaceArea.text = place.placeArea ?? " "
        self.lblPlacePrice.text  = String(place.placePrice ?? 0 )
        self.lblPlaceDate.text = place.placeAvilable ?? " "
        self.txtViewplaceDetails.text = place.placeDetails ?? " "
        
        self.imagePlace.kf.indicatorType = .activity
        if let imageName = place.placeImageName , let imagePath = place.placeImagePath {
            
            let pathImage = "\(imagePath)\(imageName)"
            
            if let url = URL(string: pathImage){
                self.imagePlace.kf.setImage(with: url)
            }
        }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        print("buytttton")
        
    }
}

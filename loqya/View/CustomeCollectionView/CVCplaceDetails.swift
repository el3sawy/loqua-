import UIKit

class CVCplaceDetails: UICollectionViewCell {
    
    @IBOutlet weak var PlaceImages: UIImageView!
    
    func configrationCell(place : Places ,imageName : String ){
        print(imageName)
        self.PlaceImages.kf.indicatorType = .activity
        if let imagePath = place.placeImagePath {
            let path = "\(imagePath)\(imageName)"
            if let url = URL(string: path){
                self.PlaceImages.kf.setImage(with: url)
            }
        }
    }
    
}

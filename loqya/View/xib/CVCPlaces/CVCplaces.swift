import UIKit

class CVCplaces: UICollectionViewCell {
    
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeReview: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 4.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius ).cgPath
    }
    
    func configrationImage(place : Places)  {
        self.placeName.text = place.placeTitle
        if let rate = place.placeRating {
            //print("\(rate)\(place.placeTitle)")
            var str = ""
            for i in  stride(from: 5, to: 0, by: -1) {
                if i > rate{
                    str += "✩"
                }
                else{
                    str += "★"
                }
            }
            self.placeReview.text = str
        }
        
        self.placeImage.kf.indicatorType = .activity
        let path = "\(place.placeImagePath!)\(place.placeImageName!)"
        if let url = URL(string: path){
            self.placeImage.kf.setImage(with: url)
        }
        
    }
}

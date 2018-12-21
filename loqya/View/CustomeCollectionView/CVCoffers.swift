import UIKit
import  Kingfisher

class CVCoffers: UICollectionViewCell {
    
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var txtDiscount: UIButton!
    @IBOutlet weak var txtRating: UILabel!
    @IBOutlet weak var txtPriceAfterDiscount: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtPlaceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 4.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = UIColor.white
    }
    
    func configrationCell (place : Places) {
        if  let price = place.placePrice {
            let text = String(price)
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,value: NSUnderlineStyle.single.rawValue,range: textRange)
        txtPrice.attributedText = attributedText
        }
        self.txtPlaceName.text = place.placeTitle
        self.txtPriceAfterDiscount.text = String( place.price_after_discount)
        self.txtDiscount.setTitle(place.precentage
            , for: .normal)
        
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
            self.txtRating.text = str
        }
        
        self.imagePlace.kf.indicatorType = .activity
        let path = "\(place.placeImagePath!)\(place.placeImageName!)"
        if let url = URL(string: path){
            self.imagePlace.kf.setImage(with: url)
        }
    }
}

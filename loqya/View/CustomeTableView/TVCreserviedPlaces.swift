import UIKit

class TVCreserviedPlaces: UITableViewCell {
    
    @IBOutlet weak var lblNamePlace: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContainer.layer.cornerRadius =  5
        self.viewContainer.layer.borderWidth = 1
        self.viewContainer.layer.borderColor  = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configartonCell (place : Places){
    
        lblNamePlace.text = place.placeTitle
        self.lblPrice.text = String( place.placePrice ?? 0 )
        self.lblFromDate.text = place.startDate
        self.lblToDate.text = place.endDate
        if let rate = place.placeRating {
            var str = ""
            for i in  stride(from: 5, to: 0, by: -1) {
                if i > rate{
                    str += "✩"
                }
                else{
                    str += "★"
                }
            }
            self.lblRating.text = str
        }
    }
}

import UIKit

class TVCOpinionClients: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var nameClientLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContainer.layer.cornerRadius = 10
    }
    
    func configrationCell(opinion : OpnionClient){
        
        self.nameClientLBL.text   = opinion.clientName 
        self.messageLBL.text = opinion.clientOpinion
    }
}

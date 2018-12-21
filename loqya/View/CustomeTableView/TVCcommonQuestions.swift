import UIKit

class TVCcommonQuestions: UITableViewCell {
    
    @IBOutlet weak var lblDetailsQuestion: UILabel!
    @IBOutlet weak var lblTitleQuestion: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContent.layer.cornerRadius = 10
        
    }
    func configrationCell(question : CommonQuestion){
        self.lblTitleQuestion.text = question.title
        self.lblDetailsQuestion.text = question.details
    }
}

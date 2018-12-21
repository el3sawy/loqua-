
import UIKit

class TVCdepartment: UITableViewCell {
    
    //outlets
    @IBOutlet  weak var deptName: UILabel!    
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContainer.layer.borderWidth = 2.0
        viewContainer.layer.borderColor = UIColor.white.cgColor
        viewContainer.layer.cornerRadius = 1.0
    }
    
    func configrationCell(dept : Department){
        
        self.deptName.text = dept.deptName
    }
}

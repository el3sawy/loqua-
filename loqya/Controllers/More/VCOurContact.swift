import UIKit

class VCOurContact: IndicatorViewController  {
    
    //OutLets
    //Collection of Views
    @IBOutlet var collectionOfViews: [UIView]!
    @IBOutlet weak var btnFax: UIButton!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ارقام التواصل"
        
        self.startIndicatorWithWhiteView()
        fillData()
    }
    
    //My Functions 
    func fillData(){
        Api.instance.getOurContactsData { (email, mobile, phone, fax, error) in
            
            if let email = email , let phone = phone , let mobile = mobile , let fax = fax{
                self.btnFax.setTitle("Fax: \(fax)", for: .normal)
                self.btnMobile.setTitle("Mobile: \(mobile)", for: .normal)
                self.btnPhone.setTitle("Phone: \(phone)", for: .normal)
                self.btnEmail.setTitle("Email: \(email)", for: .normal)
                self.endIndicatroWithWhiteView()
            }
        }
    }
    
    //Actions
    @IBAction func informationBTNclick(_ sender: Any) {
        
        if let btn = (sender as? UIButton) {
            for view in collectionOfViews {
                if view.tag == btn.tag {
                    view.backgroundColor = UIColor.lightGray
                }
                else{
                    
                    view.backgroundColor = UIColor.clear
                }
            }
        }
    }
}


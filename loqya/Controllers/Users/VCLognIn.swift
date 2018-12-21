import UIKit
import Firebase
import FirebaseAuth

class VCLognIn: IndicatorViewController {
    
    
    @IBOutlet weak var txtEmail: customeText!
    @IBOutlet weak var txtPassword: customeText!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "دخول"
        navigationItem.backBarButtonItem?.title = " "
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces) , !email.isEmpty else {
            return Messages.showMessage(Message: "ادخل الايميل", view: view)
        }
        
        guard let pass = txtPassword.text , !pass.isEmpty else {
            return Messages.showMessage(Message: "ادخل الرقم السري", view: view)
        }
        view.endEditing(true)
        
        self.startIndicator()
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if let error = error{
                
                if error._code == 17011{
                    
                    let alert = UIAlertController(title: "Not Found", message: "User Not Found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action : UIAlertAction) in
                        self.txtEmail.becomeFirstResponder()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                print(error.localizedDescription)
            }
            else {
                if let user = user {
                    let token = user.user.uid
                    AuthServices.instance.UserToken = token
                    self.performSegue(withIdentifier: "seg_reseved", sender: nil)
                }
            }
            
        }
        self.endIncator()
    }
    
    @IBAction func btnRigisterClick(_ sender: Any) {
    }
}

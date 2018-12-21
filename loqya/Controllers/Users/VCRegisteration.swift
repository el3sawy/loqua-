import UIKit
import Firebase
import FirebaseAuth

class VCRegisteration: IndicatorViewController {
    
    @IBOutlet weak var txtConfirmaPass: customeText!
    @IBOutlet weak var txtPassowrd: customeText!
    @IBOutlet weak var txtEmail: customeText!
    @IBOutlet weak var txtName: customeText!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "انشاء حساب جديد"
        navigationItem.backBarButtonItem?.title = " "
    }
    
    
    
    @IBAction func btnRigisterClick(_ sender: Any) {
        
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces) , !email.isEmpty else{
            return Messages.showMessage(Message: "ادخل الايميل", view: view)
        }
        
        guard isValidEmail(testStr: email) else {
            txtEmail.becomeFirstResponder()
            return Messages.showMessage(Message: "ادخل الايميل بطريقة صحيحه", view: self.view)}
        
        guard let name = txtName.text?.trimmingCharacters(in: .whitespaces) , !name.isEmpty else{return Messages.showMessage(Message: "ادخل الاسم", view: view)}
        
        guard let pass = txtPassowrd.text ,!pass.isEmpty else {
            return Messages.showMessage(Message: "ادخل الرقم السري", view: view)
        }
        guard let confirmPass = txtConfirmaPass.text , !confirmPass.isEmpty else{
            return Messages.showMessage(Message: "ادخل الرقم السري", view: view)
        }
        
        if pass == confirmPass {
            self.startIndicator()
            Auth.auth().createUser(withEmail: email, password: pass) { (data, error) in
                if  let error = error{
                    Messages.showMessage(Message: error.localizedDescription, view: self.view)
                }
                    
                else {
                    if let user = data {
                        let token  = user.user.uid
                        AuthServices.instance.UserToken = token
                        AuthServices.instance.UserName = name
                        self.performSegue(withIdentifier: "seg_register", sender: nil)
                    }
                    
                }
            }
            self.endIncator()
        }
            
        else{
            Messages.showMessage(Message: "الرقم السري غير متطابق", view: view)
        }
        
        
    }
}

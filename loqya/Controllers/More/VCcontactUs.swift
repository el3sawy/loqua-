import UIKit

class VCcontactUs: IndicatorViewController {
    
    //Outlets
    @IBOutlet weak var txtClientPhone: customeText! {didSet{ txtClientPhone.setIcon(#imageLiteral(resourceName: "phone"))}}
    @IBOutlet weak var txtClientEmail: customeText! {didSet{txtClientEmail.setIcon(#imageLiteral(resourceName: "email"))}}
    @IBOutlet weak var txtClientName: customeText!{didSet{txtClientName.setIcon(#imageLiteral(resourceName: "phone"))}}
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var txtMessageTitle: customeText! {didSet{txtMessageTitle.setIcon(#imageLiteral(resourceName: "phone"))}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "الدعم الفني"
        //SetUp Keyboard
        setupKeboard()
        
        //Close Keyboad when click any place
        let tapCloseKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.tabClooseKeyboard(tab:)))
        view.addGestureRecognizer(tapCloseKeyboard)
    }
    
    //Functions
    func setupKeboard(){
        txtClientPhone.keyboardType = .numberPad
        txtClientEmail.keyboardType = .emailAddress
    }
    
    @objc func tabClooseKeyboard(tab : UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    //Action 
    @IBAction func sendBTNClick(_ sender: Any) {
        
        guard let name = txtClientName.text , !name.isEmpty else{return Messages.showMessage(Message: "ادخل الاسم", view: view) }
        
        guard let phone = txtClientPhone.text ,!phone.isEmpty else{return Messages.showMessage(Message: " ادخل الهاتف", view: view)}
        
        guard let email = txtClientEmail.text ,!email.isEmpty else{return Messages.showMessage(Message: "ادخل الايميل", view: view)}
        
        guard isValidEmail(testStr: email) else{
            txtClientEmail.becomeFirstResponder()
             return Messages.showMessage(Message: "ادخل الايميل بطريقة صحيحه", view: self.view)
        }
        
        guard let title = txtMessageTitle.text ,!title.isEmpty else{return Messages.showMessage(Message: " ادخل عنوان الرساله", view: view)}
        
        guard let message = txtMessage.text ,!message.isEmpty else{return Messages.showMessage(Message: "ادخل الرساله", view: view)}
        
        //Calling API
        self.startIndicator()
        Api.instance.sendContactUsData(name: name, phone: phone, email: email, title: title, message: message) { (error, data) in
            if let data = data{
                self.endIncator()
               Messages.showMessage(Message: data, view: self.view)
            }
        }
        
    }
    
}

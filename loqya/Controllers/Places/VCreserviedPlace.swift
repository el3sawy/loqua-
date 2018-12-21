import UIKit

class VCreserviedPlace: IndicatorViewController , UITextFieldDelegate{
    
    //Varibles
    private var datePacker : UIDatePicker?
    private var text : UITextField = UITextField()
    private var dateValue : String?
    var placeID : Int?
    
    //outlets
    @IBOutlet weak var fromDate: customeText! {didSet{fromDate.setIcon(#imageLiteral(resourceName: "home"))}}
    @IBOutlet weak var todate: customeText!{didSet{todate.setIcon(#imageLiteral(resourceName: "home"))}}
    @IBOutlet weak var phoneText: customeText!
   // @IBOutlet weak var nameText: customeText!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Keyboard Numbers
        phoneText.keyboardType = .numberPad
        self.showDatePackerWhenClickText()
    }
    
    func showDatePackerWhenClickText (){
        datePacker = UIDatePicker()
        datePacker?.datePickerMode = .date
        
        datePacker?.addTarget(self, action: #selector(VCreserviedPlace.dateChanged(datePacker:textFiled:)), for: .valueChanged)
        fromDate.inputView = datePacker
        todate.inputView = datePacker
        
        let tabGest = UITapGestureRecognizer(target: self, action: #selector(VCreserviedPlace.tapGestor(tabGester:)))
        view.addGestureRecognizer(tabGest)
    }
    
    
    @objc func dateChanged(datePacker  : UIDatePicker , textFiled : UITextField ){
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        dateValue =   dateFormater.string(from: datePacker.date)
        
    }
    
    //for set value for each txtfiled from date  and to date
    //event Editing did end 
    @IBAction func textDidExit(_ sender: Any) {
        print(dateValue ?? "00")
        (sender as? UITextField)?.text = dateValue
    }
    
    @objc func tapGestor (tabGester : UITapGestureRecognizer)  {
        view.endEditing(true)
    }
    
    //Action Functions
    @IBAction func signUpClick(_ sender: Any) {
        
       // guard let name = self.nameText.text , !name.isEmpty else{return
           // Messages.showMessage(Message: "الاسم ", view: view)}
        
        guard let phone = self.phoneText.text  , !phone.isEmpty else { return  Messages.showMessage(Message: "رقم الهاتف", view: view)}
        
        guard let toDate  = self.todate.text , !toDate.isEmpty else {return  Messages.showMessage(Message: "ادخل تاريخ النهايه", view: view)}
        
        guard  let fromDate  = self.fromDate.text ,!fromDate.isEmpty else {
            return  Messages.showMessage(Message: "ادخل تاريخ البداية", view: view)}
        
        let dateFormater  = DateFormatter()
        dateFormater.dateFormat =  "yyyy-MM-dd"
        
        let startDate = dateFormater.date(from: fromDate)
        let endDate = dateFormater.date(from: toDate)
        
        if let startDate = startDate , let endDate = endDate{
            if startDate < endDate  && AuthServices.instance.UserToken != "" {
                
                self.startIndicator()
                Api.instance.ReservePlace(placeID: self.placeID ?? 0 , name: AuthServices.instance.UserName, phone: phone, startDate: fromDate, endDate: toDate, token: AuthServices.instance.UserToken) { (message, error) in
                    if let message = message {
                        Messages.showMessage(Message: message, view: self.view)
                    }
                }
                self.endIncator()
            }
            else{
                Messages.showMessage(Message: "التاريخ غير مضبوط", view: view)
            }
        }
    }
}

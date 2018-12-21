
import UIKit

class VCreserviedPlace: UIViewController , UITextFieldDelegate{
    
    //Varibles
    private var datePacker : UIDatePicker?
    private var text : UITextField = UITextField()
    private var dateValue : String?
    var placeID : Int?
    
    //outlets
    @IBOutlet weak var fromDate: customeText! {didSet{fromDate.setIcon(#imageLiteral(resourceName: "home"))}}
    @IBOutlet weak var todate: customeText!{didSet{todate.setIcon(#imageLiteral(resourceName: "home"))}}
    @IBOutlet weak var phoneText: customeText!
    @IBOutlet weak var nameText: customeText!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Keyboard Numbers
        phoneText.keyboardType = .numberPad
        
        self.showDatePackerWhenClickText()
    }
    
    func showDatePackerWhenClickText (){
        datePacker = UIDatePicker()
        datePacker?.datePickerMode = .date
    //    datePacker?.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        //datePacker?.setDate(Date(), animated: false)
        
        datePacker?.addTarget(self, action: #selector(VCreserviedPlace.dateChanged(datePacker:textFiled:)), for: .valueChanged)
        fromDate.inputView = datePacker
        todate.inputView = datePacker
        
        
        let tabGest = UITapGestureRecognizer(target: self, action: #selector(VCreserviedPlace.tapGestor(tabGester:)))
        view.addGestureRecognizer(tabGest)
    }
    
    
    @objc func dateChanged(datePacker  : UIDatePicker , textFiled : UITextField ){
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
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
    
        guard let name = self.nameText.text , !name.isEmpty else{return
            Messages.errorMessage(errorMessage: "الاسم ", view: view)}
        
        guard let phone = self.phoneText.text  , !phone.isEmpty else { return  Messages.errorMessage(errorMessage: "رقم الهاتف", view: view)}
        
        guard let toDate  = self.todate.text , !toDate.isEmpty else {return  Messages.errorMessage(errorMessage: "ادخل تاريخ النهايه", view: view)}
        
        guard  let fromDate  = self.fromDate.text ,!fromDate.isEmpty else {
            return  Messages.errorMessage(errorMessage: "ادخل تاريخ البداية", view: view)}
        
        let dateFormater  = DateFormatter()
        dateFormater.dateFormat =  "dd/MM/yyyy"
        
        let startDate = dateFormater.date(from: fromDate)
        let endDate = dateFormater.date(from: toDate)
        
        if let startDate = startDate , let endDate = endDate{
            if startDate < endDate {
                AuthServices.instance.UserToken = "Ahmedelesawy"
                Api.instance.ReservePlace(placeID: self.placeID ?? 0 , name: name, phone: phone, startDate: fromDate, endDate: toDate, token: AuthServices.instance.UserToken) { (message, error) in
                    if let message = message {
                        Messages.sucessfulMessage(message: message, view: self.view)
                    }
                }
            }
            else{
                Messages.errorMessage(errorMessage: "التاريخ غير مضبوط", view: view)
            }
        }
    }
   
    
    
    
    
    
    
}

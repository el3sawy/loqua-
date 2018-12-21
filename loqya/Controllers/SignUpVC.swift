//
//  SignUpVC.swift
//  loqya
//
//  Created by Ahmed on 8/24/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import UIKit

class VCsignUp: UIViewController , UITextFieldDelegate{
    
    //Varibles
    private var datePacker : UIDatePicker?
    var text : UITextField = UITextField()
    var dateValue : String?
    
    //outlets
    @IBOutlet weak var fromDate: customeText! {didSet{fromDate.setIcon(#imageLiteral(resourceName: "home"))}}
    @IBOutlet weak var todate: customeText!{didSet{todate.setIcon(#imageLiteral(resourceName: "home"))}}
    @IBOutlet weak var phoneText: customeText!
    @IBOutlet weak var nameText: customeText!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show Keyboard Numbers
        phoneText.keyboardType = .numberPad
      
        
        //Show DatePacker When Click on textFiled
      
        
     }
    
    func showDatePackerWhenClickText (){
        datePacker = UIDatePicker()
        datePacker?.datePickerMode = .date
        datePacker?.addTarget(self, action: #selector(VCsignUp.dateChanged(datePacker:textFiled:)), for: .valueChanged)
        
        todate.inputView = datePacker
        fromDate.inputView = datePacker
        
        let tabGest = UITapGestureRecognizer(target: self, action: #selector(VCsignUp.tapGestor(tabGester:)))
        view.addGestureRecognizer(tabGest)
        
    }
    
    
    @objc func dateChanged(datePacker  : UIDatePicker , textFiled : UITextField ){
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        dateValue =   dateFormater.string(from: datePacker.date)
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
            return  Messages.errorMessage(errorMessage: "ادخل تاريخ البداية", view: view)
        }
        
    }
    
    //for set value for each txtfiled from date  and to date
    @IBAction func textDidExit(_ sender: Any) {
        (sender as? UITextField)?.text = dateValue
    }

    

}

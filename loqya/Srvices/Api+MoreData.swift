import Foundation
import Alamofire
import  SwiftyJSON

extension Api{
    
    func getOurContactsData(complition : @escaping (_ email : String? , _ phobe:String?, _ mobile:String?,_ fax : String? , _ error: Bool )->Void){
        
        Alamofire.request(URL_Our_Contacts).responseJSON { (response) in
            if response.result.error == nil{
                
                guard  let data = response.data else {return}
                let json = JSON(data)
                let arrayData = json["data"].arrayValue
                
                let email = arrayData[0]["email"].stringValue
                let phone = arrayData[0]["phone"].stringValue
                let mobile = arrayData[0]["mobile"].stringValue
                let fax = arrayData[0]["fax"].stringValue
                
                complition(email, phone, mobile, fax, true)
            }
            else{
                complition(nil, nil, nil, nil, false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getOpinionClients(complition : @escaping ComplationHandler){
        
        Alamofire.request(URL_OpnionCleints).responseJSON { (response) in
            if response.result.error == nil{
                
                guard let data = response.data else {return }
                let json = JSON(data)
                
                for item in json["data"].arrayValue{
                    
                    let name = item["name"].stringValue
                    let opinion = item["opinion"].stringValue
                    let opinionClient = OpnionClient(clientName: name, clientOpinion: opinion)
                    Api.instance.arrayopnions.append(opinionClient)
                }
                complition(true)
            }
            else{
                complition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }

    func sendContactUsData(name : String, phone : String,email:String,title:String,message : String ,complition:  @escaping(_ error : String?,_ message: String?)->Void){
        
        let body = [
            "name" : name,
            "phone": phone,
            "email" : email,
            "title" : title,
            "message" : message ]
        
        Alamofire.request(URL_ContactUs, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else{return}
                let json = JSON(data)
                let result = json["message"].stringValue
                complition(nil, result)
            }
                
            else{
                complition(response.result.error as? String, nil)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getCommonQuestions(complition :@escaping ComplationHandler){
        Alamofire.request(URL_Common_Questions).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else {return}
                let json = JSON(data)
                
                for item in json["data"].arrayValue{
                    let title = item["title"].stringValue
                    let details = item["details"].stringValue
                    let question = CommonQuestion(title: title, details: details)
                    Api.instance.arrayQuestions.append(question)
                    
                }
                complition(true)
            }
            else{
                complition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}

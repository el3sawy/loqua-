
import Foundation
import Alamofire
import SwiftyJSON

extension Api{
    
    func ReservePlace (placeID : Int , name : String ,  phone : String ,startDate : String , endDate : String , token : String , complition : @escaping(_ message : String? , _ error  : Bool?)->Void){
        
        let body : [String : Any]  = [
            "place_id" : placeID,
            "name" : name,
            "phone" : phone,
            "start_date" : startDate ,
            "end_date" : endDate ,
            "firebase_token" : token
        ]
        Alamofire.request(URL_Reserve_Place, method: .post, parameters:body, encoding:JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else{return}
                let json = JSON(data)
                let message = json["message"].stringValue
                complition(message, true)
                
            }else{
                
                complition(nil , false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func UserReservation (token : String? , complition : @escaping ComplationHandler){
        
        guard let userToken = token else{return}
        Alamofire.request("\(URL_User_Reservatuion)\(userToken)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response ) in
            if response.result.error == nil {
                guard let data  = response.data else{return}
                let json = JSON( data)
                for item in json["data"].arrayValue{
                    let placeID = item["place_id"].intValue
                    let start_date = item["start_date"].stringValue
                    let end_date = item["end_date"].stringValue
                    let imagesPath = item["imagesPath"].stringValue
                    let title = item["place"]["title"].stringValue
                    let image =  item["place"]["image"].stringValue
                    let rating = item["place"]["rating"].intValue
                    let price = item["place"]["price"].intValue
                    
                    let place = Places(id: placeID, title: title, imageName: image, rate: rating, imagePath: imagesPath, startDate: start_date, endDate: end_date ,price : price)
                    print(end_date + start_date)
                    self.arrUserReserved.append(place)
                    print("ahmed inside ")
                    print(start_date)
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

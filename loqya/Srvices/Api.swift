import Foundation
import  SwiftyJSON
import Alamofire

class Api{
    
    //Variables
    static let instance = Api()
    var PlacessArray = [Places]()
    var arryOffers = [Places]()
    var departmentArray = [Department]()
    var arrayopnions = [OpnionClient]()
    var arrayQuestions = [CommonQuestion]()
    var arrUserReserved = [Places]()
    
    func getAllDepartment(complition : @escaping ComplationHandler){
        
        Alamofire.request(URL_DEPTS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.error == nil{
                
                guard let data  = response.data else {return}
                let json = JSON(data)
                for item in json["data"].arrayValue{
                    
                    let deptId = item["id"].intValue
                    let deptName = item["name"].stringValue
                    let dept = Department(deptName: deptName, deptId: deptId)
                    self.departmentArray.append(dept)
                }
                
                complition(true)
            }
            else{
                complition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getPlacesByDeptId(dept_id : Int , complestion: @escaping ComplationHandler){
        
        Alamofire.request("\(URL_Places_By_Dept_ID)\(dept_id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.error == nil{
                
                guard let data = response.data else{return}
                let json = JSON(data)
                for item in json["data"].arrayValue{
                    
                    let place_id = item["id"].intValue
                    let place_title = item["title"].stringValue
                    let  place_image  = item["image"].stringValue
                    let place_rating = item["rating"].intValue
                    let place_imagePath = item["imagesPath"].stringValue
                    
                    let place = Places(id: place_id, title: place_title, imageName: place_image, rate: place_rating, imagePath: place_imagePath)
                    
                    self.PlacessArray.append(place)
                }
                
                complestion(true)
            }
            else{
                
                debugPrint(response.result.error as Any)
                complestion(false)
            }
        }
    }
    
    func getDataForSelectedPlace(placeID : Int , complition :@escaping (_ error : Bool? ,_ place : Places?)->Void){
        
        Alamofire.request("\(URL_Place_By_ID)\(placeID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                var imagesArray  = [String]()
                guard let data = response.data else{return}
                let json = JSON(data)
                let id  = json["data"]["id"].intValue
                let title = json["data"]["title"].stringValue
                let details = json["data"]["details"].stringValue
                let price = json["data"]["price"].intValue
                let rating = json["data"]["rating"].intValue
                let image = json["data"]["image"].stringValue
                let area = json["data"]["area"].stringValue
                let availiable = json["data"]["availiable"].stringValue
                let address = json["data"]["address"].stringValue
                let workers = json["data"]["workers"].stringValue
                let rooms = json["data"]["rooms"].stringValue
                let chair = json["data"]["chairs"].stringValue
                let pathImages = json["data"]["imagesPath"].stringValue
                let images = json["data"]["images"].arrayValue
                
                for item in images{
                    imagesArray.append(item["image"].stringValue)
                }
                let place = Places(id: id, title: title, imageName: image, rate: rating, imagePath: pathImages, details: details, price: price, area: area, avilable: availiable, address: address, worker: workers, rooms: rooms, chair: chair,imagesArray : imagesArray)
                complition(true,place)
            }
            else{
                complition(false, nil)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func searchPlace (placeName : String , complition:@escaping ComplationHandler){
        
        let body : [String : Any] = ["q" : placeName]
        Alamofire.request(URL_Place_Search, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                
                
                complition(true)
            }
            else{
                
                complition(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    //-----------------------------Offers-----------------
    
    func getOffersData(complition:@escaping ComplationHandler){
        
        Alamofire.request(URL_Offers).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else{return}
                let json = JSON(data)
                for item in json["data"].arrayValue{
                    
                    let precentage = item["percentage"].stringValue
                    let imagesPath = item["imagesPath"].stringValue
                    let placeId = item["place"]["id"].intValue
                    let placeTitle = item["place"]["title"].stringValue
                    let placeImage = item["place"]["image"].stringValue
                    let placeRating = item["place"]["rating"].intValue
                    let placePrice = item["place"]["price"].intValue
                    let placeprice_after_discount = item["place"]["price_after_discount"].intValue
                    let place = Places(id: placeId, title: placeTitle, imageName: placeImage, rate: placeRating, imagePath: imagesPath, percentage: precentage, price_after_discount: placeprice_after_discount, price: placePrice)
                    
                    self.arryOffers.append(place)
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


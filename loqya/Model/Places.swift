import Foundation
class  Places {
    
    
    public private(set) var placeID  : Int!
    public private(set) var placeTitle : String!
    public private(set) var placeImageName : String?
    public private(set) var placeRating : Int?
    public private(set) var placeImagePath :String?
    
    public private(set) var placeDetails :String?
    public private(set) var placePrice :Int?
    public private(set) var placeArea :String?
    public private(set) var placeAvilable :String?
    public private(set) var placeWorker :String?
    public private(set) var placeRoooms :String?
    public private(set) var placeAddress :String?
    public private(set) var placeChair :String?
    public private(set) var imagesArray :[String]?
    
    public private(set) var precentage : String!
    public private(set) var price_after_discount : Int!
    
    public private(set) var startDate : String!
    public private(set) var endDate : String!
    
    init() {
        
    }
    
    //MARK :  init for get primary data for all places
    init (id : Int , title:String, imageName : String, rate: Int, imagePath :String) {
        self.placeID  = id
        self.placeTitle = title
        self.placeImageName = imageName
        self.placeRating = rate
        self.placeImagePath  = imagePath
    }
    
    
    //Designated Initializers and Convenience Initializers
    // init for get all details for specified Place
    convenience init (id : Int , title:String, imageName : String, rate: Int, imagePath :String , details : String , price:Int,area: String,avilable:String,address:String,worker :String ,rooms : String,chair:String , imagesArray : [String]) {
        
        self.init(id: id, title: title, imageName: imageName, rate: rate, imagePath: imagePath)
        
        self.placeDetails = details
        self.placePrice = price
        self.placeArea = area
        self.placeAvilable = avilable
        self.placeAddress = address
        self.placeChair = chair
        self.placeRoooms = rooms
        self.placeWorker = worker
        self.imagesArray = imagesArray
    }
    
    // init for Offers
    convenience init(id : Int , title:String, imageName : String, rate: Int, imagePath :String ,percentage : String , price_after_discount : Int , price :Int  ) {
        
        self.init(id: id, title: title, imageName: imageName, rate: rate, imagePath: imagePath)
        
        self.precentage = percentage
        self.price_after_discount = price_after_discount
        self.placePrice  = price
    }
    
    convenience init (id : Int , title:String, imageName : String, rate: Int, imagePath :String, startDate : String , endDate: String , price : Int){
        
        self.init(id: id, title: title, imageName: imageName, rate: rate, imagePath: imagePath)
        self.startDate = startDate
        self.endDate = endDate
        self.placePrice = price
    }
    
}


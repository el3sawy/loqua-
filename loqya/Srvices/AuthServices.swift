import Foundation

class AuthServices {
    static let instance = AuthServices()
    private let defaults  = UserDefaults.standard
    
    var UserToken : String {
        get {
            if let tokenUser = defaults.value(forKey: TOKEN) as? String {
                return tokenUser
            }
            else{
                return ""
            }
            
        }
        set{
            defaults.set(newValue, forKey: TOKEN)
        }
    }
    
    var UserName : String{
        get {
            if let userName = defaults.value(forKey: User_Name) as? String{
                return userName
            }
            else{
                return ""
            }
        }
        set{
            defaults.set(newValue, forKey: User_Name)
        }
    }
}

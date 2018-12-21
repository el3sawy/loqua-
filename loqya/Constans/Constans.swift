import Foundation

typealias ComplationHandler = (_ Success:Bool)->()

let BASE_URL = "https://luqia.net/api/"
let URL_DEPTS = "\(BASE_URL)depts"
let URL_Places_By_Dept_ID = "\(BASE_URL)places/"
let URL_Place_By_ID = "\(BASE_URL)places/show/"
let URL_Place_Search = "\(BASE_URL)search"
let URL_Our_Contacts = "\(BASE_URL)our-contacts"
let URL_OpnionCleints = "\(BASE_URL)clients-opinions"
let URL_ContactUs = "\(BASE_URL)contact_us"
let URL_Common_Questions = "\(BASE_URL)faq"
let URL_Offers = "\(BASE_URL)offers"
let URL_Reserve_Place = "\(BASE_URL)reserve"
let URL_User_Reservatuion = "\(BASE_URL)user-reservations/"

//User Defaults
let TOKEN = "token"
let User_Name = "name"

let HEADER = [
    "Content-Type" :"application/json; charset=UTF-8"
]

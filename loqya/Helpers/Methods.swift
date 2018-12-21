//
//  Methods.swift
//  loqya
//
//  Created by Ahmed on 9/29/1397 AP.
//  Copyright © 1397 Ahmed. All rights reserved.
//

import Foundation

// check for email Validation
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

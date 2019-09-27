//
//  FormValidation.swift
//  GroceryApp
//
//  Created by Utsav Dave on 2019-09-15.
//  Copyright © 2019 Utsav Dave. All rights reserved.
//

import Foundation
import UIKit

class Utilities
{
    static func isPasswordValid(_ password: String) -> Bool
    {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z]).{8,}$")
        
        return passwordTest.evaluate(with: password)
    }
}

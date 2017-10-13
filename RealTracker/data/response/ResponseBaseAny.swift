//
//  ResponseBaseAny.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class ResponseBaseAny: NSObject {
    
    internal var success: Bool? = false {
        didSet { success = success ?? false }
    }
    internal var message: String? = "" {
        didSet { message = message ?? "" }
    }
    internal var result: [String : AnyObject]? = [:] {
        didSet { result = result ?? [:] }
    }
}

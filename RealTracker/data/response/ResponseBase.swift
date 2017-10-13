//
//  ResponseBase.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class ResponseBase: NSObject {
    
    internal var success: Bool? = false {
        didSet { success = success ?? false }
    }
    internal var message: String? = "" {
        didSet { message = message ?? "" }
    }
    internal var result: String? = "" {
        didSet { result = result ?? "" }
    }
    
    override var description: String {
        return "\(ResponseBase.self) { success: \(success!), message: \(message!), result: \(result!)}"
    }
}


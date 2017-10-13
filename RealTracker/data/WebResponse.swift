//
//  WebResponse.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class WebResponse: NSObject {
    
    var respuestaJSON   : AnyObject?
    var statusCode      : NSInteger?
    var respuestaNSData : Data?
    var error           : Error?
    var datosCabezera   : NSDictionary?
    var token           : NSString?
    var cookie          : NSString?
    
}

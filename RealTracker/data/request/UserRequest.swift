//
//  UserRequest.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation
//{"mailEmpleado":"glara@gorilla-soft.com","passEmpleado":"123456"}
class UserRequest: NSObject {
    let mailEmpleado: String!
    let passEmpleado: String!
    
    init(mailEmpleado: String, passEmpleado: String) {
        self.mailEmpleado = mailEmpleado
        self.passEmpleado = passEmpleado
    }
    
    func body() -> NSDictionary {
        return [
            "mailEmpleado" : mailEmpleado,
            "passEmpleado" : passEmpleado
        ]
    }
}

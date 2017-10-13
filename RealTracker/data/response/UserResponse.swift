//
//  UserResponse.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 9/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class UserResponse: BaseResponse {
    var idEmpleado: Int!
    var mailEmpleado: String!
    var nomEmpleado: String!
    var apeEmpleado: String!
    var celEmpleado: String!
    var imgEmpleado: String!
    var idTipoEmpleado: Int!
    var idVehiculo: Int!
    
    init(idEmpleado: Int, mailEmpleado: String, nomEmpleado: String, apeEmpleado: String, celEmpleado: String, imgEmpleado: String, idTipoEmpleado: Int, idVehiculo: Int) {
        super.init()
        self.idEmpleado = idEmpleado
        self.mailEmpleado = mailEmpleado
        self.nomEmpleado = nomEmpleado
        self.apeEmpleado = apeEmpleado
        self.celEmpleado = celEmpleado
        self.imgEmpleado = imgEmpleado
        self.idTipoEmpleado = idTipoEmpleado
        self.idVehiculo = idVehiculo
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}

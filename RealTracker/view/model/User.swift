//
//  User.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation
class User: NSObject {
    let idEmpleado: Int!
    let mailEmpleado: String!
    let nomEmpleado: String!
    let apeEmpleado: String!
    let celEmpleado: String!
    let imgEmpleado: String!
    let idTipoEmpleado: Int!
    let idVehiculo: Int!
    
    init(idEmpleado: Int, mailEmpleado: String, nomEmpleado: String, apeEmpleado: String, celEmpleado: String, imgEmpleado: String, idTipoEmpleado: Int, idVehiculo: Int) {
        self.idEmpleado = idEmpleado
        self.mailEmpleado = mailEmpleado
        self.nomEmpleado = nomEmpleado
        self.apeEmpleado = apeEmpleado
        self.celEmpleado = celEmpleado
        self.imgEmpleado = imgEmpleado
        self.idTipoEmpleado = idTipoEmpleado
        self.idVehiculo = idVehiculo
    }
    
    override var description: String {
        return "User {idEmpleado: \(idEmpleado), mailEmpleado: \(mailEmpleado), nomEmpleado: \(nomEmpleado), apeEmpleado: \(apeEmpleado), celEmpleado: \(celEmpleado), imgEmpleado: \(imgEmpleado), idTipoEmpleado: \(idTipoEmpleado), idVehiculo: \(idVehiculo)}"
    }
}

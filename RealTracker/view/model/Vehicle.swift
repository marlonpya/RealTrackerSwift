//
//  Vehicle.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation

class Vehicle: NSObject {
    let idUbicacion: Int!
    let idVehiculo: Int!
    let idConductor: Int!
    let numLatitud: String!
    let numLongitud: String!
    let numVelocidad: String!
    let placaVehiculo: String!
    let imgVehiculo: String!
    let nomConductor: String!
    let licConductor: String!
    let idRuta: Int!
    let nomRuta: String!
    
    init(idUbicacion: Int, idVehiculo: Int, idConductor: Int, numLatitud: String, numLongitud: String, numVelocidad: String, placaVehiculo: String, imgVehiculo: String, nomConductor: String, licConductor: String, idRuta: Int, nomRuta: String) {
        self.idUbicacion = idUbicacion
        self.idVehiculo = idVehiculo
        self.idConductor = idConductor
        self.numLatitud = numLatitud
        self.numLongitud = numLongitud
        self.numVelocidad = numVelocidad
        self.placaVehiculo = placaVehiculo
        self.imgVehiculo = imgVehiculo
        self.nomConductor = nomConductor
        self.licConductor = licConductor
        self.idRuta = idRuta
        self.nomRuta = nomRuta
    }
    
    override var description: String {
        return "Vehicle {idUbicacion: \(idUbicacion), idVehiculo: \(idVehiculo), idConductor: \(idConductor), numLatitud: \(numLatitud), numLongitud: \(numLongitud), numVelocidad: \(numVelocidad), placaVehiculo: \(placaVehiculo), imgVehiculo: \(imgVehiculo), nomConductor: \(nomConductor), licConductor: \(licConductor), idRuta: \(idRuta), nomRuta: \(nomRuta)}"
    }
}

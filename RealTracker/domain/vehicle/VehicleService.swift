//
//  VehicleService.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation

class VehicleService: NSObject {
    
    static func getListHevicle(psIdUser: String, withCompletion completion: @escaping(_ paoListVehicle: [Vehicle]?,_ psMessageError: String) -> Void) {
        let loParameter: [String: AnyObject] = [
            ServiceConstant.Paths.ServicesGet.Parameter.LIST_VEHICLE_ID_VEHICLE: psIdUser as AnyObject
        ]
        WebSender.doGETToURL(conPath: ServiceConstant.Paths.ServicesGet.LIST_VEHICLE, conParametros: loParameter) { (json) in
            let lsMessage = WebModel.obtenerMensajeErrorParaRespuesta(json)!
            if !lsMessage.isEmpty {
                completion(nil, lsMessage)
            } else {
                var loJsonResponse: [[String: AnyObject]]
                do {
                    loJsonResponse = json.respuestaJSON?["result"] as! [[String: AnyObject]]
                }catch {
                    print(error.localizedDescription)
                }
                if loJsonResponse != nil {
                    var laoListVehicle = [Vehicle]()
                    for loJsonVehicle in loJsonResponse {
                        let loVehicle = Vehicle(idUbicacion: loJsonVehicle["idUbicacion"] as? Int ?? -1,
                                                idVehiculo: loJsonVehicle["idVehiculo"] as? Int ?? -1,
                                                idConductor: loJsonVehicle["idConductor"] as? Int ?? -1,
                                                numLatitud: loJsonVehicle["numLatitud"] as? String ?? "",
                                                numLongitud: loJsonVehicle["numLongitud"] as? String ?? "",
                                                numVelocidad: loJsonVehicle["numVelocidad"] as? String ?? "",
                                                placaVehiculo: loJsonVehicle["placaVehiculo"] as? String ?? "",
                                                imgVehiculo: loJsonVehicle["imgVehiculo"] as? String ?? "",
                                                nomConductor: loJsonVehicle["nomConductor"] as? String ?? "",
                                                licConductor: loJsonVehicle["licConductor"] as? String ?? "",
                                                idRuta: loJsonVehicle["idRuta"] as? Int ?? -1,
                                                nomRuta: loJsonVehicle["nomRuta"] as? String ?? "")
                        print("_VEHICLE \(loVehicle)")
                        laoListVehicle.append(loVehicle)
                    }
                    completion(laoListVehicle, "")
                } else {
                    completion(nil, lsMessage)
                }
            }   
        }
    }
}

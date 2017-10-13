//
//  LoginService.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//
import UIKit

class LoginService: NSObject {
    static func login(request: UserRequest, withCompletion completion: @escaping (_ userResponse: User?,_ messageError: String) -> Void) {
        WebSender.doPOSTToURL(conURL: ServiceConstant.getURLBase() as NSString, conPath: ServiceConstant.Paths.ServicesPost.LOGIN as NSString, conParametros: request.body() as AnyObject) { (json) in
            let message = WebModel.obtenerMensajeErrorParaRespuesta(json)!
            if !message.isEmpty {
                completion(nil, message)
            } else {
                var jsonResponse: [String: AnyObject]
                do {
                    jsonResponse = json.respuestaJSON?["result"] as! [String: AnyObject]
                }catch {
                    print(error.localizedDescription)
                }
                if jsonResponse != nil {
                    let user = User(idEmpleado: jsonResponse["idEmpleado"] as? Int ?? -1,
                                    mailEmpleado: jsonResponse["mailEmpleado"] as? String ?? "",
                                    nomEmpleado: jsonResponse["nomEmpleado"] as? String ?? "",
                                    apeEmpleado: jsonResponse["apeEmpleado"] as? String ?? "",
                                    celEmpleado: jsonResponse["celEmpleado"] as? String ?? "",
                                    imgEmpleado: jsonResponse["imgEmpleado"] as? String ?? "",
                                    idTipoEmpleado: jsonResponse["idTipoEmpleado"] as? Int ?? -1,
                                    idVehiculo: jsonResponse["idVehiculo"] as? Int ?? -1)
                    print("_USER \(user)")
                    completion(user, "")
                } else {
                    completion(nil, message)
                }
                
//                if let jsonResponse = json.respuestaJSON?["result"] as! [String: AnyObject] {
//
//                } else {
//
//                }
            }
        }
    }
}

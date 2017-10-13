//
//  WebModel.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class WebModel: NSObject {
    
    
    //    static let WebModelURLBase = "http://dev-dsala..pe/webservice"      // Desarrollo
    static let WebModelURLBase = "http://172.21.216.150/AppSieteCompromisos"            // Producción
    
    //    class func obtenerMensajeErrorParaRespuesta(_ respuesta : WebResponse) -> String? {
    //
    //        guard let diccionarioRespuesta : NSDictionary = respuesta.respuestaJSON as? NSDictionary else {
    //
    //            return "Error de conexión a internet."
    //        }
    //
    //        if diccionarioRespuesta["success"] as! Int == 0 {
    //            let mensaje = diccionarioRespuesta["Exception"] as? String
    //            return mensaje
    //
    //        } else {
    //            return "La aplicación no responde."
    //        }
    //
    //    }
    
    
    // SERVICIO TEST
    
    
//    class func nameOfTheActionThatWillConsumeURL(_ nameOfFirstParameter : UserBE, _ nameOfSecondParameter : String, _ nameOfThirdParameter: [UserBE], conCompletion completion : @escaping (_ news : [PublicationBE]?, _ mensajeError : String?) -> Void) {
//
//
//        let dic : NSDictionary = ["CodigoUsuarioSesion"         : "gmdsa\\fmateo", //nameOfFirstParameter.user_id
//            "CodigoUsuarioBuscar"         : "",
//            "CodigoNoticia"               : "",
//            "RegistroInicio"              : 0,
//            "CantidadRegistro"            : 10
//        ]
//
//        WebSender.doPOSTToURL(conURL: self.WebModelURLBase as NSString, conPath: "CompromisoService.svc/ListarNoticia", conParametros: dic) { (objRespuesta) in
//
//            let mensajeError = self.obtenerMensajeErrorParaRespuesta(objRespuesta)
//            var newsOfUser = [PublicationBE]()
//
//            var arrayRespuesta = [[String: AnyObject]]()
//
//            if objRespuesta.respuestaJSON == nil {
//                completion(newsOfUser, "Falla del servidor")
//            } else {
//                arrayRespuesta = objRespuesta.respuestaJSON?["Data"] as! [[String : AnyObject]]
//
//                if arrayRespuesta.count != 0 {
//                    for item in arrayRespuesta {
//                        newsOfUser.append(WebTranslator.translatePublicationsBE(item))
//                    }
//                    print(newsOfUser)
//                    completion(newsOfUser, mensajeError)
//                } else {
//                    completion(newsOfUser, mensajeError)
//                }
//            }
//
//
//        }
//
//
//    }
    
    class func obtenerMensajeErrorParaRespuesta(_ respuesta : WebResponse) -> String? {
        
        guard let diccionarioRespuesta = respuesta.respuestaJSON as? [String : AnyObject] else {
            
            return ServiceConstant.Messages.ERROR_SERVICE
        }
        
        if diccionarioRespuesta["success"] as! Bool != true {
            
            let mensaje = diccionarioRespuesta["message"] as? String
            return mensaje
            
        } else {
            return ""
        }
        
    }
    
    ///obtener response base
    class func obtenerResponseBasePost(_ respuesta : WebResponse) -> ResponseBase? {
        
        //        guard let diccionarioRespuesta = respuesta.respuestaJSON as? [String : AnyObject] else {
        //
        //            return ServiceConstant.Messages.ERROR_SERVICE
        //        }
        //
        //        if diccionarioRespuesta["success"] as! Bool != true {
        //            let mensaje = diccionarioRespuesta["message"] as? String
        //
        //        } else {
        //            return ""
        //        }
        let diccionarioRespuesta = respuesta.respuestaJSON
        let response = ResponseBase()
        response.message = diccionarioRespuesta?["message"] as? String
        response.result = diccionarioRespuesta?["result"] as? String
        response.success = diccionarioRespuesta?["success"] as? Bool
        
        return response
    }
    /***/
    class func obtenerResponseBaseAnyObjectPost(_ respuesta : WebResponse) -> ResponseBaseAny? {
        
        //        guard let diccionarioRespuesta = respuesta.respuestaJSON as? [String : AnyObject] else {
        //
        //            return ServiceConstant.Messages.ERROR_SERVICE
        //        }
        //
        //        if diccionarioRespuesta["success"] as! Bool != true {
        //            let mensaje = diccionarioRespuesta["message"] as? String
        //
        //        } else {
        //            return ""
        //        }
        let diccionarioRespuesta = respuesta.respuestaJSON
        let response = ResponseBaseAny()
        response.message = diccionarioRespuesta?["message"] as? String
        response.result = diccionarioRespuesta?["result"] as? [String : AnyObject]
        
        response.success = diccionarioRespuesta?["success"] as? Bool
        
        return response
    }
    
    
    // MAS EJEMPLOS
    
    
    //    class func iniciarSesionParaUsuario(_ usuario : DSUsuarioBE, conCompletion completion : @escaping (_ usuario : DSUsuarioBE?, _ mensajeError : String?) -> Void) {
    //
    //        let dic : NSDictionary = ["email"       : usuario.usuario_correo!,
    //                                  "password"    : usuario.usuario_contrasena!,
    //                                  "typeDevice"  : "3",
    //                                  "tokenDevice" : usuario.usuario_tokenDevice!]
    //
    //        WebSender.doPOSTToURL(conURL: self.WebModelURLBase as NSString, conPath: "user/login", conParametros: dic) { (objRespuesta) in
    //
    //            let mensajeError = self.obtenerMensajeErrorParaRespuesta(objRespuesta)
    //            var usuario : DSUsuarioBE? = nil
    //
    //            let arrayRespuesta = objRespuesta.respuestaJSON?["data"] as? NSArray
    //
    //            if arrayRespuesta != nil && arrayRespuesta?.count != 0 {
    //                let diccionrioUsuario = arrayRespuesta![0] as! NSDictionary
    //                usuario = WebTranslator.translateUsuarioBE(diccionrioUsuario)
    //            }
    //
    //            completion(usuario, mensajeError)
    //        }
    //    }
    //
    //
    //
    //    class func cerrarSession(_ usuario : DSUsuarioBE, conCompletion completion : @escaping (_ esCorrecto : Bool, _ mensajeError : String?) -> Void) {
    //
    //        WebSender.doGETTokenToURL(conURL: self.WebModelURLBase as NSString, conPath: "user/close-session", conParametros: nil, conToken: usuario.usuario_tokenSesion! as NSString) { (objRespuesta) in
    //
    //            let mensajeError = self.obtenerMensajeErrorParaRespuesta(objRespuesta)
    //            var estado = false
    //
    //            if objRespuesta.respuestaJSON != nil {
    //                let diccionarioRespuesta : NSDictionary = objRespuesta.respuestaJSON as! NSDictionary
    //                estado = (diccionarioRespuesta["status"] as? NSNumber == nil) ? false : ((diccionarioRespuesta["status"] as AnyObject).boolValue)!
    //            }
    //
    //            completion(estado, mensajeError)
    //        }
    //
    //    }
    
    
    
}


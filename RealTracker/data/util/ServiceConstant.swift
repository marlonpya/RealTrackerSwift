//
//  ServiceConstant.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class ServiceConstant: NSObject {
    //ServiceConstants.ServicesBase.getURLBase()
    //http://104.197.87.14:8080/gs_tracking/api/empleado/login/
    //http://104.197.87.14:8080/gs_tracking/api/ubicacion/?idVehiculo=2
    //http://104.197.87.14:8080/gs_tracking/apiubicacion/?idVehiculo=1
    struct ServicesBase {
        static let APIScheme = "http"
        static let URL_LOCAL = "104.197.87.14" //172.16.100.62 chile http://mobile-adexus-day.adexus.com
        static let URL_CLIENTE = "/gs_tracking/"
        static let PORT_LOCAL = 8080
        //static let PORT_CLIENTE = nil
        static let PATH_LOCAL = "/gs_tracking/api/"
        static let PATH_CLIENTE = "/gs_tracking/api/"
        
        static let APIHost = URL_LOCAL
        static let APIPath = PATH_LOCAL
        static let URL_BASE = APIScheme
        static let PORT = PORT_LOCAL
        
        // static let URL_PATH_BASE = "http://10.244.4.20:8080/evento-back/api"
        
    }
    
    static func getURLBase() -> String {
        
        var components = URLComponents()
        components.scheme = ServicesBase.APIScheme
        components.host = ServicesBase.APIHost
        components.port = ServicesBase.PORT_LOCAL
        components.path = ServicesBase.APIPath
        //return components.url!.description
        return "http://104.197.87.14:8080/gs_tracking/api/"
    }
    
    struct Values {
        static let ID_EVENTO = 1
        static let TIMEOUT = 40
    }
    
    struct Messages {
        static let CONFIRMACION = "¿Está seguro de aceptar la solicitud?"
        static let REPROGRAMACION = "¿Está seguro de reprogramar la solicitud?"
        static let ERROR_SERVICE = "No se pudo conectar al servidor"
        static let TITLE_DIALOGO = "Aprobaciones"
        static let MESSAGE_USUARIO_CLAVE = "Por favor ingrese usuario y/o clave"
        static let MESSAGE_ACCEPT_TERM = "Debe aceptar los términos y condiciones"
        static let ERROR_SERVICIO = "Error de conexion. Reintente"
    }
    
    struct Paths {
        struct ServicesGet {
            //http://104.197.87.14:8080/gs_tracking/api/ubicacion/?idVehiculo=1
            static let LIST_VEHICLE = "ubicacion/"
            
            struct Parameter {
                static let LIST_VEHICLE_ID_VEHICLE = "idVehiculo"
            }
        }
        
        struct ServicesPost {
            static let LOGIN = "empleado/login/"
            
            struct Parameter {
                static let CHARLA_INSCRIPCION_ID = "idCharla"
                static let CHARLA_INSCRIPCION_PARTICIPANTE = "idParticipante"
                static let CHARLA_INSCRIPCION_ESTADO = "inEstado"
                static let VERIFICAR_QR_PARTICIPANTE = "codParticipante"
                static let VERIFICAR_QR_EVENTO = "idEvento"
                static let CHARLA_FORZAR_INSCRIPCION_ID = "idCharla"
                static let CHARLA_FORZAR_INSCRIPCION_PARTICIPANTE = "idParticipante"
                static let SUGERENCIA_PARTICIPANTE = "idParticipante"
                static let SUGERENCIA_EVENTO = "idEvento"
                static let SUGERENCIA_VALORACION = "numValoracion"
                static let SUGERENCIA_CONTENIDO = "txtSugerencias"
            }
        }
        
        struct ServicesPut {
        }
        
    }
    
}


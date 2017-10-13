//
//  WebSender.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//
import UIKit
import Foundation

class WebSender:  NSObject , URLSessionDelegate {
    
    
    //MARK: - Configuración
    
    
    //MARK: - Configuración
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    
    class func crearCabeceraPeticion() -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        
        return diccionarioHeader
    }
    
    
    class func crearCabeceraPeticionConToken(_ aToken : NSString) -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aToken)", forKey: "Authorization" as NSCopying)
        
        return diccionarioHeader
    }
    
    class func crearCabeceraPeticionConCookie(_ aCookie : NSString) -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        
        diccionarioHeader.setObject("application/json; charset=UTF-8", forKey: "Content-Type" as NSCopying)
        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("Bearer \(aCookie)", forKey: "Cookie" as NSCopying)
        
        return diccionarioHeader
    }
    
    class func crearCabeceraConToken(_ aToken : NSString, _ aUUID : NSString, _ aDevice : NSString) -> NSDictionary {
        
        let diccionarioHeader = NSMutableDictionary()
        
        diccionarioHeader.setObject("application/json", forKey: "Content-Type" as NSCopying)
        //        diccionarioHeader.setObject("application/json", forKey: "Accept" as NSCopying)
        diccionarioHeader.setObject("\(aToken)", forKey: "Token" as NSCopying)
        diccionarioHeader.setObject("\(aUUID)", forKey: "Imei" as NSCopying)
        diccionarioHeader.setObject("\(aDevice)", forKey: "Device" as NSCopying)
        
        return diccionarioHeader
    }
    
    
    
    //MARK: - Tratado de respuesta
    
    class func obtenerRespuestaEnJSONConData(_ data : Data) -> Any? {
        
        do{
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        }catch{
            return nil
        }
    }
    
    class func obtenerRespuestaServicioParaData(_ data : Data?, response : URLResponse?, error : Error?) -> WebResponse{
        
        var respuesta : AnyObject?
        let objRespuesta = WebResponse()
        
        if data != nil { //error == nil &&
            
            respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
            print(respuesta as Any)
            
            objRespuesta.respuestaJSON = respuesta
        }
        
        if let urlResponse = response as? HTTPURLResponse {
            
            let headerFields = urlResponse.allHeaderFields as NSDictionary
            objRespuesta.statusCode         = urlResponse.statusCode
            objRespuesta.respuestaNSData    = data
            objRespuesta.error              = error
            objRespuesta.datosCabezera      = headerFields
            objRespuesta.token              = headerFields["_token"] as? NSString
            objRespuesta.cookie             = headerFields["_token"] as? NSString
        }
        
        return objRespuesta
    }
    
    
    //MARK: - Consumo de servicios con cookie
    
    
    
    
    class func doPOSTCookieToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conCookie cookie : NSString, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConCookie(cookie) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    class func doGETCookieToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conCookie cookie : NSString, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConCookie(cookie) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "GET"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    
    
    
    
    
    
    
    
    class func doPUTCookieToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conCookie cookie : NSString, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConCookie(cookie) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    //MARK: - Consumo de servicios con token
    
    class func doPOSTTokenToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conToken token : NSString, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConToken(token) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    
    
    
    
    
    
    class func doGETTokenToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conToken token : NSString, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConToken(token) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "GET"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
        
    }
    
    
    
    
    
    
    
    
    
    class func doPUTTokenToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conToken token : NSString, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticionConToken(token) as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    
    
    //MARK: - Consumo de servicios simple
    
    
    
    
    class func doPOSTToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    class func doPUTToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession(configuration: configuracionSesion)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        var request = URLRequest(url: urlServicio!)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "PUT"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    
    //AdexusDay
    class func doPOSTWithCustomHeaderToURL(conURL url : NSString, conPath path : NSString, conParametros parametros : AnyObject?, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraConToken("ddd", "sss", "ssssss") as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion, delegate: WebSender(), delegateQueue: nil)
        
        let urlServicio = URL(string: "\(url)/\(path)")
        
        print(parametros?.description as Any)
        var request = URLRequest(url: urlServicio!)
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            
            
        } )
        
        postDataTask?.resume()
        
        
        //        self.perform(#selector(WebSender.cancelTask(aTask:)), with: postDataTask, afterDelay:5)
        
        //Para cerrar la Sessión del usuario
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(FeaturesUser.getTimeOut()), execute: {
        //            // Put your code which should be executed with a delay here
        //            if postDataTask?.state == .running {
        //                postDataTask?.cancel()
        //            }
        //        })
        
    }
    
    
    /***a swift3**/
    
    
    static func getURLFromParameters(_ parameters: [String:AnyObject], _ path : String) -> URL {
        
        var components = URLComponents()
        components.scheme = ServiceConstant.ServicesBase.APIScheme
        components.host = ServiceConstant.ServicesBase.APIHost
        components.port = ServiceConstant.ServicesBase.PORT
        components.path = ServiceConstant.ServicesBase.APIPath + path
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.url!
    }
    
    static func getURL(_ path : String) -> URL {
        
        var components = URLComponents()
        components.scheme = ServiceConstant.ServicesBase.APIScheme
        components.host = ServiceConstant.ServicesBase.APIHost
        components.port = ServiceConstant.ServicesBase.PORT
        components.path = ServiceConstant.ServicesBase.APIPath + path
        components.queryItems = [URLQueryItem]()
        
        return components.url!
    }
    
    
    
    class func doGETToURL(conPath path : String, conParametros parametros : [String:AnyObject]?, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        let urlServicio = getURLFromParameters(parametros!, path)//URL(string: "\(url)/\(path)?idEvento=1&idParticipante=1")
        print("url \(urlServicio)")
        var request = URLRequest(url: urlServicio)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "GET"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            
            
        } )
        
        postDataTask?.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(ServiceConstant.Values.TIMEOUT), execute: {
            // Put your code which should be executed with a delay here
            if postDataTask?.state == .running {
                postDataTask?.cancel()
            }
        })
    }
    
    class func doPostToURL(conPath path : String, conParametros parametros : AnyObject?, conCompletion completion : @escaping (_ objRespuesta : WebResponse) -> Void){
        
        let configuracionSesion = URLSessionConfiguration.default
        configuracionSesion.httpAdditionalHeaders = self.crearCabeceraPeticion() as? [AnyHashable: Any]
        
        let sesion = URLSession.init(configuration: configuracionSesion)
        
        //  let urlServicio = URL(string: "\(url)/\(path)")
        let urlServicio = getURL(path)
        var request = URLRequest(url: urlServicio)
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        if parametros != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parametros!, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch {}
        }
        
        request.httpMethod = "POST"
        
        let postDataTask: URLSessionDataTask? = sesion.dataTask(with: request, completionHandler: {( data, response, error) -> Void in
            
            
            DispatchQueue.main.async(execute: {() -> Void in
                
                var respuesta : AnyObject?
                let objRespuesta = WebResponse()
                
                if data != nil { //error == nil &&
                    
                    respuesta = self.obtenerRespuestaEnJSONConData(data!) as AnyObject?
                    print(respuesta as Any)
                    
                    objRespuesta.respuestaJSON = respuesta
                }
                
                if let urlResponse = response as? HTTPURLResponse {
                    
                    let headerFields = urlResponse.allHeaderFields as NSDictionary
                    objRespuesta.statusCode         = urlResponse.statusCode
                    objRespuesta.respuestaNSData    = data
                    objRespuesta.error              = error
                    objRespuesta.datosCabezera      = headerFields
                    objRespuesta.token              = headerFields["_token"] as? NSString
                    objRespuesta.cookie             = headerFields["_token"] as? NSString
                }
                
                completion(objRespuesta)
                
            })
            //            DispatchQueue.main.async(execute: {
            //
            //                completion(self.obtenerRespuestaServicioParaData(data, response: response, error: error))
            //            })
            
        } )
        
        postDataTask?.resume()
    }
    
    
    
    
}


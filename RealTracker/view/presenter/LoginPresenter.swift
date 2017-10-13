//
//  LoginPresenter.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject {
    
    private let goView: LoginView!
    
    init(poView: LoginView) {
        self.goView = poView
    }
    
    func actionSwitchEye(pbShow: Bool) {
        if pbShow {
            goView.showPassword()
        } else {
            goView.hidePassword()
        }
    }
    
    func login(psMail: String, psPassword: String) {
        if psMail.trim().isEmpty || psPassword.trim().isEmpty {
            goView.messageError(message: "Ingrese los valores")
        } else {
            goView.showLoading()
            let loRequest = UserRequest(mailEmpleado: psMail, passEmpleado: psPassword)
            LoginService.login(request: loRequest) { (poUser: User?, psMessage: String) in
                self.goView.hideLoading()
                if !psMessage.isEmpty {
                    self.goView.messageError(message: psMessage)
                    return
                }
                AppDelegate.getInstance().goUser = poUser
                self.goView.login(psUser: poUser!)
            }
        }
    }
}

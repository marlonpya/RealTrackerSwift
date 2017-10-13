//
//  LoginController.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgEye: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    fileprivate var goPresenter: LoginPresenter!
    fileprivate var goLoading: CustomLoading!
    
    override func viewDidLoad() {
        cycleLife = self
        super.viewDidLoad()
        if AppDelegate.getInstance().goUser != nil {
            print(AppDelegate.getInstance().goUser!)
            performSegue(withIdentifier: Constant.Segue.LOGIN_TO_MAIN, sender: nil)
        }
    }
    
    @IBAction func onClickLogIn(_ sender: Any) {
        goPresenter.login(psMail: txtName.text!, psPassword: txtPassword.text!)
    }
    
    @IBAction func onClickEye(_ sender: UIButton) {
        goPresenter.actionSwitchEye(pbShow: sender.tag == 0)
        sender.changeTag()
    }
}

extension LoginController: CycleLife {
    func initView() {
        goPresenter = LoginPresenter(poView: self)
        goLoading = CustomLoading(poController: self, poIndicator: indicator)
        withHideKeyboard()
    }
    
    func ui() {
        
    }
}

extension LoginController: LoginView {
    
    func showPassword() {
        imgEye.setImage(#imageLiteral(resourceName: "ic_visibility_white"), for: .normal)
        txtPassword.isSecureTextEntry = false
    }
    
    func hidePassword() {
        imgEye.setImage(#imageLiteral(resourceName: "ic_visibility_off_white"), for: .normal)
        txtPassword.isSecureTextEntry = true
    }
    
    func login(psUser: User) {
        self.performSegue(withIdentifier: Constant.Segue.LOGIN_TO_MAIN, sender: nil)
        txtName.text = ""
        txtPassword.text = ""
    }
    
    // MARK : - LoadView
    
    func showLoading() {
        goLoading.show()
    }
    
    func hideLoading() {
        goLoading.hide()
    }
    
    func messageError(message: String) {
        showAlert(psMessage: message, withCompletion: nil)
    }
}

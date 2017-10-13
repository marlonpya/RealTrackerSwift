//
//  BaseController.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

protocol CycleLife {
    
    // Use for init variables
    func initView()
    // Use for changes in interface user
    func ui()
}

class BaseController: UIViewController {
    var cycleLife: CycleLife?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cycleLife?.initView()
        cycleLife?.ui()
        onResume()
    }
    
    func showAlert(psMessage: String, withCompletion completion: (() -> Void)?) {
        showAlert(psTitle: "Mensaje", psMessage: psMessage, withCompletion: completion)
    }
    
    func showAlert(psTitle: String, psMessage: String, withCompletion completion: (() -> Void)?) {
        let loAlert = UIAlertController(title: psTitle, message: psMessage, preferredStyle: .alert)
        let loAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            completion?()
        }
        loAlert.addAction(loAction)
        present(loAlert, animated: true)
    }
    
    func withHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension BaseController {
    
    func onResume() {}
}

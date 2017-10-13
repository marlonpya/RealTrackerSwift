//
//  CustoLoading.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class CustomLoading: NSObject {
    let goController: UIViewController!
    var goIndicator: UIActivityIndicatorView!
    
    init(poController: UIViewController, poIndicator: UIActivityIndicatorView) {
        self.goController = poController
        self.goIndicator = poIndicator
        self.goIndicator.isHidden = true
    }
    
    func show() {
        goIndicator.isHidden = false
        goIndicator.startAnimating()
        goController.view.isUserInteractionEnabled = false
    }
    
    func hide() {
        goController.view.isUserInteractionEnabled = true
        goIndicator.stopAnimating()
        goIndicator.isHidden = true
    }
}

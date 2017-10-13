//
//  ListVehiclePresenter.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import UIKit

class ListVehiclePresenter: NSObject {
    private let goView: ListVehicleView!
    
    init(poView: ListVehicleView) {
        self.goView = poView
    }
    
    func actionGetListVehicle(psIdUser: String) {
        goView.showLoading()
        VehicleService.getListHevicle(psIdUser: psIdUser) { (paoListVehicle: [Vehicle]?, psMessage: String) in
            self.goView.hideLoading()
            if !psMessage.isEmpty {
                self.goView.messageError(message: psMessage)
            } else {
                self.goView.renderListVehicle(paoListVehicle: paoListVehicle!)
            }
        }
    }
}

//
//  MapaController.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MapaController: BaseController {
    @IBOutlet var mapView: MKMapView!
    private var goPresenter: ListVehiclePresenter!
    fileprivate var goTimer: Timer?
    fileprivate var gaoListVehicle = [Vehicle]()
    private static let gdSeconds: TimeInterval = 2
    
    override func viewDidLoad() {
        cycleLife = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goTimer = Timer.scheduledTimer(timeInterval: MapaController.gdSeconds, target: self, selector: #selector(callListVehicle), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        goTimer?.invalidate()
        goTimer = nil
    }
    
    @objc private func callListVehicle() {
        goPresenter.actionGetListVehicle(psIdUser: "0")
    }
    
    @IBAction func onClickCloseSession(_ sender: Any) {
        goTimer?.invalidate()
        goTimer = nil
        self.navigationController?.popViewController(animated: true)
        AppDelegate.getInstance().goUser = nil
    }
}

extension MapaController: CycleLife {
    func initView() {
        goPresenter = ListVehiclePresenter(poView: self)
    }
    
    func ui() {
        let latitude = CLLocationDegrees(-10.0000000)
        let longitude = CLLocationDegrees(-76.0000000)
        let ubication = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: ubication, span: MKCoordinateSpan(latitudeDelta: 11, longitudeDelta: 11))
        mapView.setRegion(region, animated: true)
    }
}

extension MapaController: ListVehicleView {
    func renderListVehicle(paoListVehicle: [Vehicle]) {
        gaoListVehicle.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        
        gaoListVehicle = paoListVehicle
        for loVehicle in gaoListVehicle {
            let latitude = (loVehicle.numLatitud as NSString).doubleValue
            let longitude = (loVehicle.numLongitud as NSString).doubleValue
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            let point = MKPointAnnotation()
            point.coordinate = coordinate
            point.title = loVehicle.nomConductor
            mapView.addAnnotation(point)
        }
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func messageError(message: String) {
        //showAlert(psMessage: message, withCompletion: nil)
        print("_ERROR \(message)")
    }
}

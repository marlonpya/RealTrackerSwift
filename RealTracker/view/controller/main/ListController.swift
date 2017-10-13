//
//  ListController.swift
//  RealTracker
//
//  Created by marlon mauro arteaga morales on 8/10/17.
//  Copyright © 2017 marlonpya. All rights reserved.
//

import Foundation
import UIKit

class ListController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate var goPresenter: ListVehiclePresenter!
    fileprivate var goRefreshControl: UIRefreshControl!
    fileprivate var gaoListVehicle = [Vehicle]()
    
    override func viewDidLoad() {
        cycleLife = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        actionGetListVehicle()
    }
    
    @IBAction func onClickCloseSession(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        AppDelegate.getInstance().goUser = nil
    }
    
    @objc fileprivate func actionGetListVehicle() {
        goPresenter.actionGetListVehicle(psIdUser: "0")
    }
}

extension ListController: CycleLife {
    func initView() {
        goPresenter = ListVehiclePresenter(poView: self)
        tableView.dataSource = self
        tableView.delegate = self
        goRefreshControl = UIRefreshControl()
    }
    
    func ui() {
        goRefreshControl.addTarget(self, action: #selector(actionGetListVehicle), for: .valueChanged)
        tableView.addSubview(goRefreshControl)
    }
}

extension ListController: ListVehicleView {
    func renderListVehicle(paoListVehicle: [Vehicle]) {
        gaoListVehicle = paoListVehicle
        tableView.reloadData()
    }
    
    // MARK : - LoadView
    
    func showLoading() {
        goRefreshControl.beginRefreshing()
    }
    
    func hideLoading() {
        goRefreshControl.endRefreshing()
    }
    
    func messageError(message: String) {
        showAlert(psMessage: message, withCompletion: nil)
    }
}

extension ListController: UITableViewDelegate { }

extension ListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gaoListVehicle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let loVehicle = gaoListVehicle[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Id.ViewCell.VEHICLE, for: indexPath)
        cell.textLabel?.text = "\(loVehicle.placaVehiculo ?? "") \(loVehicle.nomRuta ?? "")"
        return cell
    }
}

//
//  SettingsController.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

protocol SettingsControllerProtocol: AnyObject {
     
}

class SettingsController: SettingsControllerProtocol {
    weak var settingsView: SettingsViewProtocol?
    var model: SettingsModelProtocol?
    
    init(settingsView: SettingsViewProtocol) {
        self.settingsView = settingsView
        self.model = SettingsModel(controller: self)
    }
    
    deinit {
        print("SettingsController is out")
    }
}

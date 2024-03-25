//
//  SettingsModel.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

protocol SettingsModelProtocol: AnyObject {
    
}

class SettingsModel: SettingsModelProtocol {
    
    weak var controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol? = nil) {
        self.controller = controller
    }
    
    deinit {
        print("SettingsModel is out")
    }
}

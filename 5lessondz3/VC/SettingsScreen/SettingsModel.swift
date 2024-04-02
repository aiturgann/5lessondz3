//
//  SettingsModel.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

protocol SettingsModelProtocol: AnyObject {
    func deleteNotes()
}

class SettingsModel: SettingsModelProtocol {
    
    weak var controller: SettingsControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
    
    deinit {
        print("SettingsModel is out")
    }
    
    func deleteNotes() {
        coreDataService.deleteNotes()
    }
}

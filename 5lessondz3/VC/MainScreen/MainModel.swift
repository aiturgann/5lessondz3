//
//  MainModel.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import Foundation

protocol MainModelProtocol {
    func getNotes()
}

class MainModel: MainModelProtocol {
    var controller: MainControllerProtocol?
    
    init(controller: MainControllerProtocol) {
        self.controller = controller
    }
    
    var notes: [String] = ["School notes", "Funny jokes", "Travel bucket list", "Random cooking ideas"]
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
}

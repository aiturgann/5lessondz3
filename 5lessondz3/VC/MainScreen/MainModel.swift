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
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: MainControllerProtocol) {
        self.controller = controller
    }
    
    var notes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
}

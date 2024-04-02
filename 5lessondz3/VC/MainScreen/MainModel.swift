//
//  MainModel.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import Foundation

protocol MainModelProtocol {
    func getNotes()
    
    func searchNotes(text: String)
}

class MainModel: MainModelProtocol {
    var controller: MainControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: MainControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [Note] = []
    
    private var filteredNotes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        filteredNotes = notes
        controller?.onSuccessNotes(notes: filteredNotes)
    }
    
    func searchNotes(text: String) {
        filteredNotes = []
        
        if text.isEmpty {
            filteredNotes = notes
            controller?.onSuccessNotes(notes: filteredNotes)
        } else {
            filteredNotes = notes.filter({ note in
                note.title?.uppercased().contains(text.uppercased()) == true
            })
            controller?.onSuccessNotes(notes: filteredNotes)
        }
    }
}

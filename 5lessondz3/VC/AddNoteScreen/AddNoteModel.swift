//
//  AddNoteModel.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 27/3/24.
//

import Foundation

protocol AddNoteModelProtocol: AnyObject {
    func addNote(title: String, description: String)
    
    func deleteNote(id: String)
    
    func updateNote(id: String, title: String, description: String)
}

class AddNoteModel: AddNoteModelProtocol {
    weak var controller: AddNoteControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: AddNoteControllerProtocol) {
        self.controller = controller
    }
    
    func addNote(title: String, description: String) {
        let id = UUID().uuidString
        let date = Date()
        coreDataService.addNote(id: id, title: title, description: description, date: date)
    }
    
    func deleteNote(id: String) {
        coreDataService.deleteNote(id: id)
        controller?.onSuccessDelete()
    }
    
    func updateNote(id: String, title: String, description: String) {
        coreDataService.updateNote(id: id, title: title, description: description)
    }
}

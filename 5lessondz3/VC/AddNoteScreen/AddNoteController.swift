//
//  AddNoteController.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 27/3/24.
//

import Foundation

protocol AddNoteControllerProtocol: AnyObject {
    func onAddNote(title: String, description: String)
}

class AddNoteController: AddNoteControllerProtocol {
    weak var view: AddNoteViewProtocol?
    var model: AddNoteModelProtocol?
    
    init(view: AddNoteViewProtocol) {
        self.view = view
        self.model = AddNoteModel(controller: self)
    }
    
    func onAddNote(title: String, description: String) {
        model?.addNote(title: title, description: description)
    }
}

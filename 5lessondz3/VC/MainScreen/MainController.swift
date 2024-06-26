//
//  MainController.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import Foundation

protocol MainControllerProtocol {
    func onGetNotes()
    
    func onSuccessNotes(notes: [Note])
    
    func onSearchNotes(text: String)
}

class MainController: MainControllerProtocol {
    
    private var model: MainModelProtocol?
    private var view: MainViewProtocol?
    
    init(view: MainViewProtocol) {
        self.model = MainModel(controller: self)
        self.view = view
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccessNotes(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
    
    func onSearchNotes(text: String) {
        model?.searchNotes(text: text)
    }
}


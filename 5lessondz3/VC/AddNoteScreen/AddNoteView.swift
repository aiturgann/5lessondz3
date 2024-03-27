//
//  AddNoteView.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 27/3/24.
//

import UIKit

protocol AddNoteViewProtocol: AnyObject {
    
}

class AddNoteView: UIViewController {
    
    var controller: AddNoteControllerProtocol?
    
    private var note: Note?
        
    private lazy var titleTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(validateTF), for: .editingChanged)
        if let note = note {
            tf.text = note.title
        }
        return tf
    }()
    
    private lazy var descriptionTF:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Start typing"
        tf.layer.cornerRadius = 20
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.backgroundColor = .systemGray6
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(validateTF), for: .editingChanged)
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(saveButtonTppd), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = AddNoteController(view: self)
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavItem()
    }
    
    private func setupNavItem() {
        
        navigationItem.title = "Settings"
        
        let navItemSettingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsBtnTppd))
        navItemSettingsButton.tintColor = .black
        navigationItem.rightBarButtonItem = navItemSettingsButton
    }
    
    @objc private func settingsBtnTppd() {
        
    }
    
    @objc private func saveButtonTppd()  {
        if titleTF.text?.isEmpty != true, descriptionTF.text?.isEmpty != true {
            
            let alert = UIAlertController(title: "Succes", message: "Notes saved successfully", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive) { action in
                self.controller?.onAddNote(title: self.titleTF.text ?? "", description: self.descriptionTF.text ?? "")
                    self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @objc private func validateTF() {
        if titleTF.text?.isEmpty == true, descriptionTF.text?.isEmpty == true {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray5
        } else {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .red
        }
    }
    
    private func  setupUI() {
        view.addSubview(titleTF)
        NSLayoutConstraint.activate(
            [titleTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             titleTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             titleTF.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
             titleTF.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        view.addSubview(descriptionTF)
        NSLayoutConstraint.activate(
            [descriptionTF.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 26),
             descriptionTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             descriptionTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             descriptionTF.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate(
            [saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
             saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
             saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
             saveButton .heightAnchor.constraint(equalToConstant: 42)
            ])
        
    }
}

extension AddNoteView: AddNoteViewProtocol {
    
}


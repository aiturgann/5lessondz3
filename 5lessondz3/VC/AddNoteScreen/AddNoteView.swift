//
//  AddNoteView.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 27/3/24.
//

import UIKit

protocol AddNoteViewProtocol: AnyObject {
    func successDelete()
    
    func failureDelete()
}

class AddNoteView: UIViewController {
    
    var controller: AddNoteControllerProtocol?
    
    private var note: Note?
    
    private var isTitleEmpty: Bool = true
    
    private var isDescriptionEmpty: Bool = true
        
    private lazy var titleTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title".localized()
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 20
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        tf.leftView = leftView
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(validateTF), for: .editingChanged)
        if let note = note {
            tf.text = note.title
            isTitleEmpty = false
            isDescriptionEmpty = false
        }
        return tf
    }()
    
    private lazy var descriptionTV: UITextView = {
        let tf = UITextView()
        tf.layer.cornerRadius = 20
        tf.backgroundColor = .systemGray6
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        if let note = note {
            tf.text = note.desc
            isTitleEmpty = false
            isDescriptionEmpty = false
        }
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray5
        button.setTitle("Save".localized(), for: .normal)
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
    }
    
    private func localizeWords() {
        titleTF.placeholder = "Title".localized()
        saveButton.setTitle("Save".localized(), for: .normal)
    }
    
    func setNote(note: Note) {
        self.note = note
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        
        setupNavItem(isDarkTheme: isDarkTheme)
    }
    
    private func setupNavItem(isDarkTheme: Bool) {
        localizeWords()
        let navItemSettingsButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteBtnTppd))
        navItemSettingsButton.tintColor = .black
        if note != nil {
            navigationItem.rightBarButtonItem = navItemSettingsButton
        }
        if isDarkTheme == true {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.rightBarButtonItem?.tintColor = .white
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
    }
    
    @objc private func deleteBtnTppd() {
        guard let note = note else {
            return
        }
        
        let alert = UIAlertController(title: "Delete".localized(), message: "Are you sure you want to delete this note?".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Yes".localized(), style: .destructive) { action in
            
            self.controller?.onDeleteNote(id: note.id ?? "")
        }
        let declineAction = UIAlertAction(title: "No".localized(), style: .cancel)
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        present(alert, animated: true)
        
    }
    
    @objc private func saveButtonTppd()  {
        if let note = note {
            let alert = UIAlertController(title: "Succes".localized(), message: "Notes updated successfully".localized(), preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive) { action in
                self.controller?.onUpdateNote(id: note.id ?? "", title: self.titleTF.text ?? "", description: self.descriptionTV.text ?? "")
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "Succes".localized(), message: "Notes saved successfully".localized(), preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive) { action in
                self.controller?.onAddNote(title: self.titleTF.text ?? "", description: self.descriptionTV.text ?? "")
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @objc private func validateTF() {
        guard let text = titleTF.text else { return }
        if text.isEmpty {
            isTitleEmpty = true
        } else {
            isTitleEmpty = false
        }
        if let note = note {
            if text != note.title, isTitleEmpty == false, isDescriptionEmpty == false {
                saveButton.isEnabled = true
                saveButton.backgroundColor = UIColor(named: "red")
            } else {
                saveButton.isEnabled = false
                saveButton.backgroundColor = .systemGray5
            }
        }  else if isTitleEmpty == true || isDescriptionEmpty == true {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray5
        }else {
            if isTitleEmpty == true {
                saveButton.isEnabled = false
                saveButton.backgroundColor = .systemGray5
            } else if isTitleEmpty == false, isDescriptionEmpty == false {
                    saveButton.isEnabled = true
                    saveButton.backgroundColor = UIColor(named: "red")
                }
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
        
        view.addSubview(descriptionTV)
        NSLayoutConstraint.activate(
            [descriptionTV.topAnchor.constraint(equalTo: titleTF.bottomAnchor, constant: 26),
             descriptionTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
             descriptionTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
             descriptionTV.heightAnchor.constraint(equalToConstant: 300)
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
    func successDelete() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDelete() {
        ()
    }
}

extension AddNoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if text.isEmpty {
            isDescriptionEmpty = true
        } else {
            isDescriptionEmpty = false
        }
        if let note = note {
            if text != note.desc, isTitleEmpty == false, isDescriptionEmpty == false {
                saveButton.isEnabled = true
                saveButton.backgroundColor = UIColor(named: "red")
            } else {
                saveButton.isEnabled = false
                saveButton.backgroundColor = .systemGray5
            }
        }  else if isTitleEmpty == true || isDescriptionEmpty == true {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray5
        }else {
            if isTitleEmpty == true {
                saveButton.isEnabled = false
                saveButton.backgroundColor = .systemGray5
            } else if isTitleEmpty == false, isDescriptionEmpty == false {
                    saveButton.isEnabled = true
                    saveButton.backgroundColor = UIColor(named: "red")
                }
        }    }
}

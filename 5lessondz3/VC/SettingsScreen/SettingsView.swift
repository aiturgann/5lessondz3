//
//  SettingsView.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
}

class SettingsView: UIViewController {
    
    private var controller: SettingsControllerProtocol?
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(), style: .insetGrouped)
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var settings: [Settings] = [Settings(image: "globe",
                                                 title: "Language".localized(),
                                                 description: "Russian".localized(),
                                                 type: .withRightButton),
                                        Settings(image: "moon",
                                                 title: "Dark theme".localized(),
                                                 description: "",
                                                 type: .withSwitch),
                                        Settings(image: "trash",
                                                 title: "Clear data".localized(),
                                                 description: "",
                                                 type: .usual)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = SettingsController(settingsView: self)
        setupUI()
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
        
        navigationItem.title = "Settings".localized()
        
        let navItemSettingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsBtnTppd))
        navItemSettingsButton.tintColor = .black
        navigationItem.rightBarButtonItem = navItemSettingsButton
        
        if isDarkTheme == true {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.rightBarButtonItem?.tintColor = .white
        } else {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
    }
    
    private func localizeWords() {
        setupNavItem(isDarkTheme: Bool())
        settings = [Settings(image: "globe",
                             title: "Language".localized(),
                             description: "Russian".localized(),
                             type: .withRightButton),
                    Settings(image: "moon",
                             title: "Dark theme".localized(),
                             description: "",
                             type: .withSwitch),
                    Settings(image: "trash",
                             title: "Clear data".localized(),
                             description: "",
                             type: .usual)]
        tableView.reloadData()
    }
    
    private func setupUI() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30)
            ])
        
        
        tableView.register(SettingsCVCell.self, forCellReuseIdentifier: SettingsCVCell.reuseId)
        tableView.backgroundColor = .systemBackground
        
    }
    
    @objc private func settingsBtnTppd() {
        
    }
    
    deinit {
        print("SettingsView is out")
    }
    
}

extension SettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCVCell.reuseId, for: indexPath) as! SettingsCVCell
        cell.setData(settings: settings[indexPath.row])
        cell.delegate = self
        cell.backgroundColor = .systemGray6
        
        let isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
        
        if isDarkTheme == true {
            cell.leftImageView.tintColor = .white
            cell.titleLabel.textColor = .white
            cell.rightButton.setTitleColor(.white, for: .normal)
            cell.rightButton.tintColor = .white
        } else {
            cell.leftImageView.tintColor = .black
            cell.titleLabel.textColor = .black
            cell.rightButton.setTitleColor(.black, for: .normal)
            cell.rightButton.tintColor = .black
        }
    
        return cell
    }
    
    
    
    
}

extension SettingsView: SettingsViewProtocol {
    
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            
            let alert = UIAlertController(title: "Delete".localized(), message: "Are you sure you want to delete all notes?".localized(), preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Yes".localized(), style: .destructive) { action in
            
                self.controller?.onDeleteNotes()
            }
            let declineAction = UIAlertAction(title: "No".localized(), style: .cancel)
            
            alert.addAction(acceptAction)
            alert.addAction(declineAction)
            
            present(alert, animated: true)
        } else if indexPath.row == 0 {
            let vc = ChangeLanguageView()
            vc.delegate = self
            let multiplier = 0.33
            let customDetent = UISheetPresentationController.Detent.custom { context in
                vc.view.frame.height * multiplier
            }
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [customDetent, .medium()]
                sheet.prefersGrabberVisible = true
            }
            present(vc, animated: true)
        }
    }
}

extension SettingsView: SettingsCellDelegate {
    
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "isDarkTheme")
        if isOn == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        
    }
}

extension SettingsView: ChangeLanguageViewDelegate {
    func didLanguageChoose() {
        localizeWords()
    }
}


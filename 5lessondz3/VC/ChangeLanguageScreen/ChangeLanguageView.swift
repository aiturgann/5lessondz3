//
//  ChangeLanguageView.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 2/4/24.
//

import UIKit

protocol ChangeLanguageViewDelegate: AnyObject {
    func didLanguageChoose()
}

class ChangeLanguageView: UIViewController {
    
    weak var delegate: ChangeLanguageViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose language".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemGray6
        view.register(ChangeLanguageTVCell.self, forCellReuseIdentifier: ChangeLanguageTVCell.reuseId)
        return view
    }()
    
    private var languages: [Language] = [Language(image: .kg, 
                                                  title: "Кыргызча"),
                                         Language(image: .ru,
                                                  title: "Русский"),
                                         Language(image: .usa,
                                                  title: "English")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func localizeWords() {
        titleLabel.text = "Choose language".localized()
    }
    
    private func setupUI() {
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
             titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             titleLabel.heightAnchor.constraint(equalToConstant: 42)
            ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
             tableView.heightAnchor.constraint(equalToConstant: 150)
            ])
    }
}

extension ChangeLanguageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeLanguageTVCell.reuseId, for: indexPath) as! ChangeLanguageTVCell
        cell.setData(language: languages[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
}

extension ChangeLanguageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appLanguageManager = AppLanguageManager.shared
        switch indexPath.row {
        case 0:
            appLanguageManager.setAppLanguage(language: .kg)
            UserDefaults.standard.set("kg", forKey: "isLanguageChanged")
        case 1:
            appLanguageManager.setAppLanguage(language: .ru)
            UserDefaults.standard.set("ru", forKey: "isLanguageChanged")
        case 2:
            appLanguageManager.setAppLanguage(language: .en)
            UserDefaults.standard.set("en", forKey: "isLanguageChanged")
        default:
            ()
        }
        localizeWords()
        delegate?.didLanguageChoose()
    }
}

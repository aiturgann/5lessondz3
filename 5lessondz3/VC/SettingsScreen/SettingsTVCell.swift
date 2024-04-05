//
//  SettingsTVCell.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

enum SettingsType {
    case withRightButton
    case withSwitch
    case usual
}

struct Settings {
    var image: String
    var title: String
    var description: String
    var type: SettingsType
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitchOn(isOn: Bool)
}


class SettingsCVCell: UITableViewCell {
    
    static var reuseId = "settings_cell"
    
    weak var delegate: SettingsCellDelegate?
    
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        let isOn = UserDefaults.standard.bool(forKey: "isDarkTheme")
        switchView.isOn = isOn
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.addTarget(self, action: #selector(didSwitchOn), for: .valueChanged)
        return switchView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didSwitchOn() {
        delegate?.didSwitchOn(isOn: switchView.isOn)
    }
    
    func setData(settings: Settings) {
        leftImageView.image = UIImage(systemName: settings.image)
        titleLabel.text = settings.title
        
        if settings.type == .withRightButton {
            rightButton.setTitle(settings.description, for: .normal)
            rightButton.setTitleColor(.black, for: .normal)
            rightButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            rightButton.tintColor = .black
            rightButton.semanticContentAttribute = .forceRightToLeft
            switchView.isHidden = true
            rightButton.isHidden = false
        } else if settings.type == .withSwitch {
            rightButton.isHidden = true
            switchView.isHidden = false
        } else if settings.type == .usual {
            switchView.isHidden = true
            rightButton.isHidden = true
        }
    }
    
    private func setupUI() {
        addSubview(leftImageView)
        NSLayoutConstraint.activate(
            [leftImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
             leftImageView.heightAnchor.constraint(equalToConstant: 24),
             leftImageView.widthAnchor.constraint(equalToConstant: 24)
            ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.leftAnchor.constraint(equalTo: leftImageView.rightAnchor, constant: 15),
             titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        contentView.addSubview(rightButton)
        NSLayoutConstraint.activate(
            [rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
             rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
             rightButton.heightAnchor.constraint(equalToConstant: 40),
             rightButton.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        contentView.addSubview(switchView)
        NSLayoutConstraint.activate(
            [switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
             switchView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}


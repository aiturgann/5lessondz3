//
//  ChangeLanguageTVCell.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 2/4/24.
//

import UIKit

struct Language {
    var image: UIImage
    var title: String
}

class ChangeLanguageTVCell: UITableViewCell {
    
    static var reuseId = "language_cell"
    
    private let logoImage:  UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 32 / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(logoImage)
        NSLayoutConstraint.activate(
            [logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
             logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
             logoImage.heightAnchor.constraint(equalToConstant: 32),
             logoImage.widthAnchor.constraint(equalToConstant: 32)
            ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
             titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
             titleLabel.heightAnchor.constraint(equalToConstant: 22)
            ])
    }
    
    func setData(language: Language) {
        logoImage.image = language.image
        titleLabel.text = language.title
    }
    
}

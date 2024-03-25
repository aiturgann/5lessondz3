//
//  OnBoardingCVCell.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

class OnBoardingCVCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        
        contentView.addSubview(backView)
        NSLayoutConstraint.activate(
            [backView.topAnchor.constraint(equalTo: contentView.topAnchor),
             backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             backView.heightAnchor.constraint(equalToConstant: 280 ),
             backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        backView.addSubview(imageView)
        backView.addSubview(titleLabel)
        backView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate(
            [imageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
             imageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
             imageView.heightAnchor.constraint(equalToConstant: 140),
             imageView.widthAnchor.constraint(equalToConstant: 212),
              
             titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
             titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             titleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             titleLabel.heightAnchor.constraint(equalToConstant: 30),
             
             descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
             descriptionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
             descriptionLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
             descriptionLabel.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    
    func setData(model: Model) {
        imageView.image = model.image
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


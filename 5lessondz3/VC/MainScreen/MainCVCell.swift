//
//  MainCVCell.swift
//  5lessondz3
//
//  Created by Aiturgan Kurmanbekova on 26/3/24.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    static let reuseId = "cell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
             titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
             titleLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


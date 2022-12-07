//
//  MessangerTableViewCell.swift
//  Messanger
//
//  Created by Consultant on 12/5/22.
//

import Foundation
import UIKit

class MessangerTableViewCell: UITableViewCell {
    
    lazy var sender: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.text = "This is a test message \n\nI like turtles"
        label.layer.cornerRadius = 10
        label.textColor = .white
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.sender)
        
//        self.messageLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.messageLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.messageLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.messageLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true

        
        self.sender.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.sender.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.sender.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.sender.bottomAnchor.constraint(equalTo: self.messageLabel.topAnchor, constant: 0).isActive = true
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }
    
}

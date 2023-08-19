//
//  InfoTableViewCell.swift
//  TZ1221
//
//  Created by Stanislav on 18.08.2023.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    static let identifier = "infoCell"
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray6
        label.text = "Species:"
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray6
        label.text = "Type:"
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray6
        label.text = "Gender:"
        return label
    }()
    
    let speciesStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let typeStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let genderStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .darkGray
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension InfoTableViewCell {
    
    func setupConstraints() {
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        typeStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        genderStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(speciesLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(speciesStatusLabel)
        contentView.addSubview(typeStatusLabel)
        contentView.addSubview(genderStatusLabel)
        
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            
            speciesStatusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            speciesStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            typeStatusLabel.topAnchor.constraint(equalTo: speciesStatusLabel.bottomAnchor, constant: 16),
            typeStatusLabel.trailingAnchor.constraint(equalTo: speciesStatusLabel.trailingAnchor),
            
            genderStatusLabel.topAnchor.constraint(equalTo: typeStatusLabel.bottomAnchor, constant: 16),
            genderStatusLabel.trailingAnchor.constraint(equalTo: typeStatusLabel.trailingAnchor),
            
        ])
    }
    
    func setupStatusLabel(speciesStatus: String, typeStatus: String, genderStatus: String) {
        if typeStatus.isEmpty {
            speciesStatusLabel.text = speciesStatus
            typeStatusLabel.text = "None"
            genderStatusLabel.text = genderStatus
        } else {
            speciesStatusLabel.text = speciesStatus
            typeStatusLabel.text = typeStatus
            genderStatusLabel.text = genderStatus
        }
        
    }
}

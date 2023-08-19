//
//  CharacterCollectionViewCell.swift
//  TZ1221
//
//  Created by Stanislav on 17.08.2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "characterCollectionView"
    let networkService = NetworkService()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let characterProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        characterProfileImage.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(characterProfileImage)
        contentView.addSubview(characterNameLabel)
        
        
        NSLayoutConstraint.activate([
            characterProfileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterProfileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterProfileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            characterProfileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
            characterProfileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterProfileImage.bottomAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            
        ])
    }
    
    func setupTextAndImage(name: String, image: String) {
        characterNameLabel.text = name
        networkService.getData(url: image) { data in
            let correctImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.characterProfileImage.image = correctImage
            }
        }
    }
    
}

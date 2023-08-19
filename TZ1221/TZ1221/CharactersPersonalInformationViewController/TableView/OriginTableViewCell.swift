//
//  OriginTableViewCell.swift
//  TZ1221
//
//  Created by Stanislav on 18.08.2023.
//

import UIKit

class OriginTableViewCell: UITableViewCell {
    
    let networkService = NetworkService()
    
    let planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "Planet")
        imageView.contentMode = .center
        return imageView
    }()
    
    let planetNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var planetTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .green
        label.numberOfLines = 0
        return label
    }()
    
    static let identifier = "originCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .darkGray
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        planetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        planetTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(planetImageView)
        contentView.addSubview(planetNameLabel)
        contentView.addSubview(planetTypeLabel)
        
        NSLayoutConstraint.activate([
            planetImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            planetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            planetImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            planetImageView.widthAnchor.constraint(equalToConstant: 95),
            planetImageView.heightAnchor.constraint(equalToConstant: 64),
            
            planetNameLabel.topAnchor.constraint(equalTo: planetImageView.topAnchor, constant: 16),
            planetNameLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
            planetNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            planetTypeLabel.bottomAnchor.constraint(equalTo: planetImageView.bottomAnchor, constant: -12),
            planetTypeLabel.leadingAnchor.constraint(equalTo: planetNameLabel.leadingAnchor)
        ])
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension OriginTableViewCell {
    
    func setupTextForLabel(planetName: String, planetType: String) {
        print(planetType)
        if planetName == "unknown" {
            planetNameLabel.text = "None"
        } else {
            planetNameLabel.text = planetName
            networkService.getData(url: planetType) { data in
                guard let planetTypeModel = try? JSONDecoder().decode(PlanetDataModel.self, from: data) else { return }
                DispatchQueue.main.async {
                    self.planetTypeLabel.text = planetTypeModel.type
                }
            }
        }

    }
}


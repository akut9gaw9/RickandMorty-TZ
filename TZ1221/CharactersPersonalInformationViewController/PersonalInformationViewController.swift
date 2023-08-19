//
//  PersonalInformationViewController.swift
//  TZ1221
//
//  Created by Stanislav on 17.08.2023.
//

import UIKit

protocol PersonalInformationProtocol: AnyObject {
    func setupUIInformation(index: IndexPath)
}

class PersonalInformationViewController: UIViewController {
    
    let networkService = NetworkService()
    var characterPersonalInformation: PersonalInformationModel?
    let sections = ["Info", "Origin", "Episodes"]
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let characterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        tableView.register(OriginTableViewCell.self, forCellReuseIdentifier: OriginTableViewCell.identifier)
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.identifier)
        tableView.register(HeaderTableView.self, forHeaderFooterViewReuseIdentifier: HeaderTableView.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = .clear
    }
    
    func setupConstraints() {
        tableView.backgroundColor = .black
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(characterImageView)
        view.addSubview(characterNameLabel)
        view.addSubview(characterStatusLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 113),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -113),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 10),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            characterNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -500),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 10),
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterNameLabel.leadingAnchor),
            characterStatusLabel.trailingAnchor.constraint(equalTo: characterNameLabel.trailingAnchor),
            characterStatusLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -470),
            
            tableView.topAnchor.constraint(equalTo: characterStatusLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func setupCharacterPersonalInformation(data: PersonalInformationModel) {
        characterPersonalInformation = data
        
        setupSettingsForUIElements()
    }
    
    func setupSettingsForUIElements() {
        guard let imageLink = characterPersonalInformation?.characterURLImage else { return }
        guard let characterName = characterPersonalInformation?.characterName else { return }
        guard let characterStatus = characterPersonalInformation?.characteStatus else { return }
        
        networkService.getData(url: imageLink) { data in
            let correctImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.characterImageView.image = correctImage
            }
        }
        characterNameLabel.text = characterName
        settingCharacterStatusLabel(characterStatus: characterStatus)
        
    }
}



extension PersonalInformationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let episodesList = characterPersonalInformation?.characterEpisodes.characterEpisode.count else { return 1 }
        if section == 2 {
            return episodesList
        } else { return 1 }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let speciesStatus = characterPersonalInformation?.characterInfo.characterSpecies else { return UITableViewCell() }
            guard let typeStatus = characterPersonalInformation?.characterInfo.characterType else { return UITableViewCell() }
            guard let genderStatus = characterPersonalInformation?.characterInfo.characterGender else { return UITableViewCell() }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
            cell.setupStatusLabel(speciesStatus: speciesStatus,
                                  typeStatus: typeStatus,
                                  genderStatus: genderStatus)
            return cell
        } else if indexPath.section == 1 {
            guard let planetName = characterPersonalInformation?.characterOrigin.characterPlanet else { return UITableViewCell()}
            guard let planetType = characterPersonalInformation?.characterOrigin.characterPlanetURL else { return UITableViewCell()}
            let cell = tableView.dequeueReusableCell(withIdentifier: OriginTableViewCell.identifier, for: indexPath) as! OriginTableViewCell
            cell.setupTextForLabel(planetName: planetName, planetType: planetType)
            return cell
        } else {
            guard let episodes = characterPersonalInformation?.characterEpisodes.characterEpisode else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.identifier, for: indexPath) as! EpisodesTableViewCell
            cell.setuptextLabel(episodesURL: episodes[indexPath.row])
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableView.identifier) as! HeaderTableView
        if section == 0 {
            header.setupHeaderText(header: sections[section])
            return header
        } else if section == 1 {
            header.setupHeaderText(header: sections[section])
            return header
        } else {
            header.setupHeaderText(header: sections[section])
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension PersonalInformationViewController {
    func settingCharacterStatusLabel(characterStatus: String) {
        if characterStatus == "Alive" {
            characterStatusLabel.text = characterStatus
            characterStatusLabel.textColor = .green
        } else if characterStatus == "Dead" {
            characterStatusLabel.text = characterStatus
            characterStatusLabel.textColor = .red
        } else {
            characterStatusLabel.text = characterStatus
            characterStatusLabel.textColor = .lightGray
        }
    }
}

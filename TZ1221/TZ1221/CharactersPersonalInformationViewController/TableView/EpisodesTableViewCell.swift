//
//  EpisodesTableViewCell.swift
//  TZ1221
//
//  Created by Stanislav on 18.08.2023.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    let networkService = NetworkService()
    static let identifier = "episodeCell"
    
    let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seasonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15   )
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupConstraints() {
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        seasonLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(episodeNameLabel)
        addSubview(seasonLabel)
        addSubview(dateLabel)
        addSubview(backgroundCell)
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            
            episodeNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            episodeNameLabel.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 16),
            episodeNameLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -48),
            episodeNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
            
            
            seasonLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 8),
            seasonLabel.leadingAnchor.constraint(equalTo: episodeNameLabel.leadingAnchor),
            seasonLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -14),
            
            dateLabel.topAnchor.constraint(equalTo: seasonLabel.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: seasonLabel.bottomAnchor)
        ])
    }
    
    func setupViews() {
        selectionStyle = .none
        
        backgroundCell.addSubview(episodeNameLabel)
        backgroundCell.addSubview(seasonLabel)
        backgroundCell.addSubview(dateLabel)
    }

}

extension EpisodesTableViewCell {
    func setuptextLabel(episodesURL: String) {
        networkService.getData(url: episodesURL) { data in
            let dateEpisode = try? JSONDecoder().decode(EpisodeDataModel.self, from: data)
            guard let episodeName = dateEpisode?.name else { return }
            guard let episodeDate = dateEpisode?.air_date else { return }
            guard let episodeSeason = dateEpisode?.episode else { return }
            DispatchQueue.main.async {
                self.episodeNameLabel.text = episodeName
                self.dateLabel.text = episodeDate
            }
            self.convertEpisodeDate(episodeDate: episodeSeason)
        }
    }
    
    func convertEpisodeDate(episodeDate: String) {
        
        var splitEpisodeDate = episodeDate.split(separator: "E")
        let seasonDate = splitEpisodeDate[0]
        splitEpisodeDate.remove(at: 0)
        let splitSeasonDate = seasonDate.split(separator: "S")
        
        guard let intEpisodeDate = Int(splitEpisodeDate[0]) else { return }
        guard let intSeasonDate = Int(splitSeasonDate[0]) else { return }
        
        DispatchQueue.main.async {
            self.seasonLabel.text = "Episode: \(intEpisodeDate), Season: \(intSeasonDate)"
        }
        
        
    }
}


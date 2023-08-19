//
//  ViewController.swift
//  TZ1221
//
//  Created by Stanislav on 17.08.2023.
//

import UIKit

class CharactersViewController: UIViewController {
    
    private let networkService = NetworkService()
    private var charactersList = [CharacterCellModel]()
    private var collectionView: UICollectionView!
    
    private let charactersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Characters"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraints()
        setupCharactersList()
        collectionView.register(CharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupConstraints() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionLayout())
        collectionView.backgroundColor = .black
        
        charactersLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(charactersLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            collectionView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: 31),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    func setupCharactersList() {
        networkService.delegate = self
        networkService.getCharactersData()
    }
    
    func setupCollectionLayout() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 10.5, bottom: 8, trailing: 10.5)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)


        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
                
    }


}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        cell.setupTextAndImage(name: charactersList[indexPath.row].charactersName,
                               image: charactersList[indexPath.row].charactersURLImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PersonalInformationViewController()
        vc.setupCharacterPersonalInformation(data: PersonalInformationModel.personalInformationList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CharactersViewController: NetworkServiceProtocol {
    func getCharactersData(data: JSONDataModel) {
        
        let count = data.results.count
        for i in 0...count-1 {
            guard let name = data.results[i].name else { return }
            guard let image =  data.results[i].image else { return }
            charactersList.append(CharacterCellModel(charactersName: name, charactersURLImage: image))
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        PersonalInformationModel.setupDatainPersonalInformList()
    }
}


//
//  EpisodesViewController.swift
//  Rick_and_Morty
//
//  Created by Евгений on 13.12.2023.
//

import UIKit

class EpisodesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var resalt: Resalt?
    let whiteView = UIView()
    let logo = UIImageView()
    let textFild = UITextField()
    let button = UIButton()
    let filtersImage = UIImageView()
    var collactionVeiw: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        logo.frame = CGRect(x: 40, y: 10, width: 312, height: 150)
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named: "Logo")
        
        textFild.frame = CGRect(x: 20, y: 150, width: 350, height: 40)
        textFild.borderStyle = .roundedRect
        textFild.placeholder = "🔍 Name of episode (ex.S01E01)"
        
        button.frame = CGRect(x: 20, y: 210, width: 350, height: 40)
        button.backgroundColor = UIColor(named: "buttonBG")
        button.setTitleColor(UIColor(named: "fontColorBG"), for: .normal)
        button.setTitle("ADVANCED FILTERS", for: .normal)
        
        filtersImage.frame = CGRect(x: 45, y: 220, width: 20, height: 20)
        filtersImage.contentMode = .scaleAspectFit
        filtersImage.image = UIImage(named: "filter")
        
        whiteView.frame = CGRect(x: 0, y: 60, width: view.frame.width, height: 260)
        whiteView.backgroundColor = .white
        whiteView.addSubview(logo)
        whiteView.addSubview(textFild)
        whiteView.addSubview(button)
        whiteView.addSubview(filtersImage)
        
        setupCollectionView()
        view.addSubview(whiteView)
        episodeRickAndMorty()
        
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 350, height: 390)
        
        collactionVeiw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collactionVeiw?.contentInset = .init(top: logo.bounds.height, left: 0, bottom: 0, right: 0)
        collactionVeiw?.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "EpisodesCollectionViewCell")
        collactionVeiw?.dataSource = self
        collactionVeiw?.delegate = self
        collactionVeiw?.frame = CGRect(x: 20, y: whiteView.bounds.height-70, width: 350, height: view.bounds.height-whiteView.bounds.height)
        view.addSubview(collactionVeiw ?? UIView())
    }
    func episodeRickAndMorty() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let json = try? JSONDecoder().decode(Resalt.self, from: data) {
                DispatchQueue.main.async {
                    self.resalt = json
                    self.collactionVeiw?.reloadData()
                }
            }
        }
        task.resume()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resalt?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCollectionViewCell", for: indexPath) as? EpisodesCollectionViewCell,
              let episode = resalt?.results [indexPath.row]
        else {return UICollectionViewCell()}
        cell.configure(episode: episode)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let characterTableView = CharacterDetailsTableViewController()

        characterTableView.getCharacter(id: indexPath.row+1)
        navigationController?.pushViewController(characterTableView, animated: true)
    }

}

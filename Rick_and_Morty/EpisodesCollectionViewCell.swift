//
//  EpisodesCollectionViewCell.swift
//  Rick_and_Morty
//
//  Created by Евгений on 14.12.2023.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    var heart = false
    
    let myImageVeiw = UIImageView()
    let imageTV =  UIImageView()
    let imageHeart = UIImageView()
    let rickLabel = UILabel()
    let nameLabel = UILabel()
    let grayView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        myImageVeiw.image = UIImage(named: "Rick")
        myImageVeiw.contentMode = .scaleToFill
        myImageVeiw.clipsToBounds = true
        
        imageTV.image = UIImage(systemName: "play.display")
        imageTV.tintColor = .black
        
        imageHeart.image = UIImage(systemName: "heart")
        imageHeart.tintColor = .red
        imageHeart.isUserInteractionEnabled = true
        imageHeart.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(heartTapped)))
        
        rickLabel.text = "Rick Sanchez"
        rickLabel.font = .boldSystemFont(ofSize: 20)
        rickLabel.textAlignment = .center
        
        nameLabel.text = "Pilot"
        
        grayView.backgroundColor = .systemGray6
        
        contentView.addSubview(grayView)
        contentView.addSubview(rickLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(myImageVeiw)
        contentView.addSubview(imageTV)
        contentView.addSubview(imageHeart)
        contentView.clipsToBounds = true
        
        rickLabel.frame = CGRect(x: 5, y: 275, width: contentView.frame.size.width, height: 50)
        grayView.frame = CGRect(x: 0, y: contentView.frame.maxY-60, width: contentView.frame.size.width, height: 60)
        nameLabel.frame = CGRect(x: 50, y: 350, width: 300, height: 20)
        
        myImageVeiw.frame = CGRect(x: 0, y: 0,
                                   width: contentView.frame.size.width,
                                   height: contentView.frame.size.height-120)
        imageTV.frame = CGRect(x: 10, y: 345, width: 30, height: 30)
        imageHeart.frame = CGRect(x: grayView.frame.maxX-50, y: 345, width: 40, height: 30)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func heartTapped() {
        heart.toggle()
        if heart == true {
            imageHeart.image = UIImage(systemName: "heart.fill")
        }
        else {
            imageHeart.image = UIImage(systemName: "heart")
        }
    }
    func configure(episode: Episode, character: CharacterInfo, image: UIImage) {
        nameLabel.text = "\(episode.name)  |  \(episode.episode)"
        rickLabel.text = character.name
        myImageVeiw.image = image

    }
}

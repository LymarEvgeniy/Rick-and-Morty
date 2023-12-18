//
//  FavoritViewController.swift
//  Rick_and_Morty
//
//  Created by Евгений on 16.12.2023.
//

import UIKit

class FavoritsViewController: UIViewController {
    
    let rickLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        rickLabel.text = "Favourites episodes"
        rickLabel.font = .boldSystemFont(ofSize: 20)
        rickLabel.textAlignment = .center
        
        view.addSubview(rickLabel)
        
        rickLabel.frame = CGRect(x: 0, y: 64, width: view.frame.size.width, height: 50)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

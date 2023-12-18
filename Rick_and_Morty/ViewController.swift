//
//  ViewController.swift
//  Rick_and_Morty
//
//  Created by Евгений on 13.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let logo = UIImageView()
    let loadingComponent = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo.frame = CGRect(x: 40, y: 97, width: 312, height: 104)
        loadingComponent.frame = CGRect(x: 90, y: 341, width: 200, height: 200)
        logo.image = UIImage(named: "Logo")
        loadingComponent.image = UIImage(named: "Loading component")
        
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(loadingComponent)
        
        UIImageView.animate(withDuration: 4.0) {
            self.loadingComponent.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            let tabBarController = TabBarController()
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
}



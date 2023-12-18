//
//  ViewController.swift
//  Table
//
//  Created by Евгений on 15.12.2023.
//

import UIKit

class CharacterDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let caracterTable = UITableView()
    let imageRickOnTheCircle = UIImageView()
    let nameHero = UITextView()
    var character: CharacterInfo?
    var permission: Bool?
    let cameraButton = UIButton()
    let backButton = UIButton()
    let titleArray = ["Gender", "Status", "Specie", "Type", "Location"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logo-black"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        view.tintColor = .black
        view.backgroundColor = .white
        
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton

        imageRickOnTheCircle.image = UIImage(named: "RickInCyrcle")
        imageRickOnTheCircle.frame = CGRect(x: 122, y: 120, width: 150, height: 150)
        
        nameHero.text = "Rick Sanchez"
        nameHero.textAlignment = .center
        nameHero.font = .boldSystemFont(ofSize: 30)
        nameHero.frame = CGRect(x: 0, y: 290, width: view.frame.width , height: 45)
        
        cameraButton.frame = CGRect(x: 275, y: 180, width: 32, height: 32)
        cameraButton.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraButton.addTarget(self, action: #selector(loadPhoto), for: .touchUpInside)
        
        view.addSubview(cameraButton)
        view.addSubview(nameHero)
        view.addSubview(imageRickOnTheCircle)
        
        createTable()
    }
    
    func createTable() {
        caracterTable.frame = CGRect(x: 0, y: 370, width: 350, height: 412)
        caracterTable.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        caracterTable.delegate = self
        caracterTable.dataSource = self
        
        view.addSubview(caracterTable)
    }
    
    func getCharacter(id: Int) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            if let json = try? JSONDecoder().decode(CharacterInfo.self, from: data) {
                DispatchQueue.main.async {
                    self.character = json
                    self.nameHero.text = json.name
                    self.caracterTable.reloadData()
                }
            }
        }
        task.resume()
    }
    
    @objc func loadPhoto() {
        if permission == nil {
            let actionSheet = UIAlertController(title: "Загрузите изображение", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
                let alert = UIAlertController(title: "Разрешить доступ к камере?", message: "Это необходимо, чтобы сканировать штрихкоды, номер карты и использовать другие возможности", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Разрешить", style: .cancel))
                alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: { _ in
                    self.permission = false
                }))
                self.present(alert, animated: true)
            }))
            actionSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
                let alert = UIAlertController(title: "Разрешить доступ к «Фото»?", message: "Это необходимо для добавления ваших фотографий", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Разрешить", style: .cancel))
                alert.addAction(UIAlertAction(title: "Отменить", style: .default, handler: { _ in
                    self.permission = false
                }))
                self.present(alert, animated: true)
            }))
            actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            present(actionSheet, animated: true)
        }
        else if permission == false {
            guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
            UIApplication.shared.open(url)
        }
        else if permission == true {
            print("Разрешение Получено")
        }
    }
    
    @objc func backButtonTapped() {
       
        navigationController?.popViewController(animated: true)
    }
    func checkIndex(index: Int) -> String {
        guard let character = character else {return ""}
        switch index {
        case 0: return character.gender
        case 1: return character.status
        case 2: return character.species
        case 3: return character.type
        case 4: return character.location.name
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Information"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configure = cell.defaultContentConfiguration()
        configure.text = titleArray[indexPath.row]
        configure.secondaryText = checkIndex(index: indexPath.row)
        cell.contentConfiguration = configure
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}

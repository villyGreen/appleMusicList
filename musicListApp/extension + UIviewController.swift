//
//  extension + UIviewController.swift
//  musicListApp
//
//  Created by zz on 14.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import SDWebImage

extension UIViewController {
    func showAlert(title: String?, message : String?, actionOne: String?, actionTwo: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionAddButton = UIAlertAction(title: actionOne, style: .default)
        let cancelButton = UIAlertAction(title: actionTwo, style: .destructive, handler: nil)
        alert.addAction(actionAddButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func configureCell<T:CellConfiguring,U: Hashable>(collectionView : UICollectionView,cellType: T.Type,model: U,indexPath: IndexPath) -> T {
                    print("ds")
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
               fatalError("Unknown id cell")
           }
            print(model)
           cell.configure(value: model)
           return cell
       }
    
    func showSideAllert(nameOfCreator: String,nameOfSong: String,imageToAlbum: String,startAnimate: CGFloat, endAnimate: CGFloat, done : Bool, completion: @escaping (_ view: UIView) -> Void) {
        
        let imageLogo = UIImageView()
        let nameOfCreator = nameOfCreator
        let nameOfSong  = nameOfSong
        guard let url = URL(string: "\(imageToAlbum)") else { return }
        imageLogo.sd_setImage(with: url, completed: nil)
    
        let viewContent = UIView(frame: CGRect(x: 13, y: (self.view.bounds.height * 0.5), width: self.view.bounds.width - 26, height: self.view.bounds.height * 0.5 - 15))
        viewContent.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(startAnimate)
        UIView.animate(withDuration: 0.15) {
            viewContent.backgroundColor = UIColor.systemFill.withAlphaComponent(endAnimate)
        }
        viewContent.layer.cornerRadius = 15
        viewContent.clipsToBounds = true
        view.addSubview(viewContent)
        completion(viewContent)
        let  tableView = UITableView(frame: CGRect(x: 0, y: viewContent.bounds.height * 0.5, width: viewContent.bounds.width, height: viewContent.bounds.height * 0.5))
        tableView.backgroundColor = .systemFill
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "gg")
        tableView.delegate = self
        tableView.dataSource = self
        viewContent.addSubview(tableView)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.contentMode = .scaleAspectFill
        viewContent.addSubview(imageLogo)
        
        NSLayoutConstraint.activate([
            imageLogo.heightAnchor.constraint(equalToConstant: 70),
            imageLogo.widthAnchor.constraint(equalToConstant: 70),
            imageLogo.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 30),
            imageLogo.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 50),
            imageLogo.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -30)
        ])
        
    }
}


extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var actions = ["Удалить", "Добавить альбом", "Добавить трек"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gg", for: indexPath)
        cell.textLabel!.text = "\(actions[indexPath.row])"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = .black.withAlphaComponent(0.8)
        cell.selectionStyle = .none
        cell.backgroundColor = .systemFill
        return cell
    }
    
    
}

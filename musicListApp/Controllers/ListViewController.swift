//
//  ListViewController.swift
//  musicListApp
//
//  Created by zz on 21.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    let searchBarController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
        delegations()
    }
    
    
    private func setupVc() {
           
           view.backgroundColor = .white
           title = "List"
           searchBarController.searchBar.placeholder = "Поиск"
           searchBarController.obscuresBackgroundDuringPresentation = false
           definesPresentationContext = true
           navigationItem.hidesSearchBarWhenScrolling = false
           navigationItem.searchController = searchBarController
           
       }
    
    private func delegations() {
        searchBarController.searchBar.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


//  SearchViewController.swift
//  musicListApp
//
//  Created by zz on 21.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.

import UIKit

class SearchViewController: UIViewController {
    
    let searchBarController = UISearchController(searchResultsController: nil)
    var songs = Bundle.main.decode([Song].self, from: "songs.json")
    
    enum Section: Int, CaseIterable {
        case songs
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section,Song>?
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
        setupCollectionnView()
        reloadData(searchText: nil)
        setupDataSource()
    }
    
    private func setupVc() {
        view.backgroundColor = .white
        title = "Search"
        searchBarController.searchBar.placeholder = "Поиск"
        searchBarController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchBarController
        searchBarController.searchBar.delegate = self
    }
    
//    private func setupCompositionalLayout() -> UICollectionViewLayout {
//        print("In function ")
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) ->
//            NSCollectionLayoutSection? in
//            print("In block")
//            guard let section = Section(rawValue: sectionIndex)
//                else { fatalError("Unknown section")}
//            switch section {
//            case .songs:
//                print("in case songs")
//                return self.setupSongsSection()
//            }
//        }
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 20
//        layout.configuration = config
//        return layout
//    }
    
    private func setupCompositionalLayout() -> UICollectionViewCompositionalLayout {

           let layout = UICollectionViewCompositionalLayout(section: setupSongsSection())
           let config = UICollectionViewCompositionalLayoutConfiguration()
           config.interSectionSpacing = 20
           layout.configuration = config
           return layout
       }
    
    
    
    private func setupSongsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        group.interItemSpacing = .fixed(15)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 15,
                                                        leading: 15,
                                                        bottom: 15,
                                                        trailing: 15)
        return section
        
    }
    
    private func reloadData(searchText: String?) {
        let filtered = songs.filter { song -> Bool in
            song.contains(searchText: searchText)
        }
        var snapShot = NSDiffableDataSourceSnapshot<Section, Song>()
        snapShot.appendSections([.songs])
        snapShot.appendItems(filtered, toSection: .songs)
        dataSource?.apply(snapShot,animatingDifferences: true)
    }
    
    
    private func setupCollectionnView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: setupCompositionalLayout())
        collectionView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView!.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9764705882, blue: 1, alpha: 1)
        view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.register(SongCell.self, forCellWithReuseIdentifier:SongCell.reuseID)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Song>(collectionView: collectionView!, cellProvider: { (collectionView, indexPath, song) -> UICollectionViewCell? in
            print("sd")
           return self.configureCell(collectionView: collectionView,
            cellType: SongCell.self,
            model: song,
            indexPath: indexPath)
        })
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SearchViewController : UICollectionViewDelegate {
    
    
}

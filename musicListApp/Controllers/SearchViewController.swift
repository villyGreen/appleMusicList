//
//  SearchViewController.swift
//  musicListApp
//
//  Created by zz on 21.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SearchViewController: UIViewController {
    
    let searchBarController = UISearchController(searchResultsController: nil)
    var dataSource: UICollectionViewDiffableDataSource<Section,Song>?
    var collectionView: UICollectionView?
    var songs = [Song]()
    let ss = Song(image: "https://music-ark.ru/upload/iblock/23e/23e3f8f8cc9ffec33ed0dec4ecca85b2.jpg", nameOfSong: "gg", nameOfCreator: "wp", timeOfSong: "12", id: "1")

    enum Section: Int, CaseIterable {
        case songs
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs.append(ss)
        setupVc()
        setupCollectionnView()
        setupCompositionalLayout()
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
    
    @available(iOS 13.0, *)
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) ->
            NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex)
                else { fatalError("Unknown section")}
            switch section {
            case .songs:
                return self.setupSongsSection()
                
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    
    
    @available(iOS 13.0, *)
    private func setupSongsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 3)
        group.interItemSpacing = .fixed(15)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 15,
                                                        leading: 15,
                                                        bottom: 15,
                                                        trailing: 15)
        //        let header = createHeaderSection()
        //        section.boundarySupplementaryItems = [header]
        return section
        
    }
    
    @available(iOS 13.0, *)
    private func reloadData(searchText: String?) {
        let filtered = songs.filter { song -> Bool in
            song.contains(searchText: searchText)
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Song>()
        snapShot.appendSections([.songs])
        snapShot.appendItems(filtered, toSection: .songs)
        dataSource?.apply(snapShot,animatingDifferences: true)
    }
    
    
    @available(iOS 13.0, *)
    private func setupCollectionnView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: setupCompositionalLayout())
        collectionView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView!.backgroundColor = .white
        //          collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: SectionHeader.reuseId)
        collectionView?.delegate = self
        collectionView?.register(SongCell.self, forCellWithReuseIdentifier:SongCell.reuseID)
        view.addSubview(collectionView!)
        
    }
    
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Song>(collectionView: collectionView!, cellProvider: { (collectionView, indexPath, song) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError()
            }
            switch section {
            case .songs:
                return self.configureCell(collectionView: collectionView,
                                          cellType: SongCell.self,
                                          model: song,
                                          indexPath: indexPath)
            }
        })
        
//        dataSource?.supplementaryViewProvider = {
//            collectionView,kind,indexPath in
//
//            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
//                fatalError()
//            }
//            guard  let section = Section(rawValue: indexPath.section) else {
//                fatalError()
//            }
//
//            sectionHeader.configureHeader(text: section.description(usersCount: self.users.count),
//                                          font: .systemFont(ofSize: 28, weight: .light),
//                                          textColor: #colorLiteral(red: 0.04945700034, green: 0.04515571317, blue: 0.1189446865, alpha: 1), textAlpha: 0.85)
//            return sectionHeader
//        }
        
    }
    
}

@available(iOS 13.0, *)
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

@available(iOS 13.0, *)
extension SearchViewController : UICollectionViewDelegate {
    
    
}

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
    var songs = Bundle.main.decode([Song].self, from: "songs.json")
    var tableView: UITableView?
    enum Section: Int,CaseIterable {
        case albums
        func description() -> String {
            switch self {
            case .albums:
                return "Ваши альбомы"
            }
        }
    }
    var collectionView: UICollectionView?
    var dataSource:UICollectionViewDiffableDataSource<Section, Song>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVc()
        setupView()
        print(view.bounds.height)
        setupCollectionViewDataSource()
        reloadData()
    }
    private func setupVc() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Ваша Музыка"
    }

    @objc private func setupProfile () {
    }
    //MARK: - Setup Layout
    
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) ->
            NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex)
                else { fatalError("Unknown section")}
            switch section {
                
            case .albums:
                return self.setupAlbumLayout()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
        
    }
    
    private func setupView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.size.height + 50, width: view.bounds.width, height: view.bounds.height * 0.3 + 50),
                                          collectionViewLayout: setupCompositionalLayout())
        collectionView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView!.backgroundColor = .white
        view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.register(AlbumCell.self,
                                 forCellWithReuseIdentifier: AlbumCell.reuseID)
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: SectionHeader.reuseId)
        
        tableView = UITableView(frame: CGRect(x: 0, y: view.bounds.height * 0.3 + self.navigationController!.navigationBar.frame.size.height + 100, width: view.bounds.width, height: view.bounds.height - self.navigationController!.navigationBar.frame.size.height + 100 - (tabBarController?.tabBar.bounds.height)! - (view.bounds.height * 0.5)))
        tableView?.register(songCellTableViewWithLogo.self, forCellReuseIdentifier: songCellTableViewWithLogo.id)
        tableView?.separatorStyle = .none
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }
    
    
    private func setupAlbumLayout() -> NSCollectionLayoutSection {
        //itemSize -> item -> groupSize -> groups -> section
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count:  2)
        group.interItemSpacing = .fixed(15)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 20, leading: 16, bottom: 0, trailing: 16)
        let sectionHeader = createHeaderSection()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Song>(collectionView: collectionView!) { (collectionView, indexPath, albumChat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {fatalError("Unknown section")}
            switch section {
            case .albums:
                return self.configureCell(collectionView: collectionView, cellType: AlbumCell.self,
                                          model: albumChat,
                                          indexPath: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = {
            collectionView,kind,IndexPath in
            guard  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: IndexPath) as? SectionHeader else {
                fatalError()
            }
            guard  let section = Section(rawValue: IndexPath.section) else {
                fatalError()
            }
            sectionHeader.configureHeader(text: section.description(),
                                          font: UIFont(name: "Avenir", size: 20),
                                          textColor: #colorLiteral(red: 0.04945700034, green: 0.04515571317, blue: 0.1189446865, alpha: 1), textAlpha: 0.8)
            return sectionHeader
        }
    }
    
    //MARK: Create HeaderSection
    private func createHeaderSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(1))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Song>()
        snapShot.appendSections([.albums])
        snapShot.appendItems(songs, toSection: .albums)
        dataSource?.apply(snapShot,animatingDifferences: true)
    }
}

extension ListViewController:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard  let song = self.dataSource?.itemIdentifier(for: indexPath) as? Song else { return }
        guard  let albumVc =  AlbumViewController(song: song) else { return }
        self.present(albumVc, animated: true, completion: nil)
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: songCellTableViewWithLogo.id, for: indexPath) as! songCellTableViewWithLogo
        cell.numeration.text = "\(indexPath.row)"
        cell.nameOfSong.text = "test song"
        cell.timeOfSong.text = "3:21"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard  let playerVc = PlayerViewController(song: songs[indexPath.row]) else { return }
        self.present(playerVc, animated: true, completion: nil)
    }
}

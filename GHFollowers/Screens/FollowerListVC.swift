//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 30/06/21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section{ //enums são hashable por padrão, que é o que precisamos para o diffabledatasource
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    
    func configureViewController(){
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout()) //view.bounds preenche a view toda | flow layout é a estilização da collection view
        view.addSubview(collectionView)// primeiro inicializa(acima) depois utiliza senão ele vem vazio
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width //largura total da tela
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40) //altura + espaco da label
        
        
        
        return flowLayout
    }

    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok") //rawvalue valor do erro no enum
            }
    
        }
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(){
        var snapshop = NSDiffableDataSourceSnapshot<Section, Follower>() //snapshot dos dados antes e depois(faz parte do funcionamento do diffabledatasource)
        snapshop.appendSections([.main]) //so tem uma section, por isso o array so tem um elemento(main)
        snapshop.appendItems(followers)
        
        DispatchQueue.main.async {  self.dataSource.apply(snapshop, animatingDifferences: true) }
    }

}

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
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)) //view.bounds preenche a view toda | flow layout é a estilização da collection view
        view.addSubview(collectionView)// primeiro inicializa(acima) depois utiliza senão ele vem vazio
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    

    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in // o weak self nesse caso vai previnir memory leaks(no caso a referencia a self é weak)
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
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

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y //variação da altura no scroll
        let contentHeight   = scrollView.contentSize.height //altura do conteudo que ja esta na tela(no caso a altura de 100 followers que é o limite)
        let height          = scrollView.frame.size.height //altura da tela
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

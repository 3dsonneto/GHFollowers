//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Edson Pessoal on 30/06/21.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    
    enum Section{ //enums são hashable por padrão, que é o que precisamos para o diffabledatasource
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }
    
    init(username: String){
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    func configureViewController(){
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)) //view.bounds preenche a view toda | flow layout é a estilização da collection view
        view.addSubview(collectionView)// primeiro inicializa(acima) depois utiliza senão ele vem vazio
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController(){
        let searchController                    = UISearchController()
        searchController.searchResultsUpdater   = self //toda vez que o resultado de busca ele avisa
        searchController.searchBar.placeholder  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false //tira o tint da view embaixo de quando voce toca na barra de busca
        navigationItem.searchController         = searchController
    }

    func getFollowers(username: String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in // o weak self nesse caso vai previnir memory leaks(no caso a referencia a self é weak)
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok") //rawvalue valor do erro no enum
            }
            
            self.isLoadingMoreFollowers = false
    
        }
    }
    
    func updateUI(with followers: [Follower]){
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }
        self.updateData(on: self.followers)
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]){
        var snapshop = NSDiffableDataSourceSnapshot<Section, Follower>() //snapshot dos dados antes e depois(faz parte do funcionamento do diffabledatasource)
        snapshop.appendSections([.main]) //so tem uma section, por isso o array so tem um elemento(main)
        snapshop.appendItems(followers)
        
        DispatchQueue.main.async {  self.dataSource.apply(snapshop, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped(){
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func addUserToFavorites(user: User){
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }

}

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y //variação da altura no scroll
        let contentHeight   = scrollView.contentSize.height //altura do conteudo que ja esta na tela(no caso a altura de 100 followers que é o limite)
        let height          = scrollView.frame.size.height //altura da tela
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        
        let destVC          = UserInfoVC()
        destVC.username     = follower.login
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
            
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) } //$0 é o item que eu to(o filter percorre o array), aí checa o login minusculo e vê se contem o que tem no filtro e joga pro filteredFollowers que so tem as coias que contem o filtro
        updateData(on: filteredFollowers)
        
    }
    
}

extension FollowerListVC: UserInfoVCDelegate{
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
}

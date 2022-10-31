//
//  ViewController.swift
//  iOS-AppArchitecture
//
//  Created by Vasanthakumar Annadurai on 30/10/22.
//

import UIKit
import Swinject
import Combine

class UserListViewController: UIViewController {
    
    // MARK: - Properties.
    @IBOutlet weak var aiProgress: UIActivityIndicatorView!
    @IBOutlet weak var tvUser: UITableView!
    @IBOutlet weak var vError: ErrorView!
    
    fileprivate var viewModel: UserListViewModel!
    fileprivate var cancellables: Set<AnyCancellable> = []
    fileprivate var users: [UserUIModel] = []
    
    // MARK: - UIViewController Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDependencies()
        initializeViews()
        setUpViewModelBindings()
    }
    
    // MARK: - Private Methods.
    private func initializeDependencies(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let userListUIAssembly = UserListAssembly()
        let userListAssembler = Assembler([userListUIAssembly], parent: appDelegate.appAssembler)
        
        self.viewModel = userListAssembler.resolver.resolve(UserListViewModel.self)!
    }
    
    private func initializeViews(){
        self.title = "User List"
        
        initializeLoadingView()
        initializeTableView()
        initializeErrorView()
    }
    
    private func initializeLoadingView(){
        aiProgress.stopAnimating()
    }
    
    private func initializeTableView(){
        tvUser.register(UINib(nibName: UserTableViewCell.IDENTIFIER, bundle: nil), forCellReuseIdentifier: UserTableViewCell.IDENTIFIER)
        tvUser.estimatedRowHeight = 100
        tvUser.rowHeight = UITableView.automaticDimension
        tvUser.dataSource = self
    }
    
    private func initializeErrorView(){
        vError.icon = UIImage(named: "ic_error_outline")
        vError.title = "Unexpected Error"
        vError.message = "Something went wrong. Please try again later"
    }
}

// MARK: - ViewModel Bindings Extension
extension UserListViewController{
    
    fileprivate func setUpViewModelBindings(){
        viewModel.uiState.sink { uiState in
            self.renderUIState(uiState: uiState)
        }.store(in: &cancellables)
    }
    
    private func renderUIState(uiState: UserListUIState){
        switch(uiState){
        case .Loading:
            renderLoadingState()
        case .Data(users: let users):
            renderDataState(data: users)
        case .Error:
            renderErrorState()
        }
    }
    
    private func renderLoadingState(){
        aiProgress.startAnimating()
        
        tvUser.isHidden = true
        
        vError.isHidden = true
    }
    
    private func renderDataState(data: [UserUIModel]){
        aiProgress.stopAnimating()
        
        tvUser.isHidden = false
        self.users = data
        tvUser.reloadData()
        
        vError.isHidden = true
    }
    
    private func renderErrorState(){
        aiProgress.stopAnimating()
        
        tvUser.isHidden = true
        
        vError.isHidden = false
    }
}

// MARK: - UITableViewDataSource
extension UserListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let userCell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.IDENTIFIER,
            for: indexPath
        ) as! UserTableViewCell
        
        userCell.populateCell(user: user)
        
        return userCell
    }
    
    
    
}


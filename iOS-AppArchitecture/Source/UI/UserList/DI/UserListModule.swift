import Foundation
import CommonCore
import Swinject
import Network

struct UserListModule: Module{
    
    static func registerServices(container: Container) {
        registerUserListUIMapper(container)
        registerUserListViewModel(container)
    }
    
    // UserListUIMapper
    private static func registerUserListUIMapper(_ container: Container){
        container.register(UserListUIMapper.self){ _ in
            let userListUIMapper = UserListUIMapper()
            return userListUIMapper
        }
    }
    
    // UserListViewModel
    private static func registerUserListViewModel(_ container: Container){
        container.register(UserListViewModel.self){ r in
            let getUserListUseCase = r.resolve(GetUserListUseCase.self)!
            let userListUIMapper = r.resolve(UserListUIMapper.self)!
            
            let userListViewModel = UserListViewModel(
                getUserListUseCase: getUserListUseCase,
                userListUIMapper: userListUIMapper
            )
            return userListViewModel
        }
    }
    
}

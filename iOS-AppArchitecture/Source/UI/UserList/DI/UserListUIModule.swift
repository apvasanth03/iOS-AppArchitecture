import Foundation
import CommonCore
import Swinject
import Network

struct UserListUIModule: Module{
    
    static func registerServices(container: Container) {
        registerUserListUIMapper(container)
        registerUserListViewModel(container)
    }
    
    // UserListUIMapper
    private static func registerUserListUIMapper(_ container: Container){
        container.register(UserListUIMapper.self){ r in
            let globalQueue = r.resolve(DispatchQueue.self, name: DispatchQueueModule.GLOBAL_DISPATCH_QUEUE)!
            
            let userListUIMapper = UserListUIMapper(globalQueue: globalQueue)
            return userListUIMapper
        }
    }
    
    // UserListViewModel
    private static func registerUserListViewModel(_ container: Container){
        container.register(UserListViewModel.self){ r in
            let mainQueue = r.resolve(DispatchQueue.self, name: DispatchQueueModule.MAIN_DISPATCH_QUEUE)!
            let getUserListUseCase = r.resolve(GetUserListUseCase.self)!
            let userListUIMapper = r.resolve(UserListUIMapper.self)!
            
            let userListViewModel = UserListViewModel(
                mainQueue: mainQueue,
                getUserListUseCase: getUserListUseCase,
                userListUIMapper: userListUIMapper
            )
            return userListViewModel
        }
    }
    
}

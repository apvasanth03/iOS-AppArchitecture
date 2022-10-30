import Foundation
import CommonCore
import Swinject

struct DomainModule: Module{
    
    static func registerServices(container: Container) {
        registerGetUserListUseCase(container)
    }
    
    // GetUserListUseCase
    private static func registerGetUserListUseCase(_ container: Container){
        container.register(GetUserListUseCase.self){ r in
            let globalQueue = r.resolve(DispatchQueue.self, name: DispatchQueueModule.GLOBAL_DISPATCH_QUEUE)!
            let userRepository = r.resolve(UserRepository.self)!
            
            let getUserListUseCase = GetUserListUseCase(
                globalQueue: globalQueue,
                userRepository: userRepository
            )
            return getUserListUseCase
        }.inObjectScope(.container)
    }
}

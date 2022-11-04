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
            let userRepository = r.resolve(UserRepository.self)!
            
            let getUserListUseCase = GetUserListUseCase(
                userRepository: userRepository
            )
            return getUserListUseCase
        }
    }
}

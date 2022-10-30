import Foundation
import CommonCore
import Combine
import Network

class GetUserListUseCase: UseCase{
    
    // MARK: - Variable Declartion
    var globalQueue: DispatchQueue
    private let userRepository: UserRepository
    
    // MARK: - Initializer
    init(
        globalQueue: DispatchQueue,
        userRepository: UserRepository
    ){
        self.globalQueue = globalQueue
        self.userRepository = userRepository
    }
    
    // MARK: - UseCase Method
    func execute(input: Void) -> AnyPublisher<Result<UserListResponse, HttpError>, Never> {
        return executeUseCase{
            userRepository.getUsers()
        }
    }
    
    
}

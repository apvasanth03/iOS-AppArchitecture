import Foundation
import CommonCore
import HttpClient

struct GetUserListUseCase: UseCase{
    
    // MARK: - Nested Type
    struct Param{
        let page: Int
    }
    
    // MARK: - Variable Declaration
    private let userRepository: UserRepository
    
    // MARK: - Initialiser
    init(userRepository: UserRepository){
        self.userRepository = userRepository
    }
    
    // MARK: - UseCase Method
    func _execute(param input: Param) async throws -> UserListResponse {
        let output = try await userRepository.getUsers(page: input.page)
        
        return output
    }
}

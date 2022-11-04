import Foundation
import CommonCore
import Combine

struct UserListUIMapper: Mapper{
    
    // MARK: - Mapper Methods
    func _map(input: [User]) async -> [UserListUIModel] {
        let userUIModels = input.map { user in
            mapUser(user: user)
        }
        return userUIModels
    }
    
    // MARK: - Private Methods
    private func mapUser(user: User) -> UserListUIModel{
        let userUIModel = UserListUIModel(
            id: user.id,
            name: "\(user.firstName) \(user.lastName)",
            email: user.email,
            avatar: user.avatar
        )
        return userUIModel
    }
}

import Foundation
import CommonCore
import Combine

struct UserListUIMapper: Mappper{
    
    typealias Input = [User]
    typealias Output = [UserUIModel]
    
    let globalQueue: DispatchQueue
    
    init(globalQueue: DispatchQueue){
        self.globalQueue = globalQueue
    }
    
    func map(input: [User]) -> AnyPublisher<[UserUIModel], Never>{
        return executeMapInBackground {
            mapToUI(users: input)
        }
    }
    
    private func mapToUI(users: [User]) -> [UserUIModel]{
        let userUIModels = users.map { user in
            mapUser(user: user)
        }
        return userUIModels
    }
    
    private func mapUser(user: User) -> UserUIModel{
        let userUIModel = UserUIModel(
            id: user.id,
            name: "\(user.firstName) \(user.lastName)",
            email: user.email,
            avatar: user.avatar
        )
        return userUIModel
    }
}

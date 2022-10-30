import Foundation
import CommonCore
import Combine
import Network

class UserRepository: Repository{
    
    // MARK: - Variable Decleration
    private let localDataSource: UserLocalDataSource
    private let remoteDataSource: UserRemoteDataSource
    
    // MARK: - Initializer
    init(
        userLocalDataSource: UserLocalDataSource,
        userRemoteDataSource: UserRemoteDataSource
    ){
        self.localDataSource = userLocalDataSource
        self.remoteDataSource = userRemoteDataSource
    }
    
    // MARK: - Repository Methods
    func clearStore() -> AnyPublisher<Void, Never> {
        return localDataSource.clearStore()
    }
    
    // MARK: - Public APIs
    func getUsers() -> AnyPublisher<UserListResponse, HttpError>{
        return remoteDataSource.getUsers()
    }
}

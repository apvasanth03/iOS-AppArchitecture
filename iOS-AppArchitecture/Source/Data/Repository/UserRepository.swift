import Foundation
import CommonCore
import HttpClient

actor UserRepository: Repository{
    
    // MARK: - Variable Declaration
    private let localDataSource: UserLocalDataSource
    private let remoteDataSource: UserRemoteDataSource
    
    // MARK: - Initialiser
    init(
        userLocalDataSource: UserLocalDataSource,
        userRemoteDataSource: UserRemoteDataSource
    ){
        self.localDataSource = userLocalDataSource
        self.remoteDataSource = userRemoteDataSource
    }
    
    // MARK: - Repository Methods
    func clearStore() async {
        await localDataSource.clearStore()
    }
    
    // MARK: - Public APIs
    func getUsers(page: Int) async throws -> UserListResponse{
        let response = try await remoteDataSource.getUsers(page: page)
        return response
    }
}

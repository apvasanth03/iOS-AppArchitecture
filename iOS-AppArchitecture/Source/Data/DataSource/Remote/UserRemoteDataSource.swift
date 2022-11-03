import Foundation
import CommonCore
import HttpClient

actor UserRemoteDataSource: RemoteDataSource{
    
    // MARK: - Variable Declaration
    let httpClient: HttpClient
    
    // MARK: - Initialiser
    init(httpClient: HttpClient){
        self.httpClient = httpClient
    }
    
    // MARK: - Public APIs
    func getUsers(page: Int) async throws -> UserListResponse{
        let url = URL(string: "https://reqres.in/api/users?page=\(page)")!
        let request = URLRequest(url: url)
        
        let response: UserListResponse = try await httpClient.makeRequest(request: request)
        return response
    }
    
    
}

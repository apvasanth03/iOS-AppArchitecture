import Foundation
import CommonCore
import Network
import Combine

class UserRemoteDataSource: RemoteDataSource{
    
    // MARK: - Variable Decleration
    let httpClient: HttpClient
    
    // MARK: - Initializer
    init(httpClient: HttpClient){
        self.httpClient = httpClient
    }
    
    // MARK: - Public APIs
    func getUsers() -> AnyPublisher<UserListResponse, HttpError>{
        let url = URL(string: "https://reqres.in/api/users?page=1")!
        let urlRequest = URLRequest(url: url)
        
        return httpClient.makeRequestPublisher(request: urlRequest)
    }
    
    
}

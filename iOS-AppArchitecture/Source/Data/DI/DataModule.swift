import Foundation
import CommonCore
import Swinject
import Network

struct DataModule: Module{
    
    static func registerServices(container: Container) {
        registerUserLocalDataSource(container)
        registerUserRemoteDataSource(container)
        registerUserRepository(container)
    }
    
    // UserLocalDataSource
    private static func registerUserLocalDataSource(_ container: Container){
        container.register(UserLocalDataSource.self){ _ in
            let userLocalDataSource = UserLocalDataSource()
            return userLocalDataSource
        }.inObjectScope(.container)
    }
    
    // UserRemoteDataSource
    private static func registerUserRemoteDataSource(_ container: Container){
        container.register(UserRemoteDataSource.self){ r in
            let httpClient = r.resolve(HttpClient.self)!
            let userRemoteDataSource = UserRemoteDataSource(httpClient: httpClient)
            return userRemoteDataSource
        }.inObjectScope(.container)
    }
    
    // UserRepository
    private static func registerUserRepository(_ container: Container){
        container.register(UserRepository.self){ r in
            let userLocalDataSource = r.resolve(UserLocalDataSource.self)!
            let userRemoteDataSource = r.resolve(UserRemoteDataSource.self)!
            let userRepository = UserRepository(
                userLocalDataSource: userLocalDataSource,
                userRemoteDataSource: userRemoteDataSource
            )
            return userRepository
        }.inObjectScope(.container)
    }
}

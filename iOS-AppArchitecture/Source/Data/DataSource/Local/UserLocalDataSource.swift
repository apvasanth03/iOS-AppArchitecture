import Foundation
import CommonCore
import Combine

class UserLocalDataSource: LocalDataSource{
    
    // MARK: - Initializer
    init(){
        
    }
    
    // MARK: - LocalDataSource Methods
    func clearStore() -> AnyPublisher<Void, Never>{
        return Empty().eraseToAnyPublisher()
    }
}

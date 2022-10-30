import Foundation
import Combine

/// Repository - Base `Protocol` for all `Repositories`
public protocol Repository{
    
    func clearStore() -> AnyPublisher<Void, Never>
}

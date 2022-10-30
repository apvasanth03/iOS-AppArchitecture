import Foundation
import Combine

/// Mappper - Provides Base API for all our `Mapper`
public protocol Mappper{
    
    associatedtype Input
    associatedtype Output
    
    var globalQueue: DispatchQueue { get }
    
    func map(input: Input) -> AnyPublisher<Output, Never>
}

extension Mappper{
    
    public func executeMapInBackground(block: () -> Output) -> AnyPublisher<Output, Never>{
        return Just(block())
            .subscribe(on: globalQueue)
            .eraseToAnyPublisher()
    }
}

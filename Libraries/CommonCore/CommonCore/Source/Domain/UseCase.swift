import Foundation
import Combine

/// UseCase - Executes business logic asynchronously.
public protocol UseCase{
    
    associatedtype Input
    associatedtype Success
    associatedtype Failure: Error
    
    var globalQueue: DispatchQueue { get }
    
    /// Executes the use case asynchronously and returns a `Result`
    ///
    /// - Parameters:
    ///     - input - Input for the `UseCase`
    ///
    /// - Returns: The `Publisher`
    ///
    func execute(input: Input) -> AnyPublisher<Success, Failure>
    
}

extension UseCase{
    
    public func executeUseCaseInBackground(block: () -> AnyPublisher<Success, Failure>) -> AnyPublisher<Success, Failure>{
        return block()
            .subscribe(on: globalQueue)
            .eraseToAnyPublisher()
        
    }
    
}

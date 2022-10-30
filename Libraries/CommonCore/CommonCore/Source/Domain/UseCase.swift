import Foundation
import Combine

/// Executes business logic asynchronously.
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
    /// - Returns: The `Result`
    ///
    func execute(input: Input) -> AnyPublisher<Result<Success, Failure>, Never>
    
}

extension UseCase{
    
    public func executeUseCase(block: () -> AnyPublisher<Success, Failure>) -> AnyPublisher<Result<Success, Failure>, Never>{
        return block()
            .map { output in
                Result.success(output)
            }
            .catch({ error in
                Just(Result.failure(error))
            })
                .subscribe(on: globalQueue)
                .eraseToAnyPublisher()
                    
    }
    
}

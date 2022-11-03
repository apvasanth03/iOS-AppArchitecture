import Foundation

/// UseCase - Used to executes business logic asynchronously.
/// Use `struct` for `UseCase` implementation
public protocol UseCase{
    
    associatedtype PARAM
    associatedtype RESULT
    
    /// Execute - The use case asynchronously and returns a `Result`
    ///
    /// - Parameters:
    ///     - param - Parameter for the `UseCase`
    ///
    /// - Throws: `Error` on Failure
    ///
    /// - Returns: The `RESULT` on Success.
    ///
    func execute(param: PARAM) async throws -> RESULT
    
    /// Implement this method in our concrete `UseCase` Type.
    /// This Method shouldn't be called by the caller - Caller should only use `execute(param:)` version
    func _execute(param: PARAM) async throws -> RESULT
    
}

extension UseCase{
    
    /// Provides the default implementation for the `execute(param:)` - By providing Structured Concurrency.
    public func execute(param: PARAM) async throws -> RESULT{
        try Task.checkCancellation()
        
        async let result = _execute(param: param)
        return (try await result)
    }
}

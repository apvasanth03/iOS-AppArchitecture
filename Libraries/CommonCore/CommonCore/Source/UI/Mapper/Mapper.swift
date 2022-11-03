import Foundation
import Combine

/// Mapper - Provides common API for mapping only value to other.
/// Use `struct` for `Mapper` implementation
public protocol Mapper{
    
    associatedtype Input
    associatedtype Output
    
    /// Map - Convert Input to Output Asynchronously.
    ///
    /// - Parameters:
    ///     - input - Input for the `Mapper`
    ///
    /// - Returns: The `OUTPUT` after mapping.
    func map(input: Input) async -> Output
    
    /// Implement this method in our concrete `Mapper` Type.
    /// This Method shouldn't be called by the caller - Caller should only use `map(input:)` version
    func _map(input: Input) async -> Output
}

extension Mapper{
    
    /// Provides the default implementation for the `map(input:)` - By providing Structured Concurrency.
    public func map(input: Input) async -> Output{
        async let output = _map(input: input)
        return (await output)
    }
}

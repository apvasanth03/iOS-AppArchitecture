import Foundation

/// HttpClient - Used to make HTTPRequest and get HTTPResponse back.
public protocol HttpClient{
    
    /// Make a HTTPRequest to the give Request and send the Result Asynchronously
    ///
    /// - Parameters:
    ///     - request: The `URLRequest`
    ///
    /// - Throws: `HttpError` if request fails
    ///
    /// - Returns: The response.
    func makeRequest<T: Decodable>(request: URLRequest) async throws -> T
    
}

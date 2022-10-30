import Foundation
import Combine

/// HttpClient - Used to make HTTPRequest and get HTTPResponse back.
public protocol HttpClient{
    
    /// Make a HTTPRequest to the give Request and send the Result via completionHandler.
    ///
    /// - Parameters:
    ///     - request: The `URLRequest`
    ///     - completionHandler: The Callback to get the Result.
    func makeRequest<T: Decodable>(
        request: URLRequest,
        completionHandler: @escaping (Result<T, HttpError>) -> Void
    )
    
}

public extension HttpClient{
    
    /// Make a HTTPRequest to the give Request and Publishes the Result
    ///
    /// - Parameters:
    ///     - request: The `URLRequest`
    ///
    /// - Returns: The `Publisher` which emits the Result.
    func makeRequestPublisher<T: Decodable>(request: URLRequest) -> AnyPublisher<T, HttpError>{
        return Future(){ promise in
            makeRequest(request: request){ result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
}

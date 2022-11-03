import Foundation

/// Error returned by HttpClient
public enum HttpError: Error {
    
    /// Transport Errors - that is, errors getting your request to the server or getting the response back (like NetworkError etc)
    case transportError(errorDesription: String?, cause: Error)
    
    
    /// Server Errors - that is , errors from server - the HTTP status code in the response from the server.
    case serverError(statusCode: Int, body: Data?, errorDesription: String?, cause: Error)
}

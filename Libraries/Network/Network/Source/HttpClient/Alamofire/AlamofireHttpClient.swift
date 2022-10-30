import Foundation
import Alamofire
import Combine

/// AlamofireHttpClient - `HttpClient` implementation using `Alamofire`
class AlamofireHttpClient: HttpClient{
    
    let session: Session
    let decoder: JSONDecoder
    
    init(session: Session, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: HttpClient Methods
    func makeRequest<T>(request: URLRequest,  completionHandler: @escaping (Result<T, HttpError>) -> Void) where T : Decodable {
        session.request(request)
            .validate()
            .responseDecodable(of: T.self, decoder: decoder) { dataResponse in
                let updatedDataResponse = self.transformError(dataResponse: dataResponse)
                completionHandler(updatedDataResponse.result)
            }
    }
    
    // MARK: Helper Methods
    private func transformError<T: Decodable>(dataResponse: DataResponse<T, AFError>) -> DataResponse<T, HttpError>{
        return dataResponse.mapError { (error: AFError) -> HttpError in
            let httpError: HttpError
            if let httpResponse = dataResponse.response{
                httpError = HttpError.serverError(
                    statusCode: httpResponse.statusCode,
                    body: dataResponse.data,
                    errorDesription: error.errorDescription,
                    cause: error)
            }else{
                httpError = HttpError.transportError(
                    errorDesription: error.errorDescription,
                    cause: error
                )
            }
            
            return httpError
        }
    }
}

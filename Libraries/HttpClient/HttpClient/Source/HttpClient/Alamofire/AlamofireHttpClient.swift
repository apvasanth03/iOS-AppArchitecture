import Foundation
import Alamofire

/// AlamofireHttpClient - `HttpClient` implementation using `Alamofire`
class AlamofireHttpClient: HttpClient{
    
    let session: Session
    let decoder: JSONDecoder
    
    init(session: Session, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: HttpClient Methods    
    func makeRequest<T>(request: URLRequest) async throws -> T where T : Decodable {
        let dataTask = session.request(request)
            .validate()
            .serializingDecodable(
                T.self,
                automaticallyCancelling: true,
                decoder: decoder
            )
        let dataResponse = await dataTask.response
        let updatedDataResponse = transformError(dataResponse: dataResponse)
        return try updatedDataResponse.result.get()
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

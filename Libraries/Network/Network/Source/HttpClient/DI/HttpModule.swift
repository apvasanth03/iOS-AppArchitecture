import Foundation
import Swinject
import Alamofire
import CommonCore

struct HttpModule: Module{
    
    static func registerServices(container: Container) {
        registerJSONDecoder(container)
        registerSession(container)
        registerHttpClient(container)
    }
    
    // JSONDecoder
    private static func registerJSONDecoder(_ container: Container){
        container.register(JSONDecoder.self){ _ in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return jsonDecoder
        }.inObjectScope(.container)
    }
    
    // Session
    private static func registerSession(_ container: Container){
        container.register(Session.self){ _ in
            let configuration = URLSessionConfiguration.default
            configuration.urlCache = nil
            let session = Session(configuration: configuration)
            return session
        }.inObjectScope(.container)
    }
    
    // HttpClient
    private static func registerHttpClient(_ container: Container){
        container.register(HttpClient.self){ r in
            let session = r.resolve(Session.self)!
            let decoder = r.resolve(JSONDecoder.self)!
            let httpClient = AlamofireHttpClient(
                session: session,
                decoder:decoder
            )
            return httpClient
        }.inObjectScope(.container)
    }
}

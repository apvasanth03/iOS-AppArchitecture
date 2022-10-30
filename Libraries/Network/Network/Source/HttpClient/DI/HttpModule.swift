import Foundation
import Swinject
import Alamofire

struct HttpModule{
    
    let container: Container
    
    init(container: Container){
        self.container = container
    }
    
    func registerServices(){
        registerJSONDecoder()
        registerSession()
        registerHttpClient()
    }
    
    // JSONDecoder
    private func registerJSONDecoder(){
        container.register(JSONDecoder.self){ _ in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return jsonDecoder
        }.inObjectScope(.container)
    }
    
    // Session
    private func registerSession(){
        container.register(Session.self){ _ in
            let configuration = URLSessionConfiguration.default
            configuration.urlCache = nil
            let session = Session(configuration: configuration)
            return session
        }.inObjectScope(.container)
    }
    
    // HttpClient
    private func registerHttpClient(){
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

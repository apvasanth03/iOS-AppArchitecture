import Foundation
import Swinject
import Alamofire

/// A Assembly - registers all Network module dependencies.
public class HttpClientAssembly: Assembly{
    
    public init(){
        
    }
    
    public func assemble(container: Container) {
        HttpModule.registerServices(container: container)
    }
}

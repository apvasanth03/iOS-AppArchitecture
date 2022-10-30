import Foundation
import Swinject
import Alamofire

/// A Assembly - registers all Network module dependencies.
public class NetworkAssembly: Assembly{
    
    public init(){
        
    }
    
    public func assemble(container: Container) {
        HttpModule(container: container).registerServices()
    }
}

import Foundation
import Swinject

/// A Assembly - registers all CommonCore module dependencies.
public class CommonCoreAssembly: Assembly{
    
    public init(){
        
    }
    
    public func assemble(container: Container) {
        DispatchQueueModule.registerServices(container: container)
    }
}

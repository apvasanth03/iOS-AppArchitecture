import Foundation
import Swinject

public struct DispatchQueueModule: Module{
    
    public static let MAIN_DISPATCH_QUEUE = "MAIN_DISPATCH_QUEUE"
    public static let GLOBAL_DISPATCH_QUEUE = "GLOBAL_DISPATCH_QUEUE"
    
    public static func registerServices(container: Container) {
        registerMainDispatchQueue(container)
        registerGlobalDispatchQueue(container)
    }
    
    // DispatchQueue Main
    private static func registerMainDispatchQueue(_ container: Container){
        container.register(DispatchQueue.self, name: MAIN_DISPATCH_QUEUE){ _ in
            let mainDispatchQueue = DispatchQueue.main
            return mainDispatchQueue
        }.inObjectScope(.container)
    }
    
    // DispatchQueue Global
    private static func registerGlobalDispatchQueue(_ container: Container){
        container.register(DispatchQueue.self, name: GLOBAL_DISPATCH_QUEUE){ _ in
            let globalDispatchQueue = DispatchQueue.global(qos: .userInitiated)
            return globalDispatchQueue
        }.inObjectScope(.container)
    }
}

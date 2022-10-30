import Foundation
import Swinject

class AppAssembly: Assembly{
    
    func assemble(container: Container) {
        DataModule.registerServices(container: container)
    }
}

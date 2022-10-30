import Foundation
import Swinject

class UserListUIAssembly: Assembly{
    
    func assemble(container: Container) {
        UserListUIModule.registerServices(container: container)
    }
}

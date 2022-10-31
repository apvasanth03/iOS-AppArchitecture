import Foundation
import Swinject

class UserListAssembly: Assembly{
    
    func assemble(container: Container) {
        UserListModule.registerServices(container: container)
    }
}

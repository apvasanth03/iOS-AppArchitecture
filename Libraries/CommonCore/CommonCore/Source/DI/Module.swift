import Foundation
import Swinject

/// Module - Base Module for all DI Modules.
public protocol Module{
    
    static func registerServices(container: Container)
}

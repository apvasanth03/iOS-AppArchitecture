import Foundation

/// Repository - Base `Protocol` for all `Repositories`
/// Use `actor` for `Protocol` implementation
public protocol Repository{
    
    func clearStore() async
}

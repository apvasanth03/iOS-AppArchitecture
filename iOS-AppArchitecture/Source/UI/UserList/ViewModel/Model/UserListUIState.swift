import Foundation

enum UserListUIState{
    
    case Loading
    case Data(users: [UserListUIModel])
    case Error
    
}

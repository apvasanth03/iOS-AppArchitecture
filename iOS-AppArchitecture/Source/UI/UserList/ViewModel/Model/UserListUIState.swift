import Foundation

enum UserListUIState{
    
    case Loading
    case Data(users: [UserUIModel])
    case Error
    
}

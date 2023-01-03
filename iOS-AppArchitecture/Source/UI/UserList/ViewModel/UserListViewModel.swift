import Foundation
import CommonCore
import Combine
import HttpClient

class UserListViewModel: ViewModel<UserListUIState, UserListEvent, UserListSideEffect>{
    
    // MARK: - Properties
    private let getUserListUseCase: GetUserListUseCase
    private let userListUIMapper: UserListUIMapper
    
    private var uiData: [UserListUIModel]?{
        get{
            switch(_uiState.value){
            case .Data(users: let users):
                return users
            default:
                return nil
            }
        }
        set{
            if let newValue = newValue {
                _uiState.send(.Data(users: newValue))
            }
        }
    }
    
    // MARK: Initialisation
    nonisolated init(
        getUserListUseCase: GetUserListUseCase,
        userListUIMapper: UserListUIMapper
    ){
        self.getUserListUseCase = getUserListUseCase
        self.userListUIMapper = userListUIMapper
        
        super.init(initialState: .Loading)
    }
    
    // MARK: Load Initial Data
    func loadInitialData(){
        Task{
            do{
                _uiState.send(.Loading)
                let response = try await loadUsers()
                await loadUsersSuccess(response: response)
            }catch{
                loadUsersFailure(error: error)
            }
        }
    }
    
    private func loadUsers() async throws -> UserListResponse{
        let param = GetUserListUseCase.Param(page: 1)
        let response = try await getUserListUseCase.execute(param: param)
        
        return response
    }
    
    private func loadUsersSuccess(response: UserListResponse) async{
        let userUIModels = await userListUIMapper.map(input: response.data)
        _uiState.send(.Data(users: userUIModels))
    }
    
    private func loadUsersFailure(error: Error){
        _uiState.send(.Error)
    }
    
    // MARK: - Handle Event
    override func handleEvent(event: UserListEvent) {
        switch(event){
        case .itemClicked(index: let index):
            onItemClicked(index: index)
        }
    }
    
    private func onItemClicked(index: Int){
        if let users = uiData{
            let clickedUser = users[index]
            
            _sideEffect.send(.navigateToUserDetailScreen(user: clickedUser))
        }
    }
    
}

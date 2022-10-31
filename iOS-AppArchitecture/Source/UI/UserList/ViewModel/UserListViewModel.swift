import Foundation
import CommonCore
import Combine
import Network

class UserListViewModel: ViewModel{
    
    // MARK: - Properties
    var uiState: AnyPublisher<UserListUIState, Never>{
        get{
            return _uiState.eraseToAnyPublisher()
        }
    }
    var sideEffect: AnyPublisher<Void, Never>{
        get{
            return _sideEffect.eraseToAnyPublisher()
        }
    }
    
    private let _uiState: CurrentValueSubject<UserListUIState, Never> = CurrentValueSubject(.Loading)
    private let _sideEffect: PassthroughSubject<Void, Never> = PassthroughSubject()
    private let getUserListUseCase: GetUserListUseCase
    private let userListUIMapper: UserListUIMapper
    private let mainQueue: DispatchQueue
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Initialization
    init(
        mainQueue: DispatchQueue,
        getUserListUseCase: GetUserListUseCase,
        userListUIMapper: UserListUIMapper
    ){
        self.mainQueue = mainQueue
        self.getUserListUseCase = getUserListUseCase
        self.userListUIMapper = userListUIMapper
        
        loadUsers()
    }
    
    // MARK: LoadUsers
    private func loadUsers(){
        _uiState.send(.Loading)
        
        getUserListUseCase.execute(input: ())
            .flatMap { response in
                self.userListUIMapper.map(input: response.data)
                    .setFailureType(to: HttpError.self)
            }
            .receive(on: mainQueue)
            .sink { completion in
                switch(completion){
                case .failure(let error):
                    self.loadUsersFailure(error: error)
                default: break
                }
            } receiveValue: { userUIModels in
                self.loadUsersSuccess(userUIModels: userUIModels)
            }.store(in: &cancellables)
    }
    
    private func loadUsersSuccess(userUIModels:[UserUIModel]){
        _uiState.send(.Data(users: userUIModels))
    }
    
    private func loadUsersFailure(error: HttpError){
        _uiState.send(.Error)
    }
    
    // MARK: - Handle Event
    func handleEvent(event: Void) {
        
    }
    
}

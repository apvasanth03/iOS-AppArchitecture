import Foundation
import Combine

/// ViewModel - Provides Base implementation for the all our concrete ViewModel
/// ViewModel - Is the main actor.
///
/// STATE - UI state is what the app says the View should display.
/// EVENT - Actions from View to be handled by ViewModel
/// SIDE_EFFECT - one-off events like navigation etc that do not alter the state of the UI.
@MainActor
open class ViewModel<STATE, EVENT, SIDE_EFFECT> {
    
    // MARK: - Properties
    public var uiState: AnyPublisher<STATE, Never>{
        get{
            return _uiState.eraseToAnyPublisher()
        }
    }
    public var sideEffect: AnyPublisher<SIDE_EFFECT, Never>{
        get{
            return _sideEffect.eraseToAnyPublisher()
        }
    }
    
    /// These Properties shouldn't be called by the caller - It is only to be used by BaseType.
    public let _uiState: CurrentValueSubject<STATE, Never>
    public let _sideEffect: PassthroughSubject<SIDE_EFFECT, Never> = PassthroughSubject()
    
    // MARK: - Initialisation
    public nonisolated init(initialState: STATE){
        _uiState = CurrentValueSubject(initialState)
    }
    
    // MARK: - Handle Event
    open func handleEvent(event: EVENT) {
        fatalError("Method - handleEvent(event:) - Has to be implemented by the SubClass")
    }
}

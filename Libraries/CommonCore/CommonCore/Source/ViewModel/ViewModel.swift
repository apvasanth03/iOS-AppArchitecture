import Foundation
import Combine

/// ViewModel - Provides Base API for all our `ViewModel`
public protocol ViewModel{
    
    associatedtype State
    associatedtype Event
    associatedtype SideEffect
    
    var uiState: AnyPublisher<State, Never> { get }
    var sideEffect: AnyPublisher<SideEffect, Never> { get }
    
    func handleEvent(event: Event)
    
}

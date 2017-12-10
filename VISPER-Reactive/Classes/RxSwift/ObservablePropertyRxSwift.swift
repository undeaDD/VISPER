//
//  File.swift
//  VISPER-Reactive-RxSwift
//
//  Created by bartel on 10.12.17.
//
import Foundation
import RxSwift

public struct DisposableWrapper: SubscriptionReferenceType {
    let disposable: Disposable
    
    public typealias OnDisposeFunction = () -> Void
    public var disposeFunction : OnDisposeFunction?
    
    public func dispose() {
        if let onDisposed = self.disposeFunction {
            onDisposed()
        }
        disposable.dispose()
    }
}


public class ObservablePropertyRxSwift<PropertyType>: ObservablePropertyType {
    
    public typealias ValueType = PropertyType
    
    public typealias DisposableType = DisposableWrapper
    
    public typealias E = ValueType
    
    private let _subject: PublishSubject<ValueType>
    
    
    public typealias OnDisposeFunction = () -> Void
    
    
    private var _lock = NSRecursiveLock()
    
    // state
    private var _value: E
    
    
    /// Gets or sets current value of variable.
    ///
    /// Whenever a new value is set, all the observers are notified of the change.
    ///
    /// Even if the newly set value is same as the old value, observers are still notified for change.
    public var value: E {
        get {
            _lock.lock(); defer { _lock.unlock() }
            return _value
        }
        set(newValue) {
            _lock.lock()
            _value = newValue
            _lock.unlock()
            
            _subject.on(.next(newValue))
        }
    }
    
    /// Initializes variable with initial value.
    ///
    /// - parameter value: Initial variable value.
    public init(_ value: ValueType) {
        _value = value
        _subject = PublishSubject()
        _subject.on(.next(value))
    }
    
    public func subscribe(_ function: @escaping (PropertyType) -> Void) -> DisposableWrapper? {
        let disposable = self._subject.subscribe(onNext: function)
        return DisposableWrapper(disposable: disposable, disposeFunction: nil)
    }
    
    public func subscribe(_ function: @escaping (PropertyType) -> Void, onDisposed: @escaping OnDisposeFunction) -> DisposableWrapper? {
        let disposable = self._subject.subscribe(onNext: function)
        return DisposableWrapper(disposable: disposable, disposeFunction: onDisposed)
    }
    
    
    /// - returns: Canonical interface for push style sequence
    public func asObservable() -> Observable<E> {
        return _subject
    }
    
    deinit {
        _subject.on(.completed)
    }
}

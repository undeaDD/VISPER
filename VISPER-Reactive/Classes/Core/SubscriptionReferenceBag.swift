//
//  SubscriptionReferenceBag.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//
/*
 The MIT License (MIT)
 Copyright (c) 2016 ReSwift Contributors
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 A class to hold subscriptions to `SubscriptionReferenceType`.
 Very similar to `autoreleasepool` but specifically for disposable types.
 Disposes of all held subscriptions when deallocated or `dispose()` is called.
 */
public class SubscriptionReferenceBag {
    fileprivate var references: [SubscriptionReferenceType] = []

    /// Initialise an empty bag.
    public init() {
    }

    /// Initialise the bag with an array of subscription references.
    public init(_ references: SubscriptionReferenceType?...) {
        #if swift(>=4.1)
        self.references = references.compactMap({ $0 })
        #else
        self.references = references.flatMap({ $0 })
        #endif
    }

    deinit {
        dispose()
    }

    /// Add a new reference to the bag if the reference is not `nil`.
    public func addReference(reference: SubscriptionReferenceType?) {
        if let reference = reference {
            references.append(reference)
        }
    }

    /// Add a new reference to the bag if the reference is not `nil`.
    public static func += (lhs: SubscriptionReferenceBag, rhs: SubscriptionReferenceType?) {
        lhs.addReference(reference: rhs)
    }
}

extension SubscriptionReferenceBag: SubscriptionReferenceType {
    /// Dispose of all subscriptions in the bag.
    public func dispose() {
        references.forEach { $0.dispose() }
        references = []
    }
}

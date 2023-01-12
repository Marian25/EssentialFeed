//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 01.10.2022.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to appropiate threads, if needed.
    @discardableResult
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}

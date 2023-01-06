//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 06.01.2023.
//

import Foundation

public protocol FeedImageDataStore {
    typealias RetrievalResult = Swift.Result<Data?, Error>
    func retrieve(dataForURL url: URL, completion: @escaping (RetrievalResult) -> Void)
    
    typealias InsertionResult = Swift.Result<Void, Error>
    func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void)
}

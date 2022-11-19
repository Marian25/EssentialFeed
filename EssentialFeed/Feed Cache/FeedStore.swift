//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 22.10.2022.
//


public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    typealias RetrivalResult =  Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrivalResult) -> Void
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to appropiate threads, if needed.
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to appropiate threads, if needed.
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoked in any thread
    /// Clients are responsible to dispatch to appropiate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}

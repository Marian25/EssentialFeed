//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Marian Stanciulica on 09.01.2023.
//

import Foundation
import EssentialFeed

public class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private struct TaskWrapper: FeedImageDataLoaderTask {
        var wrapped: FeedImageDataLoaderTask?
        
        func cancel() {
            wrapped?.cancel()
        }
    }
    
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoaderCacheDecorator.Result) -> Void) -> FeedImageDataLoaderTask {
        var task = TaskWrapper()
        task.wrapped = decoratee.loadImageData(from: url) { [weak self] result in
            if let data = try? result.get() {
                self?.cache.save(data, for: url) { _ in }
            }
            
            completion(result)
        }
        return task
    }
}

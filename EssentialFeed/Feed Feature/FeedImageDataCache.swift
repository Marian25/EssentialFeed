//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 09.01.2023.
//

import Foundation

public protocol FeedImageDataCache {
    typealias SaveResult = Result<Void, Swift.Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void)
}

//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 09.01.2023.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}

//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 30.09.2022.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

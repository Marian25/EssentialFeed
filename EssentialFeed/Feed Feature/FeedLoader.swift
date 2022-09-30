//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 30.09.2022.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}

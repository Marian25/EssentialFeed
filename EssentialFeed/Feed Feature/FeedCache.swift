//
//  FeedCache.swift
//  
//
//  Created by Marian Stanciulica on 09.01.2023.
//

import Foundation

public protocol FeedCache {
    typealias SaveResult = Result<Void, Error>

    func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void)
}

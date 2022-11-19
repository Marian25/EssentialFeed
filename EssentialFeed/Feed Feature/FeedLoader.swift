//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 30.09.2022.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>

    func load(completion: @escaping (Result) -> Void)
}

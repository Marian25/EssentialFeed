//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 06.01.2023.
//

import Foundation

public protocol FeedImageDataStore {
    func retrieve(dataForURL url: URL) throws -> Data?
    func insert(_ data: Data, for url: URL) throws
}

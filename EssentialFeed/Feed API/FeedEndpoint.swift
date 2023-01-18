//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 18.01.2023.
//

import Foundation

public enum FeedEndpoint {
    case get

    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}

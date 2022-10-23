//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 23.10.2022.
//

import Foundation

struct RemoteFeedItem: Decodable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let image: URL
}

//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 30.09.2022.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}

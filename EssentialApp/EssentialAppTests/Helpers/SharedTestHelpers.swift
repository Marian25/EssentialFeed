//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Marian Stanciulica on 09.01.2023.
//

import Foundation
import EssentialFeed

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func uniqueData() -> Data {
    return UUID().uuidString.data(using: .utf8)!
}

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "any", location: "any", url: URL(string: "http://any-url.com")!)]
}

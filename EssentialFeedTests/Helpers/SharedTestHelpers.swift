//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Marian Stanciulica on 23.10.2022.
//

import Foundation
import EssentialFeed

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}


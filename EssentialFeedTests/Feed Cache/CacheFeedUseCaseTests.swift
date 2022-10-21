//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Marian Stanciulica on 21.10.2022.
//

import XCTest

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
}

class FeedStore {
    var deleteCachedfeedCallCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedfeedCallCount, 0)
    }

}

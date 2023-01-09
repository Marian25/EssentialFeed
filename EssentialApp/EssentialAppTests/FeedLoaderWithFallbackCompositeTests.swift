//
//  RemoteWithLocalFallbackFeedLoaderTests.swift
//  EssentialAppTests
//
//  Created by Marian Stanciulica on 06.01.2023.
//

import XCTest
import EssentialFeed
import EssentialApp

final class FeedLoaderWithFallbackCompositeTests: XCTestCase, FeedLoaderTestCase {

    func test_load_deliversPrimaryFeedOnPrimaryLoaderSuccess() {
        let primaryFeed = uniqueFeed()
        let fallbackFeed = uniqueFeed()
        let sut = makeSUT(primaryResult: .success(primaryFeed),
                          fallbackResult: .success(fallbackFeed))
        
        expect(sut, toCompleteWith: .success(primaryFeed))
    }
    
    func test_load_deliversFallbackFeedOnPrimaryLoaderFailure() {
        let fallbackFeed = uniqueFeed()
        let sut = makeSUT(primaryResult: .failure(anyNSError()),
                          fallbackResult: .success(fallbackFeed))
        
        expect(sut, toCompleteWith: .success(fallbackFeed))
    }
    
    func test_load_deliversErrorOnBothPrimaryAndFallbackLoaderFailure() {
        let sut = makeSUT(primaryResult: .failure(anyNSError()),
                          fallbackResult: .failure(anyNSError()))
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: FeedLoader.Result, fallbackResult: FeedLoader.Result, file: StaticString = #file, line: UInt = #line) -> FeedLoader {
        let remoteLoader = FeedLoaderStub(result: primaryResult)
        let localLoader = FeedLoaderStub(result: fallbackResult)
        let sut = FeedLoaderWithFallbackComposite(primary: remoteLoader, fallback: localLoader)
        trackForMemoryLeaks(remoteLoader, file: file, line: line)
        trackForMemoryLeaks(localLoader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

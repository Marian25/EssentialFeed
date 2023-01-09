//
//  FeedImageDataLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Marian Stanciulica on 09.01.2023.
//

import XCTest
import EssentialFeed
import EssentialApp

final class FeedImageDataLoaderCacheDecoratorTests: XCTestCase, FeedImageDataLoaderTestCase {
    
    func test_init_doesNotLoadImageData() {
        let (_, loader) = makeSUT()

        XCTAssertTrue(loader.loadedURLs.isEmpty, "Expected no loaded URLs")
    }
    
    func test_loadImageData_deliversDataOnLoaderSuccess() {
        let uniqueData = uniqueData()
        let (sut, loader) = makeSUT()
        
        expect(sut, toCompleteWith: .success(uniqueData), when: {
            loader.completeSuccessfully(with: uniqueData)
        })
    }
    
    func test_loadImageData_deliversErrorOnLoaderFailure() {
        let (sut, loader) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(anyNSError()), when: {
            loader.complete(with: anyNSError())
        })
    }
    
    func test_loadImageData_cancelsTaskOnLoaderTaskCancel() {
        let url = anyURL()
        let (sut, loader) = makeSUT()

        let task = sut.loadImageData(from: url) { _ in }
        task.cancel()
        
        XCTAssertEqual(loader.cancelledURLs, [url], "Expected to cancel URL")
    }
    
    func test_loadImageData_cachesLoadedDataOnLoaderSuccess() {
        let cache = CacheSpy()
        let url = anyURL()
        let uniqueData = uniqueData()
        let (sut, loader) = makeSUT(cache: cache)
        
        _ = sut.loadImageData(from: url) { _ in }
        loader.completeSuccessfully(with: uniqueData)
        
        XCTAssertEqual(cache.messages, [.save(data: uniqueData, for: url)], "Expected to cache loaded image data on success")
    }
    
    func test_loadImageData_doesNotCacheOnLoaderFailure() {
        let cache = CacheSpy()
        let (sut, loader) = makeSUT(cache: cache)
        
        _ = sut.loadImageData(from: anyURL()) { _ in }
        loader.complete(with: anyNSError())
        
        XCTAssertTrue(cache.messages.isEmpty, "Expected not to cache image data on load error")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(cache: CacheSpy = .init(), file: StaticString = #file, line: UInt = #line) -> (sut: FeedImageDataLoader, loader: FeedImageDataLoaderStub) {
        let loader = FeedImageDataLoaderStub()
        let sut = FeedImageDataLoaderCacheDecorator(decoratee: loader, cache: cache)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    private class CacheSpy: FeedImageDataCache {
        private(set) var messages = [Message]()
        
        enum Message: Equatable {
            case save(data: Data, for: URL)
        }
        
        func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void) {
            messages.append(.save(data: data, for: url))
            completion(.success(()))
        }
    }
    
}

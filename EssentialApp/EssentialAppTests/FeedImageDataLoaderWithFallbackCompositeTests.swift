//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Marian Stanciulica on 08.01.2023.
//

import XCTest
import EssentialFeed

final class FeedImageDataWithFallbackComposite: FeedImageDataLoader {
    private class TaskWrapper: FeedImageDataLoaderTask {
        var wrapped: FeedImageDataLoaderTask?
        
        func cancel() {
            wrapped?.cancel()
        }
    }
    
    private let primary: FeedImageDataLoader
    private let fallback: FeedImageDataLoader
    
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        let task = TaskWrapper()
        task.wrapped = primary.loadImageData(from: url) { result in
            switch result {
            case .success:
                completion(result)
                
            case .failure:
                task.wrapped = self.fallback.loadImageData(from: url, completion: completion)
            }
        }
        return task
    }
}

final class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {
    
    func test_loadImageData_deliversPrimaryImageOnPrimarySuccess() {
        let primaryData = uniqueData()
        let fallbackData = uniqueData()
        let (sut, _, _) = makeSUT(primaryResult: .success(primaryData), fallbackResult: .success(fallbackData))
        
        expect(sut, toCompleteWith: .success(primaryData))
    }
    
    func test_loadImageData_cancelsPrimaryLoaderTaskOnCancel() {
        let primaryData = uniqueData()
        let fallbackData = uniqueData()
        let url = anyURL()
        let (sut, primaryLoader, fallbackLoader) = makeSUT(primaryResult: .success(primaryData), fallbackResult: .success(fallbackData))
        
        let task = sut.loadImageData(from: url) { _ in }
        task.cancel()
        
        XCTAssertEqual(primaryLoader.cancelledURLs, [url], "Expected to load URL from primary loader")
        XCTAssertTrue(fallbackLoader.cancelledURLs.isEmpty, "Expected no cancelled URLs from fallback loader")
    }
    
    func test_loadImageData_deliversFallbackImageOnPrimaryFailure() {
        let fallbackData = uniqueData()
        let (sut, _, _) = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackData))
        
        expect(sut, toCompleteWith: .success(fallbackData))
    }
    
    func test_loadImageData_deliversErrorOnPrimaryAndFallbackFailure() {
        let (sut, _, _) = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .failure(anyNSError()))
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: FeedImageDataLoader.Result, fallbackResult: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) -> (sut: FeedImageDataLoader, primaryLoader: LoaderStub, fallbackLoader: LoaderStub) {
        let primaryLoader = LoaderStub(result: primaryResult)
        let fallbackLoader = LoaderStub(result: fallbackResult)
        let sut = FeedImageDataWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        trackForMemoryLeaks(primaryLoader, file: file, line: line)
        trackForMemoryLeaks(fallbackLoader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, primaryLoader, fallbackLoader)
    }
    
    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    private func expect(_ sut: FeedImageDataLoader, toCompleteWith expectedResult: FeedImageDataLoader.Result, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        _ = sut.loadImageData(from: anyURL()) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedData), .success(expectedData)):
                XCTAssertEqual(receivedData, expectedData, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }

    private func uniqueData() -> Data {
        return UUID().uuidString.data(using: .utf8)!
    }
    
    private class LoaderStub: FeedImageDataLoader {
        private(set) var cancelledURLs = [URL]()
        
        private struct Task: FeedImageDataLoaderTask {
            let callback: () -> Void
            
            func cancel() {
                callback()
            }
        }
        
        private let result: FeedImageDataLoader.Result
        
        init(result: FeedImageDataLoader.Result) {
            self.result = result
        }
        
        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
            completion(result)
            return Task { [weak self] in
                self?.cancelledURLs.append(url)
            }
        }
    }
    
}

//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 05.01.2023.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}

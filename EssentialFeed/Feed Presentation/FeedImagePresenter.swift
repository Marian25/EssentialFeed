//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by Marian Stanciulica on 05.01.2023.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(description: image.description, location: image.location)
    }
}

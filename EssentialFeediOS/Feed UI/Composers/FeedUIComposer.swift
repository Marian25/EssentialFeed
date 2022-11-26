//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Marian Stanciulica on 26.11.2022.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let feedPresenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: feedPresenter)
        let feedController = FeedViewController(refreshController: refreshController)
        feedPresenter.loadingView = refreshController
        feedPresenter.feedView = FeedViewAdapter(controlller: feedController, imageLoader: imageLoader)
        return feedController
    }
}

private final class FeedViewAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controlller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controlller
        self.imageLoader = imageLoader
    }
    
    func display(feed: [FeedImage]) {
        controller?.tableModel = feed.map { model in
            let feedImageViewModel = FeedImageViewModel(model: model, imageLoader: imageLoader, imageTransformer: UIImage.init)
            return FeedImageCellController(viewModel: feedImageViewModel)
        }
    }
}

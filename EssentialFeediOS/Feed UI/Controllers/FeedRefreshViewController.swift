//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Marian Stanciulica on 26.11.2022.
//

import UIKit
import EssentialFeed

final class FeedRefreshViewController: NSObject {
    private(set) lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()
    
    private let feedLoader: FeedLoader
    var onRefresh: (([FeedImage]) -> Void)?
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    @objc func refresh() {
        view.beginRefreshing()

        feedLoader.load() { [weak self] result in
            guard let self = self else { return }
            
            if let feed = try? result.get() {
                self.onRefresh?(feed)
            }
            
            self.view.endRefreshing()
        }
    }
}

//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Marian Stanciulica on 05.01.2023.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}

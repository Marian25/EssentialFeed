//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Marian Stanciulica on 26.11.2022.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}

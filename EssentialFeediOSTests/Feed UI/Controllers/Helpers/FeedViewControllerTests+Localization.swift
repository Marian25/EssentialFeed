//
//  FeedViewControllerTests+Localization.swift
//  EssentialFeediOSTests
//
//  Created by Marian Stanciulica on 26.11.2022.
//

import XCTest
import EssentialFeediOS

extension FeedViewControllerTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedViewController.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: "Feed")
        
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        
        return value
    }
}

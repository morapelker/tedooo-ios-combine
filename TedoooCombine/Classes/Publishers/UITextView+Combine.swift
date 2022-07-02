//
//  UITextView+Combine.swift
//  TedoooCombine
//
//  Created by Mor on 02/07/2022.
//

import Foundation
import UIKit
import Combine

extension UITextView {
    
    public var textPublisher: AnyPublisher<String?, Never> {
        return NotificationCenter.default.publisher(
            for: UITextView.textDidChangeNotification,
            object: self
        ).map { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }
    
}

//
//  UITextField+Combine.swift
//  TedoooCombine
//
//  Created by Mor on 02/07/2022.
//

import Foundation
import UIKit
import Combine

extension UITextField {
    
    public var textPublisher: AnyPublisher<String?, Never> {
        return NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        ).map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
    
}

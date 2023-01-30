//
//  UIViewExtensions.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 30.01.2023.
//

import UIKit

extension UIView {
    func zoomIn(duration: TimeInterval = 0.12) {
        self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        UIView.animate(withDuration: duration,
                       delay: 0.08,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) { [weak self] in
            self?.transform = .identity
        }
    }
}

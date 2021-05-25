//
//  UIImage+Resize.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.05.2021.
//

import UIKit

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

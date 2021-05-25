//
//  Collection+SafeAccess.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.05.2021.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

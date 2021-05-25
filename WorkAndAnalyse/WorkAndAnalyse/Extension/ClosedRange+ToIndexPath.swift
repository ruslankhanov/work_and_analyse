//
//  ClosedRange+ToIndexPath.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.05.2021.
//

import Foundation

extension ClosedRange where Self.Bound == Int {
    func getIndexPaths(in section: Int) -> [IndexPath] {
        return self.map { IndexPath(row: $0, section: section) }
    }
}

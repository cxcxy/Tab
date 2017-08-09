//
//  ReusableKit.swift
//  Tab
//
//  Created by 陈旭 on 2017/7/28.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

public protocol CellType: class {
    var reuseIdentifier: String? { get }
}

/// A generic class that represents reusable cells.
public struct ReusableCell<Cell: CellType> {
    public typealias Class = Cell
    
    public let identifier: String
    public let nib: UINib?
    
    /// Create and returns a new `ReusableCell` instance.
    ///
    /// - parameter identifier: A reuse identifier. Use random UUID string if identifier is not provided.
    /// - parameter nib: A `UINib` instance. Use this when registering from xib.
    public init(identifier: String? = nil, nib: UINib? = nil) {
        self.identifier = nib?.instantiate(withOwner: nil, options: nil).lazy
            .flatMap { ($0 as? CellType)?.reuseIdentifier }
            .first ?? identifier ?? UUID().uuidString
        self.nib = nib
    }
    
    /// A convenience initializer.
    ///
    /// - parameter identifier: A reuse identifier. Use random UUID string if identifier is not provided.
    /// - parameter nibName: A name of nib.
    public init(identifier: String? = nil, nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.init(identifier: identifier, nib: nib)
    }
}

extension UITableViewCell: CellType {
}



extension UITableView {
    
    // MARK: Cell
    
    /// Registers a generic cell for use in creating new table cells.
    public func register<Cell: CellType>(_ cell: ReusableCell<Cell>) {
        if let nib = cell.nib {
            self.register(nib, forCellReuseIdentifier: cell.identifier)
        } else {
            self.register(Cell.self, forCellReuseIdentifier: cell.identifier)
        }
    }
    
    /// Returns a generic reusable cell located by its identifier.
    public func dequeue<Cell: CellType>(_ cell: ReusableCell<Cell>) -> Cell? {
        return self.dequeueReusableCell(withIdentifier: cell.identifier) as? Cell
    }
    
    /// Returns a generic reusable cell located by its identifier.
    public func dequeue<Cell: CellType>(_ cell: ReusableCell<Cell>, for indexPath: IndexPath) -> Cell {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! Cell
    }
    
    // MARK: View
    
//    /// Registers a generic view for use in creating new table header or footer views.
//    public func register<View: ViewType>(_ cell: ReusableView<View>) {
//        if let nib = cell.nib {
//            self.register(nib, forHeaderFooterViewReuseIdentifier: cell.identifier)
//        } else {
//            self.register(View.self, forHeaderFooterViewReuseIdentifier: cell.identifier)
//        }
//    }
//    
//    /// Returns a generic reusable header of footer view located by its identifier.
//    public func dequeue<View: ViewType>(_ view: ReusableView<View>) -> View? {
//        return self.dequeueReusableHeaderFooterView(withIdentifier: view.identifier) as? View
//    }
    
}

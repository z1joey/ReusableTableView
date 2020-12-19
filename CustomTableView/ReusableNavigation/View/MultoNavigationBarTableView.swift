//
//  MultoNavigationBarTableView.swift
//  Multo
//
//  Created by joey on 12/19/20.
//  Copyright © 2020 tecpal. All rights reserved.
//

import UIKit

public class MultoNavigationBarTableView: UITableView {
    public var header: UIView?

    public var status: MultoNavBarStatus = .regular {
        didSet {
            switch status {
            case .searching:
                isScrollEnabled = true
                allowsSelection = true
            default:
                isScrollEnabled = false
                allowsSelection = false
            }

            reloadData()
        }
    }

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        dataSource = self
        delegate = self

        register(UINib(nibName: "NavBarSortCell", bundle: nil), forCellReuseIdentifier: "Sort")
        register(UINib(nibName: "NavBarSearchCell", bundle: nil), forCellReuseIdentifier: "Search")
    }
}

extension MultoNavigationBarTableView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return header == nil ? 0 : 91
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status.cellNumber
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return status.cellHeight
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: status.cellIdentifier, for: indexPath)

        return cell
    }
}

public enum MultoRecipeSort: String {
    case lastUpdated
    case popularity
}

public enum MultoNavBarStatus {
    case regular
    case sorting
    case searching(parentViewHeight: CGFloat)

    var navBarHeight: CGFloat {
        switch self {
        case .regular: return 91
        case .sorting: return 91 + 94
        case .searching(let parentViewHeight): return parentViewHeight
        }
    }

    var cellNumber: Int {
        switch self {
        case .regular: return 0
        case .sorting: return 1
        case .searching: return 0
        }
    }

    var cellHeight: CGFloat {
        switch self {
        case .regular: return 0
        case .sorting: return 94
        case .searching: return 50
        }
    }

    var cellIdentifier: String {
        switch self {
        case .regular: return "Regular"
        case .sorting: return "Sort"
        case .searching: return "Search"
        }
    }
}

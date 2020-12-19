//
//  ReusableTableView.swift
//  CustomTableView
//
//  Created by joey on 12/19/20.
//

import UIKit

public protocol ReusableTableViewSectionHeaderDelegate: class {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
}

public class ReusableTableView: UITableView {
    private var data: [String] = ["test", "test", "test", "123"]

    weak var headerDelegate: ReusableTableViewSectionHeaderDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }

    private func commonInit() {
        register(UINib(nibName: "NibCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dataSource = self
        delegate = self
    }

    public func append(_ newElement: String?) {
        guard newElement != nil else { return }
        data.append(newElement!)
        reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    public func remove(at index: Int) {
        guard data.indices.contains(index) else { return }
        data.remove(at: index)
        reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    public func set(data: [String]) {
        self.data = data
        reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

private let cellIdentifier = "Cell"

extension ReusableTableView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard headerDelegate != nil else { return 0 }
        return headerDelegate!.tableView(tableView, heightForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard headerDelegate != nil else { return nil }
        return headerDelegate?.tableView(tableView, viewForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if let cell = cell as? NibCell {
            cell.nameLabel.text = data[indexPath.row]
        }

        return cell
    }
}

//
//  NavBarCell.swift
//  Multo
//
//  Created by joey on 12/19/20.
//  Copyright © 2020 tecpal. All rights reserved.
//

import UIKit

public class MultoNavBarHeader: UITableViewHeaderFooterView, NibLoadable, MultoNavBarHeaderProtocol {
    public var delegate: MultoNavBarHeaderDelegate?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        loadFromNib(owner: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func profileButtonAction(_ sender: UIButton) {
        delegate?.profileButtonAction(sender: sender)
    }

    @IBAction func filterButtonAction(_ sender: UIButton) {
        delegate?.filterButtonAction(sender: sender)
    }

    @IBAction func sortButtonAction(_ sender: UIButton) {
        delegate?.sortButtonAction(sender: sender)
    }
}

public protocol MultoNavBarHeaderDelegate: class {
    func profileButtonAction(sender: UIButton)
    func filterButtonAction(sender: UIButton)
    func sortButtonAction(sender: UIButton)
}

public protocol MultoNavBarHeaderProtocol {
    var delegate: MultoNavBarHeaderDelegate? { get set }
}

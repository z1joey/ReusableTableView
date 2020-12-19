//
//  MultoNavigationViewController.swift
//  Multo
//
//  Created by joey on 12/19/20.
//  Copyright © 2020 tecpal. All rights reserved.
//

import UIKit

public class MultoNavigationViewController: UIViewController {
    @IBOutlet weak private var navBarTableView: MultoNavigationBarTableView!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet private weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bgImageView: UIImageView!

    private var bgImageViewMask: UIView?

    public var header: MultoNavBarHeaderProtocol?

    public var rootViewController: UIViewController? {
        willSet {
            guard rootViewController != nil else {
                fatalError("Must set rootViewController")
            }
        }
    }

    private var status: MultoNavBarStatus = .regular {
        didSet {
            navBarTableView.status = status
            animateNavBar(status)
        }
    }

    init(root: UIViewController?) {
        guard root != nil else {
            fatalError("Must set rootViewController")
        }

        super.init(nibName: "MultoNavigationViewController", bundle: nil)
        rootViewController = root
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setChild(rootViewController, containerView: containerView)
        bgImageViewMask = UIView(frame: navBarTableView.bounds)
        bgImageViewMask?.backgroundColor = .black
        //bgImageViewMask?.layer.sketchShadow(alpha: 0.3, x: 0, y: 3, blur: 4)
        bgImageView.mask = bgImageViewMask

        header?.delegate = self
        navBarTableView.header = header as? UIView
        navBarTableView.backgroundColor = .clear
    }

    private func animateNavBar(_ status: MultoNavBarStatus, duration: Double = 0.8, completion: (() -> Void)? = nil) {
        navBarHeightConstraint.constant = status.navBarHeight

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            switch status {
            case .regular:
                self.bgImageViewMask?.layer.cornerRadius = 0
                self.containerView.layer.cornerRadius = 0
            default:
                self.bgImageViewMask?.layer.cornerRadius = 10
                self.containerView.layer.cornerRadius = 10
            }

            self.bgImageViewMask?.frame.size.height = status.navBarHeight
            self.view.layoutIfNeeded()
        }, completion: { completed in
            guard completed else { return }
            completion?()
        })
    }

    private func setChild(_ child: UIViewController?, containerView: UIView? = nil) {
        guard child != nil else { return }
        guard !children.contains(child!) else { return }

        self.addChild(child!)

        let container: UIView = (containerView != nil) ? containerView! : self.view
        child!.view.frame = container.bounds
        container.addSubview(child!.view)
        child!.didMove(toParent: self)
    }
}

extension MultoNavigationViewController: MultoNavBarHeaderDelegate {
    public func profileButtonAction(sender: UIButton) {
        print("profile")
    }

    public func filterButtonAction(sender: UIButton) {
        print("filter")
    }

    public func sortButtonAction(sender: UIButton) {
        switch status {
        case .sorting:
            status = .regular
        default:
            status = .sorting
        }
        view.endEditing(true)
    }
}

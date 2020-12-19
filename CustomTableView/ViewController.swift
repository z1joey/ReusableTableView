//
//  ViewController.swift
//  CustomTableView
//
//  Created by joey on 12/19/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: ReusableTableView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.headerDelegate = self
    }

    @IBAction func appendItemAction(_ sender: UIButton) {
        tableView.append(textField.text)
    }

    @IBAction func removeItemAction(_ sender: UIButton) {
        guard textField.text != nil else { return }
        let index = Int(textField.text!) ?? -1
        tableView.remove(at: index)
    }

    @IBAction func setDataAction(_ sender: UIButton) {
        guard textField.text != nil else { return }
        let newData = [textField.text!]
        tableView.set(data: newData)
    }

    @IBAction func pushAction(_ sender: UIButton) {
        let root = UIViewController()
        let nav = MultoNavigationViewController(root: root)

        nav.header = MultoNavBarHeader()
        navigationController?.pushViewController(nav, animated: true)
    }
}

extension ViewController: ReusableTableViewSectionHeaderDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }
}


//
//  String+Addition.swift
//  CustomTableView
//
//  Created by Yi Zhang on 2020/12/22.
//

import UIKit

public typealias TextStyle = (font: UIFont, color: UIColor)

public extension String {
    func alter(_ text: String, from originalStyle: TextStyle, to targetStyle: TextStyle) -> NSAttributedString? {
        let range = (self as NSString).range(of: text)

        let attributedString = NSMutableAttributedString(string: self, attributes: [
            NSAttributedString.Key.font: originalStyle.font,
            NSAttributedString.Key.foregroundColor: originalStyle.color
        ])

        attributedString.setAttributes([
            NSAttributedString.Key.font: targetStyle.font,
            NSAttributedString.Key.foregroundColor: targetStyle.color
        ], range: range)

        return attributedString
    }
}

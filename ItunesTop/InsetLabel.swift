//
//  InsetLabel.swift
//  testPod
//
//  Created by Sergey Gusev on 13.03.2018.
//  Copyright © 2018 Sergey Gusev. All rights reserved.
//
import UIKit
import Foundation
class InsetLabel: UILabel {
    let topInset = CGFloat(0)
    let bottomInset = CGFloat(20)
    let leftInset = CGFloat(20)
    let rightInset = CGFloat(20)

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    func commonInitOverview(overview: String) {
        self.text = overview

        self.textAlignment = .justified
        self.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        self.backgroundColor = UIColor.white
        self.textColor = UIColor.darkText
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
    }
    func commonInitName(name: String) {
        self.text = "\n" + name
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        self.backgroundColor = UIColor.white
        self.textColor = UIColor.darkText
        self.numberOfLines = 0
    }
    func commonInitEmptyFavorite() {
        self.text = "\n No one Favorite movies\n Just swipe right"
        self.textAlignment = .center
        self.font = UIFont(name: "TrebuchetMS", size: 16)
        self.backgroundColor = UIColor.white
        self.textColor = UIColor.darkText
        self.numberOfLines = 0
    }
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    func generateCard (film: Films) -> UIView {
        let label = InsetLabel()
        label.commonInitName(name: film.nameFilm)
        let label1 = InsetLabel()
        label1.commonInitOverview(overview: film.overview + "\n\nRelease date: " + film.releaseDate)
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(label1)
        return stackView
    }
    func generateTop25 (film: Films, description: String) -> UIView {
        let label = InsetLabel()
        label.commonInitName(name: film.nameFilm)
        let label1 = InsetLabel()
        label1.commonInitOverview(overview: description + "\n\nRelease date: " + film.releaseDate)
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(label1)
        return stackView
    }
}

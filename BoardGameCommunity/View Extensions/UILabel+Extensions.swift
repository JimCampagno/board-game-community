//
//  UILabel+Extensions.swift
//  BoardGameCommunity
//
//  Created by Jim Campagno on 11/2/21.
//

import UIKit

enum LabelType {
    case title
}

enum LabelProperty {
    case font(UIFont)
    case minimumScaleFactor(CGFloat)
    case textAlignment(NSTextAlignment)
    case textColor(UIColor)
    case isUserInteractionEnabled(Bool)
}

extension UILabel {

    func set(properties: LabelProperty...) {
        setup(properties: properties)
    }

    convenience init(type: LabelType,
                     translatesAutoresizingMaskIntoConstraints: Bool = false) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        switch type {
        case .title:
            let properties: [LabelProperty] = [
                .font(.systemFont(ofSize: 30, weight: .medium)),
                .minimumScaleFactor(0.8),
                .textAlignment(.center),
                .textColor(.black),
                .isUserInteractionEnabled(true)
            ]
            setup(properties: properties)
        }
    }

    convenience init(properties: LabelProperty...,
                     translatesAutoresizingMaskIntoConstraints: Bool = false) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        setup(properties: properties)
    }

    private func setup(properties: [LabelProperty]) {
        properties.forEach { property in
            switch property {
            case .textAlignment(let value):
                textAlignment = value
            case .minimumScaleFactor(let value):
                minimumScaleFactor = value
            case .font(let value):
                font = value
            case .textColor(let value):
                textColor = value
            case .isUserInteractionEnabled(let value):
                isUserInteractionEnabled = value
            }
        }
    }
}



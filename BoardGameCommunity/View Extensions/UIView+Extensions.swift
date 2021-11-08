//
//  UIView+Extensions.swift
//  BoardGameCommunity
//
//  Created by Jim Campagno on 11/2/21.
//

import UIKit


extension NSLayoutConstraint {
    @discardableResult
    func offset(_ value: CGFloat) -> Self {
        constant = value
        return self
    }
}


extension UIView {
    typealias ConstraintResponse = (NSLayoutConstraint) -> Void

    var leading: Anchor.Axis {
        .leading(.x(leadingAnchor), view: self)
    }

    var trailing: Anchor.Axis {
        .trailing(.x(trailingAnchor), view: self)
    }

    var left: Anchor.Axis {
        .left(.x(leftAnchor), view: self)
    }

    var right: Anchor.Axis {
        .right(.x(rightAnchor), view: self)
    }

    var top: Anchor.Axis {
        .top(.y(topAnchor), view: self)
    }

    var bottom: Anchor.Axis {
        .bottom(.y(bottomAnchor), view: self)
    }

    var centerX: Anchor.Axis {
        .centerX(.x(centerXAnchor), view: self)
    }

    var centerY: Anchor.Axis {
        .centerY(.y(centerYAnchor), view: self)
    }

    var firstBaseline: Anchor.Axis {
        .firstBaseline(.y(firstBaselineAnchor), view: self)
    }

    var lastBaseline: Anchor.Axis {
        .lastBaseline(.y(lastBaselineAnchor), view: self)
    }

    var width: Anchor.Dimension {
        .width(.size(widthAnchor), view: self)
    }

    var height: Anchor.Dimension {
        .height(.size(heightAnchor), view: self)
    }

    enum Anchor  {
        struct Axis {
            enum AnchorType {
                case leading, trailing, top, bottom, left, right, centerX, centerY, firstBaseline, lastBaseline
            }

            enum Anchor {
                case x(NSLayoutXAxisAnchor)
                case y(NSLayoutYAxisAnchor)
            }

            let anchor: Anchor
            private let view: UIView
            private let anchorType: AnchorType
            private var priorAnchors: [Self] = []

            private init(anchor: Anchor,
                         anchorType: AnchorType,
                         view: UIView,
                         priorAnchors: [Self] = []) {
                self.anchor = anchor
                self.anchorType = anchorType
                self.view = view
                self.priorAnchors = priorAnchors
            }

            static func leading(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .leading, view: view)
            }

            static func trailing(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .trailing, view: view)
            }

            static func top(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .top, view: view)
            }

            static func bottom(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .bottom, view: view)
            }

            static func left(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .left, view: view)
            }

            static func right(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .right, view: view)
            }

            static func centerX(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .centerX, view: view)
            }

            static func centerY(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .centerY, view: view)
            }

            static func firstBaseline(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .firstBaseline, view: view)
            }

            static func lastBaseline(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .lastBaseline, view: view)
            }

            var leading: Self {
                var leadingAnchor = view.leading
                leadingAnchor.priorAnchors += priorAnchors + [self]
                return leadingAnchor
            }

            var trailing: Self {
                var trailingAnchor = view.trailing
                trailingAnchor.priorAnchors += priorAnchors + [self]
                return trailingAnchor
            }

            var top: Self {
                var topAnchor = view.top
                topAnchor.priorAnchors += priorAnchors + [self]
                return topAnchor
            }

            var left: Self {
                var leftAnchor = view.left
                leftAnchor.priorAnchors += priorAnchors + [self]
                return leftAnchor
            }

            var right: Self {
                var rightAnchor = view.right
                rightAnchor.priorAnchors += priorAnchors + [self]
                return rightAnchor
            }

            var centerX: Self {
                var centerXAnchor = view.centerX
                centerXAnchor.priorAnchors += priorAnchors + [self]
                return centerXAnchor
            }

            var centerY: Self {
                var centerYAnchor = view.centerY
                centerYAnchor.priorAnchors += priorAnchors + [self]
                return centerYAnchor
            }

            var firstBaseline: Self {
                var firstBaselineAnchor = view.firstBaseline
                firstBaselineAnchor.priorAnchors += priorAnchors + [self]
                return firstBaselineAnchor
            }

            var lastBaseline: Self {
                var lastBaselineAnchor = view.lastBaseline
                lastBaselineAnchor.priorAnchors += priorAnchors + [self]
                return lastBaselineAnchor
            }

            @discardableResult
            func equalTo(_ view: UIView,
                         isActive: Bool = true,
                         inset: CGFloat = 0) -> [NSLayoutConstraint] {
                let allAnchors = (priorAnchors + [self]).reversed()
                var constraints: [NSLayoutConstraint] = []

                allAnchors.forEach { anchor in
                    switch anchor.anchorType {
                    case .trailing:
                        constraints.append(anchor.equalTo(view.trailing, isActive: isActive, offset: -inset))
                    case .leading:
                        constraints.append(anchor.equalTo(view.leading, isActive: isActive, offset: inset))
                    case .top:
                        constraints.append(anchor.equalTo(view.top, isActive: isActive, offset: inset))
                    case .bottom:
                        constraints.append(anchor.equalTo(view.bottom, isActive: isActive, offset: -inset))
                    case .left:
                        constraints.append(anchor.equalTo(view.left, isActive: isActive, offset: inset))
                    case .right:
                        constraints.append(anchor.equalTo(view.right, isActive: isActive, offset: -inset))
                    case .centerX:
                        constraints.append(anchor.equalTo(view.centerX, isActive: isActive, offset: inset))
                    case .centerY:
                        constraints.append(anchor.equalTo(view.centerY, isActive: isActive, offset: inset))
                    case .firstBaseline:
                        constraints.append(anchor.equalTo(view.firstBaseline, isActive: isActive, offset: inset))
                    case .lastBaseline:
                        constraints.append(anchor.equalTo(view.lastBaseline, isActive: isActive, offset: -inset))
                    }
                }

                return constraints
            }

            @discardableResult
            func equalTo(_ axis: Self, isActive: Bool = true, offset: CGFloat = 0) -> NSLayoutConstraint {

                let constraint: NSLayoutConstraint
                switch (anchor, axis.anchor) {
                case let (.x(leftValue), .x(rightValue)):
                    constraint = leftValue.constraint(equalTo: rightValue).offset(offset)
                case let (.y(leftValue), .y(rightValue)):
                    constraint = leftValue.constraint(equalTo: rightValue).offset(offset)
                default:
                    fatalError("Nope.")
                }
                constraint.isActive = isActive

                return constraint
            }
        }

        struct Dimension {
            enum Anchor {
                case size(NSLayoutDimension)
            }

            enum AnchorType {
                case height, width
            }

            let anchor: Anchor
            private let view: UIView
            private let anchorType: AnchorType
            private var priorAnchors: [Self] = []

            private init(anchor: Anchor,
                         anchorType: AnchorType,
                         view: UIView,
                         priorAnchors: [Self] = []) {
                self.anchor = anchor
                self.anchorType = anchorType
                self.view = view
                self.priorAnchors = priorAnchors
            }

            static func height(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .height, view: view)
            }

            static func width(_ anchor: Anchor, view: UIView) -> Self {
                .init(anchor: anchor, anchorType: .width, view: view)
            }

            var height: Self {
                var heightAnchor = view.height
                heightAnchor.priorAnchors += priorAnchors + [self]
                return heightAnchor
            }

            var width: Self {
                var widthAnchor = view.width
                widthAnchor.priorAnchors += priorAnchors + [self]
                return widthAnchor
            }

            @discardableResult
            func equalTo(_ view: UIView,
                         isActive: Bool = true,
                         inset: CGFloat = 0) -> [NSLayoutConstraint] {
                let allAnchors = (priorAnchors + [self]).reversed()
                var constraints: [NSLayoutConstraint] = []

                allAnchors.forEach { anchor in
                    switch anchor.anchorType {
                    case .width:
                        constraints.append(anchor.equalTo(view.width, isActive: isActive, offset: inset))
                    case .height:
                        constraints.append(anchor.equalTo(view.height, isActive: isActive, offset: inset))
                    }
                }
                return constraints
            }

            @discardableResult
            func equalTo(_ axis: Self, isActive: Bool = true, offset: CGFloat = 0) -> NSLayoutConstraint {
                let constraint: NSLayoutConstraint
                switch (anchor, axis.anchor) {
                case let (.size(leftValue), .size(rightValue)):
                    constraint = leftValue.constraint(equalTo: rightValue).offset(offset)

                }
                constraint.isActive = isActive
                return constraint
            }
        }
    }
}


extension Array where Element == NSLayoutConstraint {
    func isActive(_ value: Bool) {
        forEach { $0.isActive = value }
    }


}

func +=<T: NSLayoutConstraint>(left: inout [T], right: T) {
  left.append(right)
}

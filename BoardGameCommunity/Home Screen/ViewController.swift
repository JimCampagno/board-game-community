//
//  ViewController.swift
//  BoardGameCommunity
//
//  Created by Jim Campagno on 11/2/21.
//

import UIKit
import Foundation

extension UIViewController {
    var orientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }
}

struct Delay {
    let dispatchTime: DispatchTime

    static var oneSecond: Delay { .init(dispatchTime: .now() + 1) }
    static var twoSeconds: Delay { .init(dispatchTime: .now() + 2) }
    static var threeSeconds: Delay { .init(dispatchTime: .now() + 3) }
    static var fourSeconds: Delay { .init(dispatchTime: .now() + 4) }
    static var fiveSeconds: Delay { .init(dispatchTime: .now() + 5) }
}


func asyncAfter(delay: Delay, _ closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: delay.dispatchTime) {
        closure()
    }
}


extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach { addSubview($0) }
    }
}


class ViewController: UIViewController {
    private let label = UILabel(type: .title)
    private let anotherLabel = UILabel(type: .title)

    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Hello to you"
        anotherLabel.text = "👾"

        view.addSubviews(views: label, anotherLabel)

        portraitConstraints += anotherLabel.top.equalTo(label.bottom, offset: 20)
        portraitConstraints += label.centerX.centerY.equalTo(view)

        anotherLabel.centerX.equalTo(label)

        landscapeConstraints += anotherLabel.bottom.equalTo(view, isActive: false)
        landscapeConstraints += label.top.centerX.equalTo(view, isActive: false)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)


        if orientation.isPortrait {
            landscapeConstraints.isActive(false)
            portraitConstraints.isActive(true)
        } else {
            portraitConstraints.isActive(false)
            landscapeConstraints.isActive(true)
        }

        coordinator.animate(alongsideTransition: { [unowned self] context in
            view.layoutIfNeeded()
        })
    }
}


















/*
 let first = anotherLabel.top.equalTo(label.bottom, offset: 5)
 let second = anotherLabel.top.equalTo(label.bottom, isActive: false, offset: 250)

 asyncAfter(delay: .fourSeconds) {
 first.isActive = false
 second.isActive = true

 UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 2.5, options: .curveEaseInOut, animations: {
 self.view.layoutIfNeeded()
 })
 }
 */

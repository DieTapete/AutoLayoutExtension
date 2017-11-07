//
//  UIView+AutoLayout.swift
//
//  Copyright © 2016 tapwork GmbH. All rights reserved.
//

import UIKit

protocol AutoLayoutable {
    var leadingAnchor:NSLayoutXAxisAnchor { get }
    var trailingAnchor:NSLayoutXAxisAnchor { get }
    var leftAnchor:NSLayoutXAxisAnchor { get }
    var rightAnchor:NSLayoutXAxisAnchor { get }
    
    var topAnchor:NSLayoutYAxisAnchor { get }
    var bottomAnchor:NSLayoutYAxisAnchor { get }
    var widthAnchor:NSLayoutDimension { get }
    var heightAnchor:NSLayoutDimension { get }
    
    var centerXAnchor:NSLayoutXAxisAnchor { get }
    var centerYAnchor:NSLayoutYAxisAnchor { get }
}

extension UIView: AutoLayoutable {}
extension UILayoutGuide: AutoLayoutable {}

extension UIView {
    public static func useAutoLayout(_ views:[UIView?]) {
        _ = views.map {$0?.translatesAutoresizingMaskIntoConstraints = false}
    }
    
    private func pinXAxisAnchor(_ anchor:NSLayoutAnchor<NSLayoutXAxisAnchor>, to targetAnchor:NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                constant: CGFloat?) -> NSLayoutConstraint {
        let constant = constant ?? 0
        let constraint = anchor.constraint(equalTo: targetAnchor, constant: constant)
        constraint.isActive = true
        
        return constraint
    }
    
    private func pinYAxisAnchor(_ anchor:NSLayoutAnchor<NSLayoutYAxisAnchor>, to targetAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat?) -> NSLayoutConstraint {
        let constant = constant ?? 0
        let constraint = anchor.constraint(equalTo: targetAnchor, constant: constant)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterX(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinXAxisAnchor(centerXAnchor, to:target.centerXAnchor, constant: constant)
    }
    
    @discardableResult
    func pinCenterY(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinYAxisAnchor(centerYAnchor, to:target.centerYAnchor, constant: constant)
    }
    
    @discardableResult
    func pinCenterYToTop(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinYAxisAnchor(centerYAnchor, to:target.topAnchor, constant: constant)
    }
    
    @discardableResult
    func pinCenter(_ target:AutoLayoutable) -> (centerXConstraint: NSLayoutConstraint, centerYConstraint: NSLayoutConstraint) {
        let centerXConstraint = pinCenterX(target)
        let centerYConstraint = pinCenterY(target)
        return (centerXConstraint, centerYConstraint)
    }
    
    @discardableResult
    func pinLeading(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinXAxisAnchor(leadingAnchor, to:target.leadingAnchor, constant: constant)
    }
    
    @discardableResult
    func pinLeadingToTrailing(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinXAxisAnchor(leadingAnchor, to:target.trailingAnchor, constant: constant)
    }
    
    @discardableResult
    func pinTrailing(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinXAxisAnchor(trailingAnchor, to:target.trailingAnchor, constant: constant)
    }
    
    @discardableResult
    func pinTrailingToLeading(_ target:AutoLayoutable, constant:CGFloat? = 0) -> NSLayoutConstraint {
        return pinXAxisAnchor(trailingAnchor, to:target.leadingAnchor, constant: constant)
    }
    
    @discardableResult
    func pinTop(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinYAxisAnchor(topAnchor, to:target.topAnchor, constant: constant)
    }
    
    @discardableResult
    func pinTopToBottom(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinYAxisAnchor(topAnchor, to:target.bottomAnchor, constant: constant)
    }
    
    @discardableResult
    func pinBottom(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinYAxisAnchor(bottomAnchor, to:target.bottomAnchor, constant: constant)
    }
    
    @discardableResult
    func pinBottomToTop(_ target:AutoLayoutable, constant: CGFloat? = 0) -> NSLayoutConstraint {
        return pinYAxisAnchor(bottomAnchor, to:target.topAnchor, constant: constant)
    }
    
    @discardableResult
    func pinVertical(_ target:AutoLayoutable) -> (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint) {
        return (pinTop(target), pinBottom(target))
    }
    
    @discardableResult
    func pinHorizontal(_ target:AutoLayoutable) -> (leadingConstraint: NSLayoutConstraint, trailingConstraint: NSLayoutConstraint) {
        return (pinLeading(target), pinTrailing(target))
    }
    
    @discardableResult
    func pinAllSides(_ target:AutoLayoutable) -> (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint, topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint) {
        return (pinLeading(target), pinTrailing(target), pinTop(target), pinBottom(target))
    }
    
    @discardableResult
    func keepAspectRatio(_ aspectRatio: CGFloat = 0, basedOnAxis axis:UILayoutConstraintAxis) -> NSLayoutConstraint {
        var aspectRatio = aspectRatio
        if let imageView = self as? UIImageView,
            let image = imageView.image,
            aspectRatio == 0 {
            switch axis {
            case .horizontal:
                aspectRatio = image.size.height / image.size.width
            case .vertical:
                aspectRatio = image.size.width / image.size.height
            }
        }
        
        var constraint: NSLayoutConstraint!
        switch axis {
        case .horizontal:
            constraint = heightAnchor.constraint(equalTo: widthAnchor, multiplier: aspectRatio)
        case .vertical:
            constraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: aspectRatio)
        }
        
        constraint.isActive = true
        return constraint
    }
}

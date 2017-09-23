//
//  SpinnerView.swift
//  LoadingAnimation
//
//  Created by Antonis papantoniou on 9/16/17.
//  Copyright © 2017 Antonis papantoniou. All rights reserved.
//

import UIKit

public class SpinnerView: UIView {

  let shape = CAShapeLayer()
  let gradientLayer = CAGradientLayer()
  var gradientColors: [CGColor] = []

  convenience public init(frame: CGRect, strokeStart: CGFloat,
                          strokeEnd: CGFloat, gradientColors: [CGColor]) {
    self.init(frame: frame)
    self.backgroundColor = .clear
    shape.fillColor = nil
    shape.strokeColor = UIColor.black.cgColor
    shape.backgroundColor = UIColor.clear.cgColor
    shape.fillColor = nil
    shape.lineWidth = 6
    shape.strokeEnd = strokeEnd
    shape.strokeStart = strokeStart
    self.gradientColors = gradientColors
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    shape.frame = self.bounds
    setPath()
    setGradient()
  }

  private func setPath() {
    shape.path = UIBezierPath(ovalIn: bounds.insetBy(dx: shape.lineWidth / 2,
                                                     dy: shape.lineWidth / 2)).cgPath
    shape.lineCap = kCALineCapRound
  }

  private func setGradient() {
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.frame = self.layer.bounds
    gradientLayer.colors = gradientColors
    gradientLayer.mask = shape
    layer.addSublayer(gradientLayer)
  }
  
}

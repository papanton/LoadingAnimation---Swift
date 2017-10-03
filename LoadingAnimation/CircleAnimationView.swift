//
//  CircleAnimationView.swift
//  LoadingAnimation
//
//  Created by Antonis papantoniou on 9/16/17.
//  Copyright © 2017 Antonis papantoniou. All rights reserved.
//

import UIKit

struct Pose {
  let secondsSincePriorPose: CFTimeInterval
  let start: CGFloat
  init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat) {
    self.secondsSincePriorPose = secondsSincePriorPose
    self.start = start
  }
}

class CircleAnimationView: UIView {

  var spinnerViews: [SpinnerView] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear

    let firstView = SpinnerView(
      frame: bounds, strokeStart: 0.0, strokeEnd: 1.0,
      gradientColors: [UIColor.cyan.cgColor,
                       UIColor(valueRed: 141, green: 255, blue: 240).cgColor])

    let secondView = SpinnerView(
      frame: bounds, strokeStart: 0.2, strokeEnd: 0.5,
      gradientColors: [UIColor(valueRed: 0, green: 83, blue: 89).cgColor,
                       UIColor(valueRed: 157, green: 240, blue: 247).cgColor])
    let thirdView = SpinnerView(
      frame: bounds,
      strokeStart: 0.6, strokeEnd: 0.9,
      gradientColors: [UIColor(valueRed: 0, green: 83, blue: 89).cgColor,
                       UIColor(valueRed: 157, green: 240, blue: 247).cgColor])

    secondView.alpha = 0.7
    thirdView.alpha = 0.7

    spinnerViews.append(firstView)
    spinnerViews.append(secondView)
    spinnerViews.append(thirdView)

    for view in spinnerViews {
      addSubview(view)
    }
    startAnimations()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    for view in spinnerViews {
      view.frame = bounds
    }
  }

  func startAnimations() {
    animateFirstView()
    animateSecondView()
    animateThirdView()
  }

  private func animateFirstView() {
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    animation.toValue = CGFloat(2 * Double.pi)
    animation.duration = 3.0
    animation.repeatCount = .infinity
    spinnerViews[0].layer.add(animation, forKey: animation.keyPath)
  }

  private func animateSecondView() {
    let poses = [Pose(0.0, 0.0),
                 Pose(1.2, 0.5),
                 Pose(3.0, -1.2),
                 Pose(3.0, 0.5),
                 Pose(1.5, 0.0)]

    animate(poses: poses, layer: spinnerViews[1].layer)
  }

  private func animateThirdView() {
    let poses = [Pose(0.0, 0.0),
                 Pose(2.0, 1.5),
                 Pose(2.0, -0.5),
                 Pose(1.0, 0.0),
                 Pose(1.0, 0.0)]
    animate(poses: poses, layer: spinnerViews[2].layer)
  }

  private func animate(poses: [Pose], layer: CALayer) {
    var time: CFTimeInterval = 0
    var times = [CFTimeInterval]()
    var start: CGFloat = 0
    var rotations = [CGFloat]()

    let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }

    for pose in poses {
      time += pose.secondsSincePriorPose
      times.append(time / totalSeconds)
      start = pose.start
      rotations.append(start * 2 * .pi)
    }

    times.append(times.last!)
    rotations.append(rotations[0])

    animateKeyPath(keyPath: "transform.rotation",
                   duration: totalSeconds, times: times,
                   values: rotations, layer: layer)
  }

  private func animateKeyPath(keyPath: String, duration: CFTimeInterval,
                              times: [CFTimeInterval], values: [CGFloat],
                              layer: CALayer) {
    let animation = CAKeyframeAnimation(keyPath: keyPath)
    animation.keyTimes = times as [NSNumber]?
    animation.values = values
    animation.calculationMode = kCAAnimationLinear
    animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
    animation.duration = duration
    animation.repeatCount = Float.infinity
    layer.add(animation, forKey: keyPath)
  }

}

public extension UIColor {

  /// Initializes UIColor given RGB values between 0 and 255 inclusive, and optionally an alpha
  /// value between 0 and 1.0 inclusive.
  convenience init(valueRed red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
              blue: CGFloat(blue) / 255.0, alpha: alpha)
  }

}

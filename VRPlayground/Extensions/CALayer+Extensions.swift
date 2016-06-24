import Foundation
import QuartzCore

extension CALayer {

    public class func animateWithDuration(duration: NSTimeInterval, animation: () -> Void, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock(completion)
        animation()
        CATransaction.commit()
    }

    func rippleAnimation(duration: NSTimeInterval, rippleRadius radius: CGFloat, rippleColor: CGColorRef) {
        let sizeWidth: CGFloat = radius * 2
        let rippleLayer = CALayer()
        rippleLayer.frame = CGRect(origin: CGPoint.zero, size: CGSizeMake(sizeWidth, sizeWidth))
        rippleLayer.position = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
        rippleLayer.cornerRadius = radius
        rippleLayer.backgroundColor = rippleColor
        rippleLayer.opacity = 0
        self.addSublayer(rippleLayer)

        CALayer.animateWithDuration(duration, animation: { _ in

            let rippleAnimation = CABasicAnimation(keyPath: Strings.CAKeyPath.Scale)
            rippleAnimation.fromValue = 0.7
            rippleAnimation.toValue = 1.3

            let opacityAnimation = CABasicAnimation(keyPath: Strings.CAKeyPath.Opacity)
            opacityAnimation.fromValue = 0.6
            opacityAnimation.toValue = 0

            let groupAnimation = CAAnimationGroup()
            groupAnimation.animations = [rippleAnimation, opacityAnimation]
            groupAnimation.removedOnCompletion = true
            rippleLayer.addAnimation(groupAnimation, forKey: nil)
            }) { _ in
                rippleLayer.removeFromSuperlayer()
        }
    }

}

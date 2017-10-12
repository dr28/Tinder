//
//  ViewController.swift
//  Tinder
//
//  Created by Deepthy on 10/11/17.
//  Copyright © 2017 Deepthy. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet  var draggableImgView: DraggableImageView?
    
    private var photoCenter: CGPoint!
    fileprivate var isPresenting: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        draggableImgView?.imageView.image = #imageLiteral(resourceName: "ryan")
    }

    @IBAction func onHorizontalPan(_ sender: UIPanGestureRecognizer) {
        let customView = sender.view as! DraggableImageView
        let translation = sender.translation(in: view)

        switch sender.state {
            case .began:
                photoCenter = customView.center
            case .changed:
                //customView.center = CGPoint(x: photoCenter.x + translation.x, y: customView.center.y)
                customView.center.x = photoCenter.x + translation.x
                
                let z = min(abs(translation.x), 20)
            
                var rotationRadians = z.degreesToRadians

                if translation.x < 0 {
                    rotationRadians = -rotationRadians
                }
                UIView.animate(withDuration: 0.4, animations: {
                    customView.transform = CGAffineTransform(rotationAngle: rotationRadians)
                })
            case .ended:
            
                if translation.x > 50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        customView.center.x = self.photoCenter.x + 375 + self.photoCenter.x/2
                    })
                } else if translation.x < -50 {
                    UIView.animate(withDuration: 0.5, animations: {
                        customView.center.x = self.photoCenter.x - 375 - self.photoCenter.x/2
                    })
                } else {
                    UIView.animate(withDuration: 0.5, animations: {
                        customView.center = self.photoCenter
                        customView.transform = CGAffineTransform.identity
                    })
                }
            default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showprofile" {
            let destination = segue.destination as! ProfileViewController
           // destination.modalPresentationStyle = UIModalPresentationStyle.custom
            destination.transitioningDelegate = self
            destination.image = draggableImgView?.imageView.image
        }
    }
}

extension CardsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return FadeTransition() //self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return FadeTransition() //self
    }
}
// used FadeTransition basae classs, instead can use the commented code below

/*extension CardsViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4

    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            }
        } else {
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            }
        }
    }
}*/

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


import UIKit
import Foundation

fileprivate class UnlimitNavBarContainer: UIView {
    
    private var customNavigationBar: UIView?
    let expectHeight: CGFloat
    var containerIsHidden: Bool = false
    
    required init(statusBarColor: UIColor, expectHeight: CGFloat) {
        self.expectHeight = expectHeight
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        self.customNavigationBar = view
    }
    
    func loadNavigationBar() -> UIView? {
        return self.customNavigationBar
    }
}

public extension UIViewController {
    
    enum AnimateType {
        case autohide
        case scrollHide
    }
    
    func applyNavigationBar(_ customView: UIView,
                            expectHeight: CGFloat,
                            backButton: UIButton?,
                            statusBarColor: UIColor = .white,
                            subViewTopConstraint: NSLayoutConstraint? = nil,
                            relatedScrollView: UIScrollView? = nil) {
        guard let navigationController = self.navigationController else { return }
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.removeFromSuperview()
        
        if let backButton = backButton, navigationController.viewControllers.count <= 1 {
            backButton.removeFromSuperview()
        }
        
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        
        // let hasBackButton = navigationController.viewControllers.count > 1
        let _customNavigationBarContainerView = UnlimitNavBarContainer(statusBarColor: statusBarColor,
                                                                       expectHeight: expectHeight)
        _customNavigationBarContainerView.backgroundColor = statusBarColor
        _customNavigationBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(_customNavigationBarContainerView)
        self.view.addConstraints(_customNavigationBarContainerViewConstraints( _customNavigationBarContainerView,
                                                                               self.view,
                                                                               expectHeight,
                                                                               statusBarHeight))
        
        _customNavigationBarContainerView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        _customNavigationBarContainerView.addConstraints(self._customNavigationBarConstraint(customView,
                                                                                             _customNavigationBarContainerView,
                                                                                             statusBarHeight))
        self.updateRelatedViewConstraint(contraint: subViewTopConstraint)
        self.updateRelatedScrollViewContentInset(scrollView: relatedScrollView)
    }
    
    func updateRelatedViewConstraint(contraint: NSLayoutConstraint?) {
        guard let constraint = contraint, let containerView = self.loadUnlimitNavBarContainer() else { return }
        constraint.constant = constraint.constant + containerView.expectHeight
    }
    
    func updateRelatedScrollViewContentInset(scrollView: UIScrollView?) {
        guard let scrollView = scrollView, let containerView = self.loadUnlimitNavBarContainer() else { return }
        scrollView.contentInset.top = scrollView.contentInset.top + containerView.expectHeight
    }
    
    
    func transitionAnimateion(_ scrollView: UIScrollView, type: AnimateType, duration: TimeInterval = 0.5) {
        switch type {
        case .autohide:
            guard let containerView = self.loadUnlimitNavBarContainer(),
                let navBar = containerView.loadNavigationBar() else { return }
            let expectHeight = containerView.expectHeight
            let velocity = scrollView.panGestureRecognizer.velocity(in: self.view).y
            
            let animate = {
                if velocity < 0, !containerView.containerIsHidden {
                    containerView.containerIsHidden = true
                    navBar.alpha = 0.0
                    containerView.transform = CGAffineTransform(translationX: 0.0, y: -expectHeight)
                } else if velocity > 0, containerView.containerIsHidden {
                    navBar.alpha = 1.0
                    containerView.containerIsHidden = false
                    containerView.transform = .identity
                }
            }
            
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           options: !containerView.containerIsHidden ? .curveEaseOut: .curveEaseIn,
                           animations: animate,
                           completion: nil)
        case .scrollHide:
            // TODO: scroll hide
            break
        }
    }
    
    private func loadUnlimitNavBarContainer() -> UnlimitNavBarContainer? {
        for containerView in self.view.subviews {
            guard let containerView = containerView as? UnlimitNavBarContainer else { continue }
            return containerView
        }
        
        return nil
    }
    
    private func _customNavigationBarConstraint(_ customView: UIView,
                                                _ targetView: UIView,
                                                _ statusBarHeight: CGFloat) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(item: customView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: statusBarHeight),
                NSLayoutConstraint(item: customView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 0.0),
                NSLayoutConstraint(item: customView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 0.0),
                NSLayoutConstraint(item: customView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 0.0)]
    }
    
    private func _customNavigationBarContainerViewConstraints(_ customView: UIView,
                                                              _ targetView: UIView,
                                                              _ expectHeight: CGFloat,
                                                              _ statusBarHeight: CGFloat) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(item: customView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 0.0),
                NSLayoutConstraint(item: customView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 0.0),
                NSLayoutConstraint(item: customView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: targetView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 0.0),
                NSLayoutConstraint(item: customView,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: expectHeight + statusBarHeight)]
    }
}

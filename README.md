# UnlimitBar

[![CI Status](http://img.shields.io/travis/Geektree0101/UnlimitBar.svg?style=flat)](https://travis-ci.org/Geektree0101/UnlimitBar)
[![Version](https://img.shields.io/cocoapods/v/UnlimitBar.svg?style=flat)](http://cocoapods.org/pods/UnlimitBar)
[![License](https://img.shields.io/cocoapods/l/UnlimitBar.svg?style=flat)](http://cocoapods.org/pods/UnlimitBar)
[![Platform](https://img.shields.io/cocoapods/p/UnlimitBar.svg?style=flat)](http://cocoapods.org/pods/UnlimitBar)

<img src="https://github.com/GeekTree0101/UnlimitBar/blob/master/resource/UnlimitBar1.png" />
<img src="https://github.com/GeekTree0101/UnlimitBar/blob/master/resource/UnlimitBar2.png" />
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
    // If viewController has Scroll view

        let bundle = Bundle.init(for: TestNavbar.self)
        let nib = UINib(nibName: String(describing: TestNavbar.self), bundle: bundle)
        let nibView = nib.instantiate(withOwner: TestNavbar.self, options: nil).first

        let customNavBar = nibView as! TestNavbar // Custom NavigationBar (UIView)

        self.applyNavigationBar(customNavBar,
                                expectHeight: 44.0, // customNavBar height
                                backButton: customNavBar.backButton, // backButton (UIButton)
                                relatedScrollView: tableView)

        // add touch target
        customNavBar.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)

   // If top component has top constraint

    // @IBOutlet weak var topConstraint: NSLayoutConstraint!

        let bundle = Bundle.init(for: TestNavbar.self)
        let nib = UINib(nibName: String(describing: TestNavbar.self), bundle: bundle)
        let nibView = nib.instantiate(withOwner: TestNavbar.self, options: nil).first
        let customNavBar = nibView as! TestNavbar
        
        self.applyNavigationBar(customNavBar, expectHeight: 44.0, backButton: customNavBar.backButton, subViewTopConstraint: topConstraint)

        
        customNavBar.titleLabel.text = "SingleView"
        customNavBar.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        customNavBar.testButton.addTarget(self, action: #selector(hello), for: .touchUpInside)
        
        self.view.backgroundColor = .yellow
```

## Requirements

## Installation

UnlimitBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UnlimitBar'
```

## Author

Geektree0101, h2s1880@gmail.com

## License

UnlimitBar is available under the MIT license. See the LICENSE file for more info.

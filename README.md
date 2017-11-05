# UnlimitBar

[![CI Status](http://img.shields.io/travis/Geektree0101/UnlimitBar.svg?style=flat)](https://travis-ci.org/Geektree0101/UnlimitBar)
[![Version](https://img.shields.io/cocoapods/v/UnlimitBar.svg?style=flat)](http://cocoapods.org/pods/UnlimitBar)
[![License](https://img.shields.io/cocoapods/l/UnlimitBar.svg?style=flat)](http://cocoapods.org/pods/UnlimitBar)
[![Platform](https://img.shields.io/cocoapods/p/UnlimitBar.svg?style=flat)](http://cocoapods.org/pods/UnlimitBar)

<img src="https://github.com/GeekTree0101/UnlimitBar/blob/master/resource/UnlimitBar1.png" />
<img src="https://github.com/GeekTree0101/UnlimitBar/blob/master/resource/UnlimitBar2.png" />

### Feel the freedom from UINavigationBar ~~Holy Shit~~ Restrictions

## [Guideline]

1. import UnlimitBar
2. create custom navigation bar as UIView 
3. call applyNavigationBar method
+ If you want animate navigationBar then use transitionAnimateion method

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

1. ScrollView case
```swift
    // Create Custom UIView for NavigationBar
    let catFeedNavBar = CatFeedNavigationBar.loadView()
        
    // apply custom navigation bar
    self.applyNavigationBar(catFeedNavBar, // custom navbar
                            expectHeight: CatFeedNavigationBar.Const.height, // navbar default height
                            backButton: nil, // back button auto hide
                            statusBarColor: UIColor.white, // status bar color
                            relatedScrollView: tableView) // tableView -> autoresize content top inset
                                

```
transition animation
```swift
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.transitionAnimateion(scrollView, type: .autohide) // auto show/hide
        // if you want control show/hide navbar base scroll offset
        self.transitionAnimateion(scrollView, type: .transition(SHOW_OFFSET, HIDE_OFFSET)) 
        self.transitionAnimateion(scrollView, type: .reset) // reset animation
    }

```

2. Single ViewController
- first you need uppermost top constraint of view on view controller
```swift
    @IBOutlet weak var topConstraint: NSLayoutConstraint! 
    or
    let topConstraint: NSLayoutConstraint ...

```
- insert constraint parameter on applyNavigationBar method
```swift 
    let catNavigationBar = CatSingleNavigationBar.loadView()
        
    self.applyNavigationBar(catNavigationBar, // custom bar
                            expectHeight: CatSingleNavigationBar.Const.navBarHeight, // bar height
                            backButton: catNavigationBar.backButton, // back button
                            statusBarColor: UIColor.white, // color
                            subViewTopConstraint: self.topConstraint) // CONSTRAINT
```

## TODO(milestone)

- Fix some method name spelling
- Scroll offset base navigationBar animation
- Support TabBar
- Update constraint after rotate orientation

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

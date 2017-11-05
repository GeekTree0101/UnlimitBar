import UIKit

protocol XibDesignable : class {}

extension XibDesignable where Self : UIView {
    
    static func loadView() -> Self {
        
        let dynamicMetatype = Self.self
        let bundle = Bundle(for: dynamicMetatype)
        let nib = UINib(nibName: "\(dynamicMetatype)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            
            fatalError("Could not load view from nib file.")
        }
        return view
    }
}

extension UIView : XibDesignable {}

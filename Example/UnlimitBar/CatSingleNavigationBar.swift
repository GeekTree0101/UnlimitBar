import Foundation
import UIKit

class CatSingleNavigationBar: UIView {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var catAvatarImage: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeyButton: UIButton!
    
    struct Const {
        static let navBarHeight: CGFloat = 90.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        catAvatarImage.layer.cornerRadius = 25.0
    }
    
    func setupCatInformation(catImage: UIImage?, catName: String?) {
        catAvatarImage.image = catImage
        catNameLabel.text = catName
    }
}

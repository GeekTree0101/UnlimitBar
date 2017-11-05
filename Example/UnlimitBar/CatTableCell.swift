import UIKit

class CatTableCell: UITableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCat(image: UIImage, name: String) {
        self.catImageView.image = image
        self.catNameLabel.text = name
    }
}

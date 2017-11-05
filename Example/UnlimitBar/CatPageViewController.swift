import UIKit
import UnlimitBar

class CatPageViewController: UIViewController {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var catImage: UIImage?
    var name: String?
    
    init(catImage: UIImage, catName: String) {
        super.init(nibName: "CatPageViewController", bundle: nil)
        self.catImage = catImage
        self.name = catName
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catImageView.image = catImage
        self.catNameLabel.text = name
        self.catImageView.layer.cornerRadius = self.catImageView.frame.width / 2
        self.catImageView.clipsToBounds = true
        
        let catNavigationBar = CatSingleNavigationBar.loadView()
        catNavigationBar.setupCatInformation(catImage: catImage, catName: name)
        
        self.applyNavigationBar(catNavigationBar,
                                expectHeight: CatSingleNavigationBar.Const.navBarHeight,
                                backButton: catNavigationBar.backButton,
                                statusBarColor: UIColor.cat,
                                subViewTopConstraint: self.topConstraint)
        
        catNavigationBar.backButton.addTarget(self,
                                              action: #selector(didTapBack),
                                              for: .touchUpInside)
        catNavigationBar.shareButton.addTarget(self,
                                               action: #selector(didTapShare),
                                               for: .touchUpInside)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func didTapShare() {
        let alert = UIActivityViewController(activityItems: [], applicationActivities: nil)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

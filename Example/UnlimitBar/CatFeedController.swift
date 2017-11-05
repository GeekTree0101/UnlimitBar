import UIKit
import UnlimitBar
import SnapKit

class CatFeedController: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    let identifier: String = "Cat"
    let catImage: [UIImage] = [#imageLiteral(resourceName: "cat1"), #imageLiteral(resourceName: "cat2"), #imageLiteral(resourceName: "cat3"), #imageLiteral(resourceName: "cat4"), #imageLiteral(resourceName: "cat5")]
    let catName: [String] = ["Logcat", "Jamong", "Nabi", "Robin", "Coco"]
    
    struct Const {
        static let expectedNavigationBarHeight: CGFloat = 44.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupTableView()
        self.setupCustomNavigationBar()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: CatTableCell.self),
                                 bundle: nil),
                           forCellReuseIdentifier: identifier)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview()
        })
    }
    
    func setupCustomNavigationBar() {
        
        // Create Custom UIView for NavigationBar
        let catFeedNavBar = CatFeedNavigationBar.loadView()
        
        // apply custom navigation bar
        self.applyNavigationBar(catFeedNavBar,
                                expectHeight: CatFeedNavigationBar.Const.height,
                                backButton: nil,
                                statusBarColor: UIColor.cat,
                                relatedScrollView: tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transitionAnimateion(self.tableView, type: .reset)
    }
}

extension CatFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let img = self.catImage[indexPath.row]
        let name = self.catName[indexPath.row]
        let viewController = CatPageViewController(catImage: img, catName: name)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CatFeedController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.catImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let cell = reuseCell as? CatTableCell else { return reuseCell }
        cell.setupCat(image: self.catImage[indexPath.row], name: self.catName[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235.0
    }
}

extension CatFeedController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Unlimit Navigation Bar Animation
        self.transitionAnimateion(scrollView, type: .autohide)
        // self.transitionAnimateion(scrollView, type: .transition(100, 300))
    }
}


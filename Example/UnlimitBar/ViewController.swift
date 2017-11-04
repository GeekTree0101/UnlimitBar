//
//  ViewController.swift
//  UnlimitBar
//
//  Created by Geektree0101 on 11/04/2017.
//  Copyright (c) 2017 Geektree0101. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView.init(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TestCell.self, forCellReuseIdentifier: "Test")
        
        tableView.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview()
        })
        
        let customNavBar = TestNavbar.loadFromNib()
        customNavBar.titleLabel.text = "ViewController"
        self.applyNavigationBar(customNavBar,
                                expectHeight: 44.0,
                                backButton: customNavBar.backButton,
                                relatedScrollView: tableView)
        customNavBar.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            let viewController = SingleViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = ViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
        guard let cell = reuseCell as? TestCell else { return reuseCell }
        cell.update(number: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
}

extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.transitionAnimateion(scrollView, type: .autohide)
    }
}

class TestCell: UITableViewCell {
    
    let label = UILabel.init(frame: .zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "Test")
        self.label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
        self.label.textColor = .white
        self.contentView.addSubview(label)
        self.label.textAlignment = .center
        self.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        label.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        })
        self.selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(number: Int) {
        self.label.text = "\(number)"
    }
    
    
}




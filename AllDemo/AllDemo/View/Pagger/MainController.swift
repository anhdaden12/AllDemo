//
//  MainController.swift
//  AllDemo
//
//  Created by NgocNB on 12/7/20.
//

import UIKit

class MainController: PagingViewController {
    
    class func getInstance() -> MainController {
        return MainController()
    }
    
    let listPagingItem = [
        PagingIndexItem(index: 0, title: "Tất cả (\(Constant.all))"),
        PagingIndexItem(index: 1, title: "Chờ duyệt (\(Constant.pending))"),
        PagingIndexItem(index: 2, title: "Đã được duyệt(\(Constant.accept))"),
        PagingIndexItem(index: 3, title: "Bị từ chối (\(Constant.notok))")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        let index = UserDefaults.standard.integer(forKey: "INDEX_PAGING")
        select(index: index)
        self.font = UIFont.systemFont(ofSize: 12)
        self.selectedFont = UIFont.systemFont(ofSize: 12)
        self.textColor = UIColor.black
        menuItemSize = .selfSizing(estimatedWidth: 100, height: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}


extension MainController: PagingViewControllerDataSource, PagingViewControllerDelegate {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return 4
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        switch index {
        case 0:
            let vc = ViewController1()
            vc.didSelect = {
                print("select viewcontroller 1")
            }
            return vc
        case 1:
            return ViewController2()
        case 2:
            return ViewController3()
        case 3:
            return ViewController4()
        default:
            return UIViewController()
        }
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return listPagingItem[index]
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, didSelectItem pagingItem: PagingItem) {
        for (index,item) in listPagingItem.enumerated() {
            if pagingItem as! PagingIndexItem == item {
                // note save value equal 0 if screen go to willdisappear
                UserDefaults.standard.setValue(index, forKey: "INDEX_PAGING")
                print("you select item at index: \(index)")
            }
        }
    }
    
    
}

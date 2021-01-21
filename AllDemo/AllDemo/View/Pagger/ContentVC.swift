//
//  ContentVC.swift
//  AllDemo
//
//  Created by NgocNB on 12/7/20.
//

import UIKit

class ContentVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.embed(MainController.getInstance(), inView: mainView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.setValue(0, forKey: "INDEX_PAGING")
    }
    
    @IBAction func onUpdateAction(_ sender: Any) {
        Constant.all = Int.random(in: 0...100)
        Constant.accept = Int.random(in: 0...100)
        Constant.pending = Int.random(in: 0...100)
        Constant.notok = Int.random(in: 0...100)
        for view in self.mainView.subviews {
            view.removeFromSuperview()
        }
        let pagingVC = MainController.getInstance()
        self.embed(pagingVC, inView: mainView)
    }

}

extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}

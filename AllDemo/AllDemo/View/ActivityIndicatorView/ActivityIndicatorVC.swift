//
//  ActivityIndicatorVC.swift
//  AllDemo
//
//  Created by NgocNB on 1/26/21.
//

import UIKit

class ActivityIndicatorVC: UIViewController {

    var loadingView = LoadingView()
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView.initilize(viewController: self)
    }
    

    @IBAction func onShowAction(_ sender: Any) {
        loadingView.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.loadingView.stop()
            print("successfully")
        }
    }
}


class LoadingView {
    
    var viewController: UIViewController?
    var alert: UIAlertController!

    func initilize(viewController: UIViewController) {
        self.viewController = viewController
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
    }
    
    func start() {
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func stop() {
        viewController?.dismiss(animated: false, completion: nil)
    }
    
}

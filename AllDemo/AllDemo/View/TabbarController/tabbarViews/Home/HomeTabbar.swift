//
//  HomeTabbar.swift
//  AllDemo
//
//  Created by NgocNB on 12/14/20.
//

import UIKit

class HomeTabbar: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = .orange
    }

}

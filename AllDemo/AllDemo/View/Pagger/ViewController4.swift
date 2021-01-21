//
//  ViewController4.swift
//  AllDemo
//
//  Created by NgocNB on 12/7/20.
//

import UIKit

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemIndigo
        } else {
            // Fallback on earlier versions
        }
    }
    
}

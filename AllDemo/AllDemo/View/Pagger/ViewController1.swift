//
//  ViewController1.swift
//  AllDemo
//
//  Created by NgocNB on 12/7/20.
//

import UIKit

class ViewController1: UIViewController {

    var didSelect: (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .purple
    }


    @IBAction func onAction(_ sender: Any) {
        if let select = didSelect {
            select()
        }
    }
}

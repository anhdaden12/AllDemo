//
//  CaculateLabelWidth.swift
//  AllDemo
//
//  Created by NgocNB on 12/7/20.
//

import UIKit

class CaculateLabelWidth: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var labelWidth: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onLabelAction(_ sender: Any) {
        myLabel.text = "this is a test label"

        var rect: CGRect = myLabel.frame //get frame of label
        rect.size = (myLabel.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))! //Calculate as per label font
        labelWidth.constant = rect.width // set width to Constraint outlet
    }

}

//
//  AlamofireVC.swift
//  AllDemo
//
//  Created by NgocNB on 12/28/20.
//

import UIKit
import Alamofire

class AlamofireVC: UIViewController {

    
    let baseUrl = "http://support.funring.vn/app/contend/notice"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func onRequest(withParam param: [String: String]) {
        let params: Parameters = param
        AF.request(baseUrl, method: .get, parameters: params).responseJSON { (json) in
            print(json)
        }
    }


    @IBAction func onRequest(_ sender: Any) {
        self.onRequest(withParam: ["msisdn": "904862074"])
    }

}

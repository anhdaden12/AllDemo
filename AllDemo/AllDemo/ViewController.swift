//
//  ViewController.swift
//  AllDemo
//
//  Created by NgocNB on 12/7/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ControllerType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.detailTextLabel?.text = "\(indexPath.row + 1)"
        let type: ControllerType = ControllerType.allCases[indexPath.row]
        switch type {
        case .CalculateLabelSize:
            cell.textLabel?.text = "Label width"
        case .PagerView:
            cell.textLabel?.text = "PagerView"
        case .TabbarController:
            cell.textLabel?.text = "TabbarController"
        case .Gesture:
            cell.textLabel?.text = "Gesture"
        case .DebuggingLayout:
            cell.textLabel?.text = "Debugging layout"
        case .DemoAlamofire:
            cell.textLabel?.text = "Alamofire request demo"
        case .PinnedMap:
            cell.textLabel?.text = "Pin location on Map"
        case .SearchLocationMap:
            cell.textLabel?.text = "Search Location on Map"
        case .SelectLocationMap:
            cell.textLabel?.text = "Click to pin location map"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: ControllerType = ControllerType.allCases[indexPath.row]
        switch type {
        case .CalculateLabelSize:
            let vc = CaculateLabelWidth()
            self.navigationController?.pushViewController(vc, animated: true)
        case .PagerView:
            let vc = ContentVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .TabbarController:
            let vc = TabbarContainerVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .Gesture:
            let vc = GestureContainer()
            self.navigationController?.pushViewController(vc, animated: true)
        case .DebuggingLayout:
            let vc = BuggingLayoutVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .DemoAlamofire:
            let vc = AlamofireVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .PinnedMap:
            let vc = PinlocationMapVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .SearchLocationMap:
            let vc = SearchLocationVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .SelectLocationMap:
            let vc = SelectlocationVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


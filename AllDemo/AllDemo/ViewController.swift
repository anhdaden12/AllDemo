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
        case .WebViewDemo:
            cell.textLabel?.text = "Web View demo"
        case .ActivityIndicatorVC:
            cell.textLabel?.text = "Activityindicator View"
        case .TextToSpeech:
            cell.textLabel?.text = "text to speech"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: ControllerType = ControllerType.allCases[indexPath.row]
        var vc = UIViewController()
        switch type {
        case .CalculateLabelSize:
            vc = CaculateLabelWidth()
        case .PagerView:
            vc = ContentVC()
        case .TabbarController:
            vc = TabbarContainerVC()
        case .Gesture:
            vc = GestureContainer()
        case .DebuggingLayout:
            vc = BuggingLayoutVC()
        case .DemoAlamofire:
            vc = AlamofireVC()
        case .PinnedMap:
            vc = PinlocationMapVC()
        case .SearchLocationMap:
            vc = SearchLocationVC()
        case .SelectLocationMap:
            vc = SelectlocationVC()
        case .WebViewDemo:
            vc = WebViewDemoVC()
        case .ActivityIndicatorVC:
            vc = ActivityIndicatorVC()
        case .TextToSpeech:
            vc = TextTospeechVC()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


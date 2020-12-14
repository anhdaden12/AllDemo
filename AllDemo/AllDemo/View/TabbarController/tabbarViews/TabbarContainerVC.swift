//
//  TabbarContainerVC.swift
//  AllDemo
//
//  Created by NgocNB on 12/14/20.
//

import UIKit

class TabbarContainerVC: UITabBarController {

    var home = HomeTabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupTabbar()
    }
    
    func setupTabbar() {
        
        self.tabBar.tintColor = UIColor.red
        
        let homeNav = UINavigationController(rootViewController: home)
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        home.tabBarItem.badgeColor = .blue
        home.tabBarItem.badgeValue = "99+"
        
        let market = MarketVC()
        let marketNav = UINavigationController(rootViewController: market)
        market.tabBarItem = UITabBarItem(title: "Market", image: UIImage(named: "market"), tag: 1)
        
        let bitcoin = BitCoinVC()
        let bitcoinNav = UINavigationController(rootViewController: bitcoin)
        bitcoin.tabBarItem = UITabBarItem(title: "Bitcoin", image: UIImage(named: "bitcoin"), tag: 2)
        
        let profile = profileTabbarVC()
        let profileNav = UINavigationController(rootViewController: profile)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        self.viewControllers = [homeNav,bitcoinNav,marketNav,profileNav]
    }
    
    // note: you need set tabBar items as global item becau se you will need to chage it's badge value or Something else
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        home.tabBarItem.badgeValue = "\(Int.random(in: 1...100))"
    }

}

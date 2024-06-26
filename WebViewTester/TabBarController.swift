import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        initialViewController.tabBarItem = UITabBarItem(title: "Tab 1", image: nil, selectedImage: nil)
        
        viewControllers = [initialViewController]
    }
}

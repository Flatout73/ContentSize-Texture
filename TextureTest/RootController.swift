import UIKit

class RootController: UIViewController {
    
    let button = UIButton(frame: CGRect(x: 20, y: 200, width: 200, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("CollectionNode", for: .normal)
        button.addTarget(self, action: #selector(open), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        
        self.view.backgroundColor = .white
        self.view.addSubview(button)
    }
    
    @objc func open() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
}

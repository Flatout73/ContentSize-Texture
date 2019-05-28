import AsyncDisplayKit

class ViewController: ASViewController<MainNode> {
    
    var kekes = ["kek1", "kek2", "kek3"]

    init() {
        super.init(node: MainNode())
        
        self.view.backgroundColor = .white
        self.node.collectionNode.backgroundColor = .green
        self.node.collectionNode.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.node.collectionNode.onDidFinishProcessingUpdates {
            print(self.node.collectionNode.view.contentSize)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.node.collectionNode.view.contentSize)
    }
    
    @objc func add() {
        kekes.append("kek4")
        
        self.node.collectionNode.reloadData()
        self.node.collectionNode.onDidFinishProcessingUpdates {
            print("finish")
        }
    }
    
}

extension ViewController: ASCollectionDataSource {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return kekes.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return CellNode()
    }
}

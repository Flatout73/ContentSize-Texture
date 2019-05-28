import AsyncDisplayKit

class MainNode: ASDisplayNode {
    
    public let collectionNode: ASCollectionNode
    

    override init() {
        let layout = CollectionViewFloatingLayout()
        layout.cellPadding = 1
        collectionNode = ASCollectionNode(collectionViewLayout: layout)
        layout.collectionNode = collectionNode
        super.init()
        automaticallyManagesSubnodes = true
        

        collectionNode.alwaysBounceVertical = true
        collectionNode.backgroundColor = UIColor.clear
        collectionNode.clipsToBounds = false
        
        
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    override func didLoad() {
        super.didLoad()
        
        collectionNode.view.bounces = true
        collectionNode.view.showsVerticalScrollIndicator = false
        collectionNode.view.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASCenterLayoutSpec(horizontalPosition: .center, verticalPosition: .start, sizingOption: [], child: collectionNode)
    }
}

import UIKit
import AsyncDisplayKit

public protocol CollectionViewFloatingLayoutDelegate {
    func collectionNode(collectionNode: ASCollectionNode, heightItemAt indexPath: IndexPath) -> CGFloat
}

open class CollectionViewFloatingLayout: UICollectionViewLayout {
    open var delegate: CollectionViewFloatingLayoutDelegate? {
        return (self.collectionView as? ASCollectionView)?.collectionNode?.delegate as? CollectionViewFloatingLayoutDelegate
    }
    open var numberOfColumns: Int {
        return collectionView!.traitCollection.horizontalSizeClass == .regular && collectionView!.bounds.width > 700 ? 2 : 1
    }
    open var cellPadding: CGFloat = 6.0
    
    private var attributes : [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    public var columnWidth: CGFloat {
        return contentWidth / CGFloat(numberOfColumns)
    }
    
    public var collectionNode: ASCollectionNode?
    
    override open func prepare() {
        super.prepare()
        guard let collectionNode = collectionNode else { return }
        guard collectionNode.numberOfSections > 0 else { return }
        
        attributes.removeAll(keepingCapacity: false)
        var xOffset = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        contentHeight = 0
        for item in 0..<collectionNode.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let itemHeight = delegate?.collectionNode(collectionNode: collectionNode, heightItemAt: indexPath) ?? 40
            let height = cellPadding + itemHeight + cellPadding
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            attribute.frame = insetFrame
            attributes.append(attribute)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            if column < (numberOfColumns - 1), yOffset[column] > collectionNode.frame.height/2.0 {
                column += 1
            }
        }
    }
    
    open override func invalidateLayout() {
        super.invalidateLayout()
    }
    
    
    open override func prepare(forAnimatedBoundsChange oldBounds: CGRect) {
        super.prepare(forAnimatedBoundsChange: oldBounds)
    }
    
    open override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[indexPath.row]
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard collectionView?.numberOfSections ?? 0 > 0 else { return nil }
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in attributes {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let cv = collectionView else { return false }
        
        return !newBounds.size.equalTo(cv.bounds.size)
    }
}



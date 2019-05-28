//
//  CellNode.swift
//  TextureTest
//
//  Created by Леонид Лядвейкин on 28/05/2019.
//  Copyright © 2019 Леонид Лядвейкин. All rights reserved.
//

import AsyncDisplayKit

class CellNode: ASCellNode {
    
    let textNode = ASTextNode()
    
    override init() {
        super.init()
        
        textNode.attributedText = NSAttributedString(string: "kek")
        automaticallyManagesSubnodes = true
        
        self.backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: textNode)
        
    }
}

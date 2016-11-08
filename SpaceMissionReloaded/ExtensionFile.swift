//
//  ExtensionFile.swift
//  SpaceMissionReloaded
//
//  Created by Yannick Klose on 25.10.16.
//  Copyright © 2016 Yannick Klose. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    // SKLabelNode extension to allow multilined text
    
    public func multilined() -> SKLabelNode {
        let substrings: [String] = self.text!.components(separatedBy: "\n")
        return substrings.enumerated().reduce(SKLabelNode()) {
            let label = SKLabelNode(fontNamed: self.fontName)
            label.text = $1.element
            label.fontColor = self.fontColor
            label.fontSize = self.fontSize
            label.position = self.position
            label.horizontalAlignmentMode = self.horizontalAlignmentMode
            label.verticalAlignmentMode = self.verticalAlignmentMode
            let y = CGFloat($1.offset - substrings.count / 2) * 64
            label.position = CGPoint(x: 0, y: -y)
            $0.addChild(label)
            return $0
        }
    }
}

//
//  LeftView.swift
//  VRPlayground
//
//  Created by Sujan Vaidya on 6/24/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit
import SceneKit

class LeftView: SCNView {

    var cameraNode: SCNNode {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0.5, y: 0, z: 5)
        return cameraNode
    }
    
    override init(frame: CGRect, options: [String : AnyObject]?) {
        super.init(frame: frame, options: nil)
        
//        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

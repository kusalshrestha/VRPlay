import Foundation
import SceneKit

extension SCNNode {

    var boundingBox: (min: SCNVector3, max: SCNVector3) {
        var min = SCNVector3(0, 0, 0)
        var max = SCNVector3(0, 0, 0)
        getBoundingBoxMin(&min, max: &max)
        return (min, max)
    }

    func getCenterOfNode() -> SCNVector3 {
        return (self.boundingBox.max + self.boundingBox.min) / 2
    }

    class func generateTextNode(textString text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 0)
//        textGeometry.font = UIFont.systemFontOfSize(4)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.whiteColor()
        return SCNNode(geometry: textGeometry).flattenedClone()
    }

    class func animateWithDuration(duration: NSTimeInterval, animation: () -> Void, completion: (() -> Void)?) {
        SCNTransaction.begin()
        SCNTransaction.setAnimationDuration(duration)
        SCNTransaction.setCompletionBlock(completion)
        animation()
        SCNTransaction.commit()
    }

    class func clearNodes(nodes: SCNNode?...) {
        for var node in nodes {
            if node != nil {
                node!.removeFromParentNode()
                node = nil
            }
        }
    }

    class func removeNodesFromParentInArray(nodes: [SCNNode]) {
        for node in nodes {
            node.removeFromParentNode()
        }
    }

}

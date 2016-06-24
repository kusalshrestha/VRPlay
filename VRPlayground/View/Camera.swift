import Foundation
import SceneKit

class Camera {
    
    var pitch: SCNNode?
    var roll: SCNNode?
    var yaw: SCNNode?
    var cameraNode: SCNNode?
    
    var leftCameraNode: SCNNode!
    var rightCameraNode: SCNNode!

    func setUpCamera() {
        // Create cameras
        let camX = 0.0 as Float
        let camY = 0.0 as Float
        let camZ = 0.0 as Float
        let zFar = 30.0
        
        let leftCamera = SCNCamera()
        let rightCamera = SCNCamera()
        
        leftCamera.zFar = zFar
        rightCamera.zFar = zFar
        
        leftCameraNode = SCNNode()
        leftCameraNode.camera = leftCamera
        leftCameraNode.position = SCNVector3(x: camX - 0.000, y: camY, z: camZ)
        
        rightCameraNode = SCNNode()
        rightCameraNode.camera = rightCamera
        rightCameraNode.position = SCNVector3(x: camX + 0.000, y: camY, z: camZ)
        
        cameraNode = SCNNode()
        cameraNode!.position = SCNVector3(x: camX, y:camY, z:camZ)
        cameraNode!.addChildNode(leftCameraNode)
        cameraNode!.addChildNode(rightCameraNode)
        
        let camerasNodeAngles = getCamerasNodeAngle()
        cameraNode!.eulerAngles = SCNVector3Make(Float(camerasNodeAngles[0]), Float(camerasNodeAngles[1]), Float(camerasNodeAngles[2]))
        
        roll = SCNNode()
        roll!.addChildNode(cameraNode!)
        
        pitch = SCNNode()
        pitch!.addChildNode(roll!)
        
        yaw = SCNNode()
        yaw!.addChildNode(pitch!)
    }
    
    func getCamerasNodeAngle() -> [Double] {
        var camerasNodeAngle1: Double! = 0.0
        var camerasNodeAngle2: Double! = 0.0
        let orientation = UIApplication.sharedApplication().statusBarOrientation.rawValue
        if orientation == 1 {
            camerasNodeAngle1 = -M_PI_2
        } else if orientation == 2 {
            camerasNodeAngle1 = M_PI_2
        } else if orientation == 3 {
            camerasNodeAngle1 = 0.0
            camerasNodeAngle2 = M_PI
        }
        
        return [ -M_PI_2, camerasNodeAngle1, camerasNodeAngle2 ]
    }
    
}

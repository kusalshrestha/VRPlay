import UIKit
import SceneKit
import CoreMotion
import AVFoundation
import Foundation
//import Darwin
import CoreGraphics

//MARK: View Controller
class MenuViewController: UIViewController, SCNSceneRendererDelegate {
    
    @IBOutlet weak var leftSceneView: SCNView!
    @IBOutlet weak var rightSceneView: SCNView!
    
    var scene : SCNScene?
    
    var camerasNode : SCNNode?
    var cameraRollNode : SCNNode?
    var cameraPitchNode : SCNNode?
    var cameraYawNode : SCNNode?
    
    var motionManager : CMMotionManager?
    
    var viewfinderNode1 : SCNNode?
    var viewfinderNode2 : SCNNode?
    var viewfinderNode3 : SCNNode?
    
    var selectedNode : SCNNode?
    
    let viewFinder = ViewFinder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //In viewDidLoad we initialize the 3D Space and Cameras
        
        // Create Scene
        scene = SCNScene(named: "Scene.scn")
        leftSceneView?.scene = scene
        rightSceneView?.scene = scene
        
        // Create cameras
        let camX = 0.0 as Float
        let camY = 0.0 as Float
        let camZ = 0.0 as Float
        let zFar = 30.0
        
        let leftCamera = SCNCamera()
        let rightCamera = SCNCamera()
        
        leftCamera.zFar = zFar
        rightCamera.zFar = zFar
        
        let leftCameraNode = SCNNode()
        leftCameraNode.camera = leftCamera
        leftCameraNode.position = SCNVector3(x: camX - 0.000, y: camY, z: camZ)
        
        let rightCameraNode = SCNNode()
        rightCameraNode.camera = rightCamera
        rightCameraNode.position = SCNVector3(x: camX + 0.000, y: camY, z: camZ)
        
        camerasNode = SCNNode()
        camerasNode!.position = SCNVector3(x: camX, y:camY, z:camZ)
        camerasNode!.addChildNode(leftCameraNode)
        camerasNode!.addChildNode(rightCameraNode)
        
        let camerasNodeAngles = getCamerasNodeAngle()
        camerasNode!.eulerAngles = SCNVector3Make(Float(camerasNodeAngles[0]), Float(camerasNodeAngles[1]), Float(camerasNodeAngles[2]))
        
        cameraRollNode = SCNNode()
        cameraRollNode!.addChildNode(camerasNode!)
        
        cameraPitchNode = SCNNode()
        cameraPitchNode!.addChildNode(cameraRollNode!)
        
        cameraYawNode = SCNNode()
        cameraYawNode!.addChildNode(cameraPitchNode!)
        
        scene!.rootNode.addChildNode(cameraYawNode!)
        
        leftSceneView?.pointOfView = leftCameraNode
        rightSceneView?.pointOfView = rightCameraNode
        
        // Respond to user head movement. Refreshes the position of the camera 60 times per second.
        motionManager = CMMotionManager()
        motionManager?.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager?.startDeviceMotionUpdatesUsingReferenceFrame(CMAttitudeReferenceFrame.XArbitraryZVertical)
        
        leftSceneView?.delegate = self
        
        leftSceneView?.playing = true
        rightSceneView?.playing = true
        
        createviewFinder()
        displayInteractiveNodes()
        
        scene?.background.contents = [UIImage(named: "skybox1.png") as UIImage!]
    }
    
    //MARK: Viewfinder, used to aim and select, methods
    
    func createviewFinder() {
        viewFinder.createviewFinder()
        
        viewfinderNode1 = viewFinder.viewfinderNode1
        viewfinderNode2 = viewFinder.viewfinderNode2
        viewfinderNode3 = viewFinder.viewfinderNode3
        
        self.camerasNode!.addChildNode(self.viewfinderNode1!)
        self.camerasNode!.addChildNode(self.viewfinderNode2!)
        self.camerasNode!.addChildNode(self.viewfinderNode3!)

    }
    
    //MARK: Do some stuff
    
    func launchSomeAction(nodeToUpdate: SCNNode){
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        switch nodeToUpdate.name! {
            case "Learn" :
                let learnVC = sb.instantiateViewControllerWithIdentifier("learnVC")
                self.presentViewController(learnVC, animated: true, completion: nil)
            case "Play" :
                let playVC = sb.instantiateViewControllerWithIdentifier("playVC")
                self.presentViewController(playVC, animated: true, completion: nil)
            default :
                break
        }
        
    }
    
//    var dog: SCNNode?
    
    var boxNode1: SCNNode?
    var boxNode2: SCNNode?
    
    //MARK: Interactive Nodes
    func displayInteractiveNodes(){
        
        //first node
//        let animal = SCNScene(named: Assets.Animal.dog)
//        dog = animal?.rootNode.childNodeWithName("SketchUp", recursively: false)
//        dog?.position = SCNVector3(x: 0, y: 2, z: -5)
        
//        var v1 = SCNVector3Zero
//        var v2 = SCNVector3Zero
//        dog?.getBoundingBoxMin(&v1, max: &v2)
//        print(v1, v2)

//        scene?.rootNode.addChildNode(dog!)
        
        let boxGeometry1 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let boxMaterial1 = SCNMaterial()
        boxMaterial1.diffuse.contents = UIColor.greenColor()
        boxGeometry1.materials = [boxMaterial1]
        boxNode1 = SCNNode(geometry: boxGeometry1)
        boxNode1?.name = "Learn"
        boxNode1?.position = SCNVector3(x:-2, y: 2, z: -3)
        scene?.rootNode.addChildNode(boxNode1!)
        
        let boxGeometry2 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let boxMaterial2 = SCNMaterial()
        boxMaterial2.diffuse.contents = UIColor.purpleColor()
        boxGeometry2.materials = [boxMaterial2]
        boxNode2 = SCNNode(geometry: boxGeometry2)
        boxNode2?.name = "Play"
        boxNode2?.position = SCNVector3(x: 2, y: 2, z: -3)
        scene?.rootNode.addChildNode(boxNode2!)
    }
    
    //MARK: Scene Renderer
    func renderer(aRenderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval){
        
        // Render the scene
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let mm = self.motionManager, let motion = mm.deviceMotion {
                let currentAttitude = motion.attitude
                
                var roll : Double = currentAttitude.roll
                if(UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.LandscapeRight){ roll = -1.0 * (-M_PI - roll)}
                
                self.cameraRollNode!.eulerAngles.x = Float(roll)
                self.cameraPitchNode!.eulerAngles.z = Float(currentAttitude.pitch)
                self.cameraYawNode!.eulerAngles.y = Float(currentAttitude.yaw)
                
                //Checks if the user looks at an interactive node
                let pFrom = self.camerasNode!.convertPosition(self.viewfinderNode2!.position, toNode: self.scene?.rootNode)
                let pTo = self.camerasNode!.convertPosition(self.viewfinderNode3!.position, toNode: self.scene?.rootNode)
                
                let hitNodes = self.scene?.rootNode.hitTestWithSegmentFromPoint(pFrom, toPoint: pTo, options:nil)
                var hitNode: SCNNode?
                for hn in hitNodes! {
                    if let _ = hn.node.name {
                        if hn.node.name! == "Learn" || hn.node.name! == "Play" {
                            hitNode = hn.node
                            break
                        }
                    }
                }
                
                if (hitNode != nil) {
                    if let sNode = hitNode {
                        self.selectedNode = sNode
                        self.viewFinder.updateViewFinder(true)
                        self.launchSomeAction(self.selectedNode!)
                    }
                } else {
                    self.selectedNode = nil
                    self.viewFinder.updateViewFinder(false)
                }
            }
        }
    }
    
    //MARK: Camera Orientation methods
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        let camerasNodeAngles = getCamerasNodeAngle()
        camerasNode!.eulerAngles = SCNVector3Make(Float(camerasNodeAngles[0]), Float(camerasNodeAngles[1]), Float(camerasNodeAngles[2]))
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
    
    //MARK: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
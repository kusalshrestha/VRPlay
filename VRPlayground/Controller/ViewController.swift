import UIKit
import SceneKit
import CoreMotion

class ViewController: UIViewController {

    let leftView = LeftView(frame: CGRectZero, options: nil)
    let rightView = RightView(frame: CGRectZero, options: nil)
    
    var scene = SCNScene()
    let motionManager = CMMotionManager()
    var leftCamera = SCNNode()
    var rightCamera = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(leftView)
        self.view.addSubview(rightView)

        sceneSetUp(scene)
        setupFloor()
        setupBox()
        setupMotion()
    }
    
    func setupBox() {
        let boxGeometry = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = [UIColor.redColor()]
        boxGeometry.materials = [material]
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
    }
    
    func sceneSetUp(scene: SCNScene) {
        leftView.scene = scene
        rightView.scene = scene
        
        leftCamera = leftView.cameraNode
        rightCamera = rightView.cameraNode
        
        scene.rootNode.addChildNode(leftCamera)
        scene.rootNode.addChildNode(rightCamera)
    }
    
    func setupFloor() {
        let groundNode = SCNNode()
        let ground = SCNFloor()
        
        let groundMaterial = SCNMaterial()
        groundMaterial.diffuse.contents = UIColor.brownColor()
        
        ground.reflectivity = 0.05
        ground.materials = [groundMaterial]
        groundNode.geometry = ground
        groundNode.position = SCNVector3(x: 0, y: -1, z: 0)
        scene.rootNode.addChildNode(groundNode)
    }
    
    func setupMotion() {
        // time for motion update
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        if motionManager.deviceMotionAvailable {
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (devMotion, error) -> Void in
                //change the left camera node euler angle in x, y, z axis
                self.leftCamera.eulerAngles = SCNVector3(
                    -Float((self.motionManager.deviceMotion?.attitude.roll)!) - Float(M_PI_2),
                    Float((self.motionManager.deviceMotion?.attitude.yaw)!),
                    -Float((self.motionManager.deviceMotion?.attitude.pitch)!)
                )
                //change the right camera node euler angle in x, y, z axis
                self.rightCamera.eulerAngles = SCNVector3(
                    -Float((self.motionManager.deviceMotion?.attitude.roll)!) - Float(M_PI_2),
                    Float((self.motionManager.deviceMotion?.attitude.yaw)!),
                    -Float((self.motionManager.deviceMotion?.attitude.pitch)!)
                )
                
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = self.view.frame.width / 2.0
        let height = self.view.frame.height
        let leftViewFrame = CGRect(origin: CGPointZero, size: CGSize(width: width, height: height))
        let rightViewFrame = CGRect(x: width, y: 0, width: width, height: height)
        leftView.frame = leftViewFrame
        rightView.frame = rightViewFrame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}


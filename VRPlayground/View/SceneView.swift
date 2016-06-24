import UIKit
import SceneKit

class SceneView: SCNView {
    var scnScene = SCNScene()
    var cameraNode = SCNNode()
    var originalCameraPosition: SCNVector3 {
        return SCNVector3(30, 50, 200)
    }
    var sphereNode: SCNNode!
    var dummyModel: SCNNode? = nil {
        didSet {
            dummyModel?.position = SCNVector3(0, 0, 0)
            scnScene.rootNode.addChildNode(dummyModel!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setUpEnvironment()
    }

    private func setUpEnvironment() -> Void {
        self.scene = scnScene
        scnScene.background.contents = [Scene.EnvironmentTexture.Side, Scene.EnvironmentTexture.Side, Scene.EnvironmentTexture.Top, Scene.EnvironmentTexture.Bottom, Scene.EnvironmentTexture.Side, Scene.EnvironmentTexture.Side]
        setUpCamera()
        setUpAxis()
        insertPersonNode()
    }

    func insertPersonNode() {
        let perSonScene = SCNScene(named: Assets.SceneAssets.Person)
        self.dummyModel = perSonScene?.rootNode.childNodeWithName(Strings.SCN.DummyRootName, recursively: false)
    }

    func setUpCamera() -> Void {
        let camera = SCNCamera()
        camera.zFar = 150000000
        camera.zNear = 10
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = originalCameraPosition

        // Speherical Camera Path
        let sphere = SCNSphere(radius: 10000)
        sphereNode = SCNNode(geometry: sphere)
        sphereNode.geometry?.firstMaterial?.transparency = 0
        scnScene.rootNode.addChildNode(sphereNode)
        sphereNode.eulerAngles.x = -0.158673272
        sphereNode.eulerAngles.y = -0.384478927
        sphereNode.addChildNode(cameraNode)
    }

    func setUpAxis() -> Void {
        let axisObject = AxisLine(lineWidth: 1000000)
        let axis = axisObject.createAxes()
        scnScene.rootNode.addChildNode(axis)
    }
}

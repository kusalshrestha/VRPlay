import UIKit
import SceneKit

class ViewController: UIViewController {

    let leftView = LeftView(frame: CGRectZero, options: nil)
    let rightView = RightView(frame: CGRectZero, options: nil)
    
    var scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(leftView)
        view.addSubview(rightView)
        print("view did load")
        sceneSetUp(scene)
    }
    
    func sceneSetUp(scene: SCNScene) {
        leftView.scene = scene
        rightView.scene = scene
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


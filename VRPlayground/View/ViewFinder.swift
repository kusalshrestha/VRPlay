import Foundation
import SceneKit

class ViewFinder {

    var viewfinderNode1: SCNNode!
    var viewfinderNode2: SCNNode!
    var viewfinderNode3: SCNNode!
    var loadingRadius: Float! = 0.03

    
    func createviewFinder() {
        // Create the viewFinder Nodes
        let viewFinder1 = SCNCylinder(radius:CGFloat(loadingRadius), height:0.0001)
        viewfinderNode1 = SCNNode(geometry: viewFinder1)
        viewfinderNode1.position = SCNVector3(x: 0, y: 0, z:-1.9)
        viewfinderNode1.pivot = SCNMatrix4MakeRotation(Float(M_PI) / 2, 1.0, 0.0, 0.0)
    //    self.camerasNode!.addChildNode(self.viewfinderNode1!)
        
        let viewFinder2 = SCNCylinder(radius: 0.1, height:0.0001)
        viewfinderNode2 = SCNNode(geometry: viewFinder2)
        viewfinderNode2.position = SCNVector3(x: 0, y: 0, z:-2)
        viewfinderNode2.pivot = SCNMatrix4MakeRotation(Float(M_PI) / 2, 1.0, 0.0, 0.0)
    //    self.camerasNode!.addChildNode(self.viewfinderNode2!)
        
        let viewFinder3 = SCNCylinder(radius: 0.1, height:0.0001)
        viewfinderNode3 = SCNNode(geometry: viewFinder3)
        viewfinderNode3.position = SCNVector3(x: 0, y: 0, z:-1000)
        viewfinderNode3.pivot = SCNMatrix4MakeRotation(Float(M_PI) / 2, 1.0, 0.0, 0.0)
    //    self.camerasNode!.addChildNode(self.viewfinderNode3!)
        
        let material1 = SCNMaterial()
        material1.diffuse.contents = UIColor(red: 42/255.0, green: 128/255.0, blue: 185/255.0, alpha: 0.7)
        material1.specular.contents = UIColor(red: 42/255.0, green: 128/255.0, blue: 185/255.0, alpha: 0.7)
        material1.shininess = 1.0
        
        let material2 = SCNMaterial()
        material2.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
        material2.specular.contents = UIColor(white: 1.0, alpha: 0.5)
        material2.shininess = 1.0
        
        let material3 = SCNMaterial()
        material3.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        material3.specular.contents = UIColor(white: 1.0, alpha: 0.0)
        material3.shininess = 0.0
        
        viewFinder1.materials = [ material1 ]
        viewFinder2.materials = [ material2 ]
        viewFinder3.materials = [ material3 ]
    }


    func updateViewFinder(isLoading: Bool, completion: (() -> ())) {
        
        // Update the viewFinder Nodes
        if isLoading {
            self.viewfinderNode2!.hidden = false
            self.loadingRadius = self.loadingRadius + 0.0005
            self.viewfinderNode1!.geometry?.setValue(CGFloat(self.loadingRadius!), forKey: "radius")
            self.viewfinderNode1!.geometry?.firstMaterial!.diffuse.contents = UIColor(red: 42/255.0, green: 128/255.0, blue: 185/255.0, alpha: 1)
            if self.loadingRadius > 0.1 {
                self.loadingRadius = 0.03
                completion()
            }
        } else {
            self.viewfinderNode2?.hidden = true
            self.loadingRadius = 0.03
            self.viewfinderNode1!.geometry?.setValue(CGFloat(self.loadingRadius!), forKey: "radius")
            self.viewfinderNode1!.geometry?.firstMaterial!.diffuse.contents = UIColor(red: 42/255.0, green: 128/255.0, blue: 185/255.0, alpha: 0.7)
            completion()
        }
    }

}



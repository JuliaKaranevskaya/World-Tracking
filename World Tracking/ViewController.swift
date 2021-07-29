//
//  ViewController.swift
//  World Tracking
//
//  Created by Юлия Караневская on 29.07.21.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    let sceneView: ARSCNView = {
        let view = ARSCNView()
        return view
    }()
    
    let configuration = ARWorldTrackingConfiguration()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sceneView)
        view.addSubview(addButton)
        view.addSubview(resetButton)
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.frame = view.bounds
        addButtonConstraints()
        resetButtonConstraints()
    }
    
    @objc private func addAction() {
        let node = SCNNode()
        //node.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.2, height: 0.2)
        //node.geometry = SCNSphere(radius: 0.1)
        //node.geometry = SCNCone(topRadius: 0, bottomRadius: 0.2, height: 0.2)
        //node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        //node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        node.geometry = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(0, 0, -0.3)
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc private func resetAction() {
        restartSession()
        sceneView.scene.rootNode.enumerateChildNodes { node, _ in
            node.removeFromParentNode()
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private func restartSession() {
       sceneView.session.pause()
    }
    
    private func addButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func resetButtonConstraints() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }


}


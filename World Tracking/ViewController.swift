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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sceneView)
        self.sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        self.sceneView.session.run(configuration)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.frame = view.bounds
    }


}


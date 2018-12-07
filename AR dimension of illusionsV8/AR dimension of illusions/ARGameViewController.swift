//
//  ARGameViewController.swift
//  AR dimension of illusions
//
//  Created by iMac 3 on 12/4/18.
//  Copyright © 2018 New X. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import AVFoundation

class ARGameViewController: UIViewController , ARSCNViewDelegate {
    
    @IBOutlet weak var cartel: UILabel!
    @IBOutlet weak var visualisazion: ARSCNView!
    var musicaGameOver = try? AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "game over", ofType: "mp3")!))
    
    var musicaJump = try? AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "jump", ofType: "mp3")!))
    
    
    var personajeSelec = 0
    var ropaSelec = 0
    
    let configuracion = ARWorldTrackingConfiguration()
    let scene2 = SCNScene(named: "art.scnassets/level1.scn")! // nivel
    var personaje = SCNScene(named: "art.scnassets/Personajes.scn")!.rootNode.childNodes[0]
    var ropa = SCNScene(named: "art.scnassets/Personajes.scn")!.rootNode.childNodes[3]
    
    
    var z = 0.0
    var x = 0.0
    var y =  0.0
    var distancia =  0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        visualisazion.showsStatistics = true
        //self .visualisazion.debugOptions = [ ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        visualisazion.delegate = self
        
        // Create a new scene
        ropa.position =  SCNVector3(0, 0, 0)
        personaje.addChildNode(ropa)
        personaje.position = SCNVector3(0, 0, 0)
        scene2.rootNode.addChildNode(personaje)
        personaje.scale =  SCNVector3(0.1, 0.1, 0.1)
        // Set the scene to the view
        visualisazion.scene = scene2
        self.visualisazion.session.run(configuracion)
        //view.addSubview(visualisazion!)
    }
    
    @IBAction func arriba(_ sender: UIButton) {
       
        z = z - distancia
        SCNTransaction.animationDuration = 1.0
        personaje.position = SCNVector3(x, y , z )
        gravedad()
    }
    
    @IBAction func abajo(_ sender: UIButton) {
        
        z = z + distancia
        SCNTransaction.animationDuration = 1.0
        personaje.position = SCNVector3(x, y , z )
        gravedad()
    }
    
    @IBAction func derc(_ sender: UIButton) {
       
        x = x + distancia
        SCNTransaction.animationDuration = 1.0
        personaje.position = SCNVector3(x, y , z )
        gravedad()
    }
    
    @IBAction func izq(_ sender: UIButton) {
        
        x = x - distancia
        SCNTransaction.animationDuration = 1.0
        personaje.position = SCNVector3(x, y , z )
        gravedad()
    }
    
    @IBAction func ataque(_ sender: UIButton) { }
    
    @IBAction func salto(_ sender: UIButton) {
        
        y = y + 0.08
        musicaJump?.play()
        SCNTransaction.animationDuration = 1.0
        personaje.position = SCNVector3(x, y, z)
        // delay 0.5 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
                SCNTransaction.animationDuration = 1.0
                if ( self.x >= 0 && self.x < 1.01 && self.z <= 0 && self.z > -1 ){self.y = 0}
                if ( self.x >= 0.49 && self.x < 1.5 && self.z <= -1 && self.z > -1.5){self.y = 0.05}
                if ( self.x >= 1 && self.x < 2 && self.z <= -1.5 && self.z > -2.5){self.y = 0.1}
                self.personaje.position = SCNVector3(self.x, self.y , self.z)
        }
    
        gravedad()
    }
    
    
    func gravedad (){
        
        
        if ( x >= 1.5 && x < 2 && z <= -2 && z > -2.5){
           
            cartel.text = "To win"
            cartel.textColor = UIColor.green
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
             self.navigationController?.popViewController(animated: true)
             self.visualisazion.session.pause()
            }
            return
        }
        
        if ( x >= 0 && x < 1.01 && z <= 0 && z > -1 ){return}
        
        if ( x >= 0.49 && x < 1.5 && z <= -1 && z > -1.5){return}
        
        if ( x >= 1 && x < 2 && z <= -1.5 && z > -2.5){return}
        
       
        y = -0.5
        
        
        SCNTransaction.animationDuration = 0.5
        personaje.position = SCNVector3(x, y , z)
        cartel.text = "To lose"
        cartel.textColor = UIColor.red
        musicaGameOver?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.navigationController?.popViewController(animated: true)
            self.visualisazion.session.pause()
        }
    }
   

}
//self.scene3.rootNode.rotation = SCNVector4(0.0,y*90.0,0.0,y*60)

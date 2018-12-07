//
//  ViewController.swift
//  AR dimension of illusions
//
//  Created by Eduardo Quintero on 03/12/18.
//  Copyright © 2018 New X. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet weak var viewCharacter: SCNView!
    
    
    var peronajesCreados = [Users]()
    var pernajeSelec = 0
    
    
    let scene = SCNScene(named: "art.scnassets/MundoVirtual.scn")!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let data = UserDefaults.standard.value(forKey:"Users") as? Data {
            let temp = try? PropertyListDecoder().decode(Array<Users>.self, from: data)
            print("------------")
            
            peronajesCreados = temp!
            print(peronajesCreados)
            print("------------")
        }
        var num = -0.25
        for item in peronajesCreados {
            
            if(item.charaterType == "Magician"){ pernajeSelec = 0}
            if(item.charaterType ==  "Warrior"){ pernajeSelec = 1}
            if(item.charaterType == "Monster"){  pernajeSelec = 2}
            let personaje = SCNScene(named: "art.scnassets/Personajes.scn")!.rootNode.childNodes[pernajeSelec]
            let clothesSelec = SCNScene(named: "art.scnassets/Personajes.scn")!.rootNode.childNodes[item.appearance]
            personaje.position = SCNVector3(x: 0.0, y: 0.0, z: Float(num))
            clothesSelec.position = SCNVector3(x: 0.0, y: 0.0, z: Float(num))
            personaje.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            clothesSelec.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            scene.rootNode.addChildNode(personaje)
            scene.rootNode.addChildNode(clothesSelec)
            num = num + 0.25
            
        }
    
        
        
        
        
        
        viewCharacter.scene = scene
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNewCharacter"{
            
            let destino = segue.destination as! CreateNewCharactersViewController
            destino.peronajesCreados = peronajesCreados
           
        }
        
        
        
    }
    
    
}


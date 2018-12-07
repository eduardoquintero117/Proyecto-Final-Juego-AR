//
//  CreateNewCharactersViewController.swift
//  AR dimension of illusions
//
//  Created by Eduardo Quintero on 03/12/18.
//  Copyright © 2018 New X. All rights reserved.
//

import UIKit
import SceneKit


class CreateNewCharactersViewController: UIViewController,SCNSceneRendererDelegate , UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var nameCharacter: UITextField!
    @IBOutlet weak var vistaPersonajes: SCNView!
    
    let scene = SCNScene(named: "art.scnassets/MundoVirtual.scn")! // fondo donde estaran los perdonajes
    let objetsVirtual = SCNScene(named: "art.scnassets/Personajes.scn")! //  objetos
    let clothes = SCNScene(named: "art.scnassets/Personajes.scn")!
    
    var cont = 0
    var temp = 0
    var peronajesCreados = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        nameCharacter.delegate = self
        userName.delegate = self

       
        objetsVirtual.rootNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        clothes.rootNode.position = SCNVector3(0.0, Float(-((temp + 1) * 6) + (2 * cont) ), 0.0)
       
        scene.rootNode.addChildNode(objetsVirtual.rootNode)
        scene.rootNode.addChildNode(clothes.rootNode)
        
        vistaPersonajes.scene = scene
        
    }
   
   
    
    @IBAction func types(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        temp = sender.selectedSegmentIndex
        SCNTransaction.animationDuration = 0
        objetsVirtual.rootNode.position = SCNVector3(x: 0.0, y: Float(temp) * -2, z:  0.0 )
        clothes.rootNode.position = SCNVector3(0.0, Float(-((temp + 1) * 6) - (2 * cont) ), 0.0)
        
    }
    
    @IBAction func raid(_ sender: UIButton) {
        if (cont == 2){
            cont = 0
        }else{
            cont = cont + 1
            }
        SCNTransaction.animationDuration = 0
        clothes.rootNode.position = SCNVector3(0.0, Float(-((temp + 1) * 6) - (2 * cont) ), 0.0)
        
    }
    
    
    @IBAction func left(_ sender: UIButton) {
        if (cont == 0){
            cont = 2
        }else{
            cont = cont - 1
        }
        SCNTransaction.animationDuration = 0
        clothes.rootNode.position = SCNVector3(0.0, Float(-((temp + 1) * 6) - (2 * cont) ), 0.0)
        
    }
    
    @IBAction func selec(_ sender: UIButton) {
        guard let nameChar = nameCharacter.text, let nameUs = userName.text else {return}
        if (nameCharacter.text == "" ){
            return
            
        }
        if(userName.text == ""){
            return
        }else{
            print(nameChar)
            var tipo = "Magician"
            if(temp == 0){tipo = "Magician"}
            if(temp == 1){tipo = "Warrior"}
            if(temp == 2){tipo = "Monster"}
            
            let new = Users(name: nameUs, nameCharacter: nameChar, email: "", charaterType: tipo , appearance: (((temp + 1) * 6) + (2 * cont) ) / 2, px: 0.0, py: 0.0, pz: 0.0, puntos: 0.0)
            peronajesCreados.append(new)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(peronajesCreados), forKey:"Users")
           
            
            navigationController?.popViewController(animated: true)
        }
       
        
    }
    
    // se encarga de ocultar el teclado cundo se oprime la tecla intro
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }

}

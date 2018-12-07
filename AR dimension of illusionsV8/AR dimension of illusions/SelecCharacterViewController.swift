//
//  SelecCharacterViewController.swift
//  AR dimension of illusions
//
//  Created by Eduardo Quintero on 06/12/18.
//  Copyright © 2018 New X. All rights reserved.
//

import UIKit
import SceneKit

class SelecCharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabla: UITableView!
    
    var peronajesCreados = [Users]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peronajesCreados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = ("\(peronajesCreados[indexPath.row].nameCharacter)  Type: \(peronajesCreados[indexPath.row].charaterType)")
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabla.delegate = self
        tabla.dataSource = self
       
        if let data = UserDefaults.standard.value(forKey:"Users") as? Data {
            let temp = try? PropertyListDecoder().decode(Array<Users>.self, from: data)
            peronajesCreados = temp!
        }
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //lleva datos ala segunda vista
        if segue.identifier == "ARGame"{
            
           
            let renglonSelecionado = tabla.indexPathForSelectedRow
            var tipoSelc = 0
          // peronajesCreados[0].charaterType
            if(peronajesCreados[(renglonSelecionado?.row)!].charaterType == "Magician"){tipoSelc = 0}
            if(peronajesCreados[(renglonSelecionado?.row)!].charaterType == "Warrior"){ tipoSelc = 1}
            if(peronajesCreados[(renglonSelecionado?.row)!].charaterType == "Monster"){ tipoSelc = 2}
            
            
            let destino = segue.destination as! ARGameViewController
             destino.personaje = SCNScene(named: "art.scnassets/Personajes.scn")!.rootNode.childNodes[tipoSelc]
             destino.ropa = SCNScene(named: "art.scnassets/Personajes.scn")!.rootNode.childNodes[peronajesCreados[(renglonSelecionado?.row)!].appearance]
            print(tipoSelc)
            print(peronajesCreados[(renglonSelecionado?.row)!].appearance)
        }
    }

}

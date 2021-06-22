//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by user201654 on 6/20/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtPuesto: UITextField!
    @IBOutlet weak var txtNombreEliminar: UITextField!
    
    var empleados: [EmpleadoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func agregarAction(_ sender: Any) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let empleado = EmpleadoEntity(context: managedContext)
        
        empleado.nombre = txtNombre.text
        empleado.puesto = txtPuesto.text
        
        appDelegate.saveContext()
        print(empleado)
        
    }
    
    @IBAction func obtenerAction(_ sender: Any) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<EmpleadoEntity> =
            EmpleadoEntity.fetchRequest()
        
        do {
          try empleados = managedContext.fetch(fetchRequest)
            for empleado in empleados {
                print("Nombre: \(empleado.nombre!)\nPuesto:\(empleado.puesto!)\n")
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func eliminarAction(_ sender: Any) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<EmpleadoEntity> =
            EmpleadoEntity.fetchRequest()
        
        do {
          try empleados = managedContext.fetch(fetchRequest)
            for empleado in empleados {
                if(empleado.nombre == txtNombreEliminar.text) {
                    let nombre = empleado.nombre!
                    managedContext.delete(empleado)
                    appDelegate.saveContext()
                    print("Se elimino el empleado \(nombre)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
}


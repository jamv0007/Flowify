//
//  ViewController.swift
//  Flowify
//
//  Created by Jose Antonio on 21/10/23.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var pickerBarButton: UIBarButtonItem!
    
    var imageToProcess: CIImage?//Imagen escogida para procesar
    let pickerController = UIImagePickerController()//Picker de la imagen
    var manager = WikiDataManager()//Manager de los datos obtenidos
    var data: WikiDataAccess? //Datos para enviarlos a la otra vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectImage.layer.cornerRadius = 10.0
        selectImage.clipsToBounds = true
        //Se delega al manager para que notifique
        manager.delegate = self
        //Instancian los estilos de los elementos
        changeIconColor()
        buttonOutlet.changeFormat()
        
        changeDefaultImageTheme()
        //Se delega el photo picker
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = false
    }
    
    //MARK: - Controlador del imagepicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selectImage.image = userImage
            
            //Imagen para ser procesada
            guard let ciimage = CIImage(image: userImage) else {
                fatalError("No se puede convertir a CIImage")
            }
            
            imageToProcess = ciimage
        }
        
        pickerController.dismiss(animated: true)
    }
    
    //MARK: - Procesamiento de la imágen
    func detect(ciImage: CIImage){
        //Se crea el MLModel
        guard let core = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("No se ha podido crear el VNCore del modelo")
        }
        
        //Se crea un request
        let request = VNCoreMLRequest(model: core){ (vnRequest,error) in
            guard let results = vnRequest.results?.first as? VNClassificationObservation else {
                fatalError("Error al procesar la imagen")
            }
            
            
            self.manager.requestInfo(flowerName: results.identifier)
            
        }
        
        //handler
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        do{
            try handler.perform([request])
        }catch{
            print("Error en el handler: \(error)")
        }
    }

    //MARK: - Botones de la vista
    @IBAction func searchButton(_ sender: UIButton) {
        if let pi = imageToProcess{
            detect(ciImage: pi)
        }
    }
    
    @IBAction func imagePicker(_ sender: UIBarButtonItem) {
        present(pickerController,animated: true)
    }
    
    //MARK: - Al cambiar de modo claro a oscuro o al reves
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
            
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            changeIconColor()
        }
        
        changeDefaultImageTheme()
            
    }
    
    private func changeDefaultImageTheme(){
        if imageToProcess == nil {
            (traitCollection.userInterfaceStyle == .light) ? (selectImage.image = UIImage(named: "Image 2")) : (selectImage.image = UIImage(named: "Image 1"))
        }
    }
    
    func changeIconColor(){
        if traitCollection.userInterfaceStyle == .light {
            pickerBarButton.tintColor = .black
            buttonOutlet.setTitleColor(.black,for: .normal)
            if imageToProcess == nil{
                selectImage.tintColor = .black
            }
        }else{
            pickerBarButton.tintColor = .white
            buttonOutlet.setTitleColor(.white,for: .normal)
            if imageToProcess == nil{
                selectImage.tintColor = .white
            }
        }
    }
    
    //MARK: - Prepare para el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueShowData {
            if let dest = segue.destination as? ShowDataViewController {
                dest.data = self.data
            }
        }
    }
    

    

}

//MARK: - Extension de UIButton
extension UIButton{
    func changeFormat(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Border")?.cgColor
    }
}

//MARK: - Extension del Delegate
extension ViewController: WikiDataDelegate{
    func getDataWiki(_ data: WikiDataAccess) {
        //Nueva ventana con los datos
        self.data = data
        performSegue(withIdentifier: Constants.segueShowData, sender: self)
    }
    
    func getErrorWiki(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: "No se ha podido obtener la información, pruebe de nuevo con otra imágen", preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}





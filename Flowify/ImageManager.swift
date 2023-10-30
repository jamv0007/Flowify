//
//  ImageManager.swift
//  Flowify
//
//  Created by Jose Antonio on 28/10/23.
//

import UIKit
import UniformTypeIdentifiers

open class ImageManager: NSObject {
    
    var fileManager: FileManager
    var documentURL: URL
    var documentPath: String
    
    public override init() {
        self.fileManager = FileManager.default
        self.documentURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.documentPath = documentURL.path()
        
    }
    
    public func saveImage(image: UIImage?, name: String){
        if image != nil {
            let filePath = documentURL.appendingPathComponent("\(name).png", conformingTo: UTType.png)
            if let imageSure = image {
                let pngImage = imageSure.pngData()
                try? pngImage?.write(to: filePath, options: .atomic)
                
            }
        }
    }
    
    public func getImage(name: String) -> UIImage? {
        let filePath = documentURL.appendingPathComponent("\(name).png", conformingTo: UTType.png)
        
        if FileManager.default.fileExists(atPath: filePath.path()){
            if let image = UIImage(contentsOfFile: filePath.path()){
                return image
            }
        }
        
        return nil
    }
    
    public func removeImage(name: String) -> Bool {
        let filePath = documentURL.appendingPathComponent("\(name).png", conformingTo: UTType.png)
        
        if FileManager.default.fileExists(atPath: filePath.path()){
            do{
                try FileManager.default.removeItem(atPath: filePath.path())
                return true
            }catch{
               print("Error al eliminar imagen: \(error)")
            }
        }
        
        return false
    }
    
    public func replaceImage(name: String,image: UIImage?) -> Bool {
        
        if removeImage(name: name) {
            saveImage(image: image, name: name)
            return true
        }
        
        return false
    }
    
}

//
//  ViewController.swift
//  camera1
//
//  Created by Farhan on 12/3/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit
import Vision
import CoreML
class ViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
let imagepicker=UIImagePickerController()
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate=self
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing=true
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userImage=info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageview.image=userImage
        imagepicker.dismiss(animated: true, completion: nil)
        guard let ciImage = CIImage(image: userImage)
        else{
            fatalError("Image Conversion Error..")
        }
        func detect(image:CIImage)
        {
            guard let model=try? VNCoreMLModel(for:Inceptionv3().model) else {
            fatalError("Model Error")
            }
           let request=VNCoreMLRequest(model: model)
           {(request,error) in
            let request=VNCoreMLRequest(model: model)
            { (request,error) in
               guard let results=request.results as? (VNClassificationObservation) else{
                    fatalError("Model Classification Error")
            }
                print(results)
            }
            let handler=VNImageRequestHandler(ciImage: image)
            do{
                try handler.perform([request])}
            catch
            {
                fatalError("")
            }
        }
        }
    }
    @IBAction func mycamera(_ sender: Any) {
        present(imagepicker,animated: true, completion:nil)
}
}

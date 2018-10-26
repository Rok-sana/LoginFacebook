//
//  DetailVC.swift
//  LearnLoginFacebook
//
//  Created by swstation on 8/17/18.
//  Copyright © 2018 swstation. All rights reserved.
//

import UIKit
import FacebookShare
class DetailVC: UIViewController {
   
    var stringURL : String!
    var text: String!
     let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = text
        let url = URL(string: stringURL)
        let data = try? Data(contentsOf: url!)
         imageView.contentMode = .scaleAspectFill
         imagePicker.delegate = self
        
        imageView.image = UIImage(data: data!)
         present(imagePicker, animated: true, completion: nil)
        

    }
  

    

}
extension DetailVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as? UIImage
        imageView.image = chosenImage
        imageView.contentMode = .scaleAspectFill
        let photo = Photo(image: imageView.image!, userGenerated: true)
        let content = PhotoShareContent(photos: [photo])
        do { try ShareDialog.show(from: self, content: content)
            print("Something")
        }
        catch{
            error
        }
        
        
        
        dismiss(animated:true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {self.dismiss(animated: true, completion: nil)
    }
}

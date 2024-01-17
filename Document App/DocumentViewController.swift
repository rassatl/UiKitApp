//
//  DocumentViewController.swift
//  Document App
//
//  Created by Lou RASSAT on 1/17/24.
//

import UIKit

class DocumentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imgName = self.imageName else {
            return
        }
        self.imageView.image = UIImage(named:imgName)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

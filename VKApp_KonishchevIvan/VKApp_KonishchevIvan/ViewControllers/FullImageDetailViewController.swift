//
//  FullImageDetailViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.03.2022.
//

import UIKit

class FullImageDetailViewController: UIViewController {
    var imageFulls: UIImage? = nil
    @IBOutlet weak var imageFull: UIImageView!
    @IBOutlet weak var back: UIButton!
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageFull.image = self.imageFulls
        // Do any additional setup after loading the view.
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

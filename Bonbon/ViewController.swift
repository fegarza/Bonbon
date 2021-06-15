//
//  ViewController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {

    @IBAction func IngresarAction(_ sender: Any) {
        AudioServicesPlaySystemSound(SystemSoundID(1000))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


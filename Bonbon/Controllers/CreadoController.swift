//
//  CreadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox


class CreadoController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func crearRecetaAction(_ sender: Any) {
        //esto hace ruido xd
        AudioServicesPlaySystemSound(SystemSoundID(1000))
    }
}


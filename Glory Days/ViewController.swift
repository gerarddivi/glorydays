//
//  ViewController.swift
//  Glory Days
//
//  Created by Gerard Divi on 2/10/16.
//  Copyright © 2016 Gerard Divi. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Speech

class ViewController: UIViewController {

    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askForPermissions(_ sender: UIButton) {
        self.askForPhotosPermissions()
    }

    func askForPhotosPermissions() {
        PHPhotoLibrary.requestAuthorization { [unowned self](authStatus) in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.askForRecordPermissions()
                } else {
                    self.infoLabel.text = "Nos has denegado el permiso de Fotos. Por favor actívalo en los ajustes de tu dispositivo para continuar"
                }
            }
        }
    }
    
    func askForRecordPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission { [unowned self] (allowed) in
            DispatchQueue.main.async {
                if allowed {
                    self.askForTranscriptionPermissions()
                } else {
                    self.infoLabel.text = "Nos has denegado el permiso de grabación de audio. Por favor actívalo en los ajustes de tu dispositivo para continuar"
                }
            }
        }
    }
    
    func askForTranscriptionPermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] (authStatus) in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.authorizacionCompleted()
                } else {
                    self.infoLabel.text = "Nos has denegado el permiso de transcripción de texto. Por favor actívalo en los ajustes de tu dispositivo para continuar"
                }
            }
        }
    }
    
    func authorizacionCompleted() {
        dismiss(animated: true, completion: nil)
    }
}


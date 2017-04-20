//
//  ViewController.swift
//  Episodes
//
//  Created by TJ Carney on 3/20/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var showTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    
    let store = TVDataStore.sharedInstance
    var isChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTextField.delegate = self
        episodeLabel.isHidden = true
        descriptionLabel.isHidden = true
        loadingIndicator.isHidden = true
        loadingLabel.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        isChanged = true
    }
    
    
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        if !showTextField.hasText {
            let myAlert = UIAlertController(title: "No Text Entered", message: "Please Enter a Show Title", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(myAction)
            self.present(myAlert, animated: true)
        } else if isChanged == true {
            isChanged = false
            episodeLabel.isHidden = true
            descriptionLabel.isHidden = true
            loadingIndicator.isHidden = false
            loadingLabel.isHidden = false
            loadingIndicator.startAnimating()
            if let name = showTextField.text {
                store.episodes.removeAll()
                self.store.createShow(name: name, completion: {
                    if let id = self.store.show?.id {
                        self.store.createEpisodes(id: id, completion: {
                            self.episodeLabel.isHidden = false
                            self.descriptionLabel.isHidden = false
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.isHidden = true
                            self.loadingLabel.isHidden = true
                            self.getRandomEpisode(episodes: self.store.episodes)
                        })
                    }
                })
                
            }
        } else {
            print("GETTING CALLED")
            self.getRandomEpisode(episodes: self.store.episodes)
            
        }
        
    }
    
    func getRandomEpisode(episodes: [Episode])  {
        let index = Int(arc4random_uniform(UInt32(episodes.count)))
        let randomEpisode = episodes[index]
        self.episodeLabel.text = "Season \(randomEpisode.season), Episode \(randomEpisode.episode): \(randomEpisode.name)"
        if randomEpisode.summary == "" {
            self.descriptionLabel.text = "No Description Available"
        } else {
            self.descriptionLabel.text = randomEpisode.summary
        }
        self.episodeLabel.isHidden = false
        self.descriptionLabel.isHidden = false
    }
}


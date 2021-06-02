//
//  ViewController.swift
//  Exam2
//
//  Created by François Brodeur (Étudiant) on 2021-05-27.
//  Copyright © 2021 François Brodeur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AVElvis: ArtistView!
    @IBOutlet weak var AVBeatles: ArtistView!
    @IBOutlet weak var AVFourTops: ArtistView!
    @IBOutlet weak var AVMitchell: ArtistView!
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var progress: UIProgressView!
    
    
    private var game = Game()
    private var lastAnswer :ArtistChoice = .Unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newState), name: Game.newStateNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goodAnswer), name: Game.goodAnswerNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(badAnswer), name: Game.wrongAnswerNotif, object: nil)
        
        game.loadSongs()
        labelScore.text = "\(game.score) / \(game.songsNumber)"
        reset()

    }
    
    @objc func goodAnswer(){
        update()
        switch lastAnswer {
        case .Beatles:
            AVBeatles.setStyle(.correct)
        case .Elvis:
            AVElvis.setStyle(.correct)
        case .Mitchell:
            AVMitchell.setStyle(.correct)
        case .FourTops:
            AVFourTops.setStyle(.correct)
        case .Unknown:
            break
        }
        
    }
    @objc func badAnswer(){
        update()
        switch lastAnswer {
        case .Beatles:
            AVBeatles.setStyle(.incorrect)
        case .Elvis:
            AVElvis.setStyle(.incorrect)
        case .Mitchell:
            AVMitchell.setStyle(.incorrect)
        case .FourTops:
            AVFourTops.setStyle(.incorrect)
        case .Unknown:
            break
        }
    }
    @objc func newState(){
        switch game.state{
        case .GameOver:
            update()
        case .NextSong:
            game.nextSong()
            btnState.setTitle("Waiting for Answer", for: .normal)
            btnState.isEnabled = false
        case .WaitingForAnswer:
            btnState.setTitle("Waiting for Answer", for: .normal)
            btnState.isEnabled = false
        }
            
    }
    private func reset(){
        if game.state == .GameOver {
            progress.progress = 0
            labelScore.text = "\(game.score) / \(game.songsNumber)"
            labelQuestion.text = "Game Over"
            btnState.setTitle("Nouvelle Partie?", for: .normal)
        }else{
        labelQuestion.text = game.currentSong?.title
        AVElvis.setStyle(.standard)
        AVMitchell.setStyle(.standard)
        AVBeatles.setStyle(.standard)
        AVFourTops.setStyle(.standard)
            btnState.setTitle("Waiting for Answer", for: .normal)
                 btnState.isEnabled = false
        }
    }
    
    private func update(){
        AVElvis.monBouton.isEnabled = false
        AVMitchell.monBouton.isEnabled = false
        AVBeatles.monBouton.isEnabled = false
        AVFourTops.monBouton.isEnabled = false
        labelScore.text = "\(game.score) / \(game.songsNumber)"
        progress.progress += (1/8)
    }
    
    @IBAction func repElvis(_ sender: UIButton) {
        lastAnswer = .Elvis
        game.answerCurrentSong(with: .Elvis)
        btnState.setTitle("Next Song", for: .normal)
        btnState.isEnabled = true
    }
    
    @IBAction func repBeatles(_ sender: UIButton) {
        lastAnswer = .Beatles
        game.answerCurrentSong(with: .Beatles)
        btnState.setTitle("Next Song", for: .normal)
        btnState.isEnabled = true
    }
    
    @IBAction func repFourTops(_ sender: UIButton) {
        lastAnswer = .FourTops
        game.answerCurrentSong(with: .FourTops)
        btnState.setTitle("Next Song", for: .normal)
        btnState.isEnabled = true
    }
    
    @IBAction func repMitchell(_ sender: Any) {
        lastAnswer = .Mitchell
        game.answerCurrentSong(with: .Mitchell)
        btnState.setTitle("Next Song", for: .normal)
        btnState.isEnabled = true
    }
    
    
    @IBAction func boutonState(_ sender: Any) {
        if btnState.titleLabel?.text == "Nouvelle Partie?"{
            game.loadSongs()
            labelScore.text = "\(game.score) / \(game.songsNumber)"
        }
        reset()
    }
}


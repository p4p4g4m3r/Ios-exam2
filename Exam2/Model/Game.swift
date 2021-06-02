//
//  Game.swift
//  ExamenI
//
//  Created by Vincent Leduc on 2021-05-26.
//  Copyright © 2021 Prof. All rights reserved.
//

import Foundation

class Game {
    
    enum State : String{
         case WaitingForAnswer, NextSong, GameOver
    }
    
    static let goodAnswerNotif = Notification.Name(rawValue: "GoodAnswer")
    static let wrongAnswerNotif = Notification.Name(rawValue: "WrongAnswer")
    static let newStateNotif = Notification.Name(rawValue: "NewState")
    
    var score = 0
    
    var currentAnswer = ArtistChoice.Unknown;
    
    private var songs = [Song]()
    
    private var currentIndex = 0
    {
        didSet {
            if currentIndex >= 0 && currentIndex < songs.count {
                state = State.WaitingForAnswer
            } else {
                state = .GameOver
            }
        }
    }
    

    var state = State.WaitingForAnswer {
        didSet {
            let notification = Notification(name: Game.newStateNotif, object: self)
            NotificationCenter.default.post(notification)
        }
    }
    
    var currentSong: Song? {
        
        if currentIndex >= 0 && currentIndex < songs.count {
            return songs[currentIndex]
        }
        else {
            return nil
        }
    }

    var songsNumber: Int {
        return songs.count
    }
    
    func loadSongs() {
        score = 0
        songs =
            [Song(title: "Help!", artist:.Beatles),
             Song(title: "And I love her", artist: .Beatles),
             Song(title: "Yesterday", artist: .Beatles),
             Song(title: "Can'thelp falling in love", artist: .Elvis),
             Song(title: "Can'thelp myself", artist: .FourTops),
             Song(title: "Baby I need your loving", artist: .FourTops),
             Song(title: "A case of you", artist: .Mitchell),
             Song(title: "Help me", artist: .Mitchell)
        ]
        songs.shuffle()
        currentIndex = 0

    }
    
    
    func answerCurrentSong(with answer: ArtistChoice) {
        state = .NextSong
        currentAnswer = answer
        if let song = currentSong {
            if song.artist == currentAnswer {
                score += 1
                let notification = Notification(name: Game.goodAnswerNotif, object: self)
                NotificationCenter.default.post(notification)
            }
            else {
                let notification = Notification(name: Game.wrongAnswerNotif, object: self)
                NotificationCenter.default.post(notification)
            }
        }
    }
    
    func nextSong() {
        currentIndex += 1
    }
}

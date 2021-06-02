//
//  ArtistView.swift
//  Exam2
//
//  Created by François Brodeur (Étudiant) on 2021-05-27.
//  Copyright © 2021 François Brodeur. All rights reserved.
//

import Foundation
import UIKit

class ArtistView :UIView{
    @IBOutlet var monBouton :UIButton!
    enum Style {
         case correct, incorrect, standard
     }
    func setStyle(_ style: Style) {
        switch style {
        case .correct:
            monBouton.isEnabled = false
            monBouton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case .incorrect:
            monBouton.isEnabled = false
            monBouton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case .standard:
            monBouton.isEnabled = true
            monBouton.backgroundColor = #colorLiteral(red: 0.7999121547, green: 0.8000505567, blue: 0.799903512, alpha: 1)
        }
    }
}

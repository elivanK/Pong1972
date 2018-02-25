//
//  MenuVC.swift
//  Pong1972
//
//  Created by Elivan Kook on 8/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

enum gameType{
    case easy, medium, hard, player2
    
}

class MenuVC: UIViewController{
    
    @IBOutlet weak var pongImage: UIImageView!
    
    
    @IBAction func Player2(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    @IBAction func Easy(_ sender: UIButton) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: UIButton) {
        moveToGame(game: .medium)
    }
    @IBAction func Hard(_ sender: UIButton) {
        moveToGame(game: .hard)
    }
    
    func moveToGame (game: gameType){
        //Refrence the vc
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game
        //Move/ push to the vc
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}

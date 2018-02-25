//
//  GameScene.swift
//  Pong1972
//
//  Created by Elivan Kook on 8/25/17.
//  Copyright © 2017 Student. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    //Create the object ball
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    //Var for the score
    var score = [Int]()
    //Variables for the lables
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    //Added properties for sound effect
    var ballHitPaddle:SKAudioNode!
    var ballHitWall:SKAudioNode!
    var ballMissed:SKAudioNode!
    
    override func didMove(to view: SKView) {
      
        //Connect the labels to the project
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
       //Connect the objects to the project
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        //Change posiion on the screen, get half and add or subtract 50
        enemy.position.y = (self.frame.height / 2) - 50
        main.position.y = (-self.frame.height / 2) + 50
        //Set the speed/ impulse movment of the ball to a 45 angel via delta x,y
        //ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy:10))
        //Add border to the Scene
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        //To set the ball to bounce off the wall
        border.restitution = 1
        self.physicsBody = border
        
        startGame()
        
     
    }
    
    func startGame(){
    //Reset my score, the players are in array, 0 is main and 1 is the enemy.
       score = [0,0]
        //Display the number as String in label
        topLbl.text = "\(score[1])" //enemy
        btmLbl.text = "\(score[0])" //main - me
        //Set the speed/ impulse movment of the ball to a 45 angel via delta x,y
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy:10))
    }
    
    func addScore(playerWoWon:SKSpriteNode){
        //Set the ball to the center of the screen
        ball.position = CGPoint(x:0, y:0)
        //Remove former impulse and physics
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        //Add one point to the main player or to the enemy
        if playerWoWon == main{
            score[0] += 1
            //If I won, I bet the ball
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy:10))
        }else if playerWoWon == enemy {
            score[1] += 1
            //If enemy won, he'll bet the ball
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        //Display the number as String in label
        topLbl.text = "\(score[1])" //enemy
        btmLbl.text = "\(score[0])" //main - me

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //Locate the location of the finger in inside the view
        for touch in touches{
            let location = touch.location(in: self)
            //Change for 2 players
            if currentGameType == .player2 {
                //Zero is the center of the screen
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Locate the location of the finger in inside the view
        for touch in touches{
            let location = touch.location(in: self)
            //Change for 2 players
            if currentGameType == .player2 {
                //Zero is the center of the screen
                if location.y > 0 {
                 enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                 main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else{
                 main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Set lever lof difficulty - duration
        switch currentGameType {
        case .easy:
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .player2:
            break
            
        }
        // Paddle move with a light delay of one second
       // enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        //Testing positions, when ball gets behind the paddles, it needs to count as a point
        if ball.position.y <= main.position.y - 30{
            //When missing the ball, the sound ballHitWall will be played
            ball.run(SKAction.playSoundFileNamed("ballHitWall", waitForCompletion: false))
          addScore(playerWoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
             ball.run(SKAction.playSoundFileNamed("ballHitWall", waitForCompletion: false))
            addScore(playerWoWon: main)
        }
    }
}

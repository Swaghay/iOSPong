//
//  GameScene.swift
//  pong
//
//  Created by 64004046 on 1/6/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mainScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        let n = 10 * Int.random(in: -5..<6)
        let n1 = 10 * Int.random(in: -5..<6)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: n, dy: n1))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame(){
        
        score = [0,0]
        enemyScore.text = "\(score[1])"
        mainScore.text = "\(score[0])"
        
    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        
        ball.position = CGPoint(x: 0,y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        
        if playerWhoWon == main{
            
            score[0]+=1
            ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
            
        } else if playerWhoWon == enemy{
            
            score[1]+=1
            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -50))
            
        }
        
        enemyScore.text = "\(score[1])"
        mainScore.text = "\(score[0])"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.01))
        
        if(ball.position.y <= main.position.y - 20){
            
            addScore(playerWhoWon: enemy)
            
        } else if(ball.position.y >= enemy.position.y + 20){
            
            addScore(playerWhoWon: main)
            
        }
        
    }
}

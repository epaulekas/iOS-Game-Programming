//
//  HelloWorldLayer.h
//  CollisionWithPlane
//
//  Created by Justin's Clone on 10/2/12.
//  Copyright Justin's Clone 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Platform.h"
#import "Player.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer 
{
    
    Player *player;
    
    int playerGravity;
    int originalGravity;
    
    int playerSpeed;
    int originalSpeed;
    
    int screenWidth;
    int screenHeight;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

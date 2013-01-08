//
//  HelloWorldLayer.h
//  TopDownEnemy
//
//  Created by Justin Dike on 4/11/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Constants.h"
#import "Player.h"
#import "Enemy.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
  
    CCSprite* square;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;



@end

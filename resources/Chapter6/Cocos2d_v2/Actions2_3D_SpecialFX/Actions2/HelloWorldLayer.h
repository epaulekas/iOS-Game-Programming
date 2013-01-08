//
//  HelloWorldLayer.h
//  Actions2
//
//  Created by Justin Dike on 6/11/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//




// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer 
{
    
    int screenWidth;
    int screenHeight;
    
    CCSprite* background;
    CCSprite* weapon1;
    CCSprite* weapon2;
    CCSprite* weapon3;
    CCSprite* weapon4;
    CCSprite* weapon5;
    CCSprite* weapon6;
    CCSprite* weapon7;
    CCSprite* weapon8;
    CCSprite* weapon9;
    
    CCRepeatForever* repeat;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

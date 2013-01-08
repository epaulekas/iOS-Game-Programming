//
//  HelloWorldLayer.h
//  Actions
//
//  Created by Justin Dike on 5/16/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    int screenWidth;
    int screenHeight;
  
    
    CCSprite* farmer;
    CCSprite* farmer2;
    BOOL isSequenceOccuring;
   
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


@end

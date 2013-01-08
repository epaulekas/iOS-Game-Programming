//
//  HelloWorldLayer.h
//  ScenesAndMenus
//
//  Created by Justin Dike on 7/23/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Preferences.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer 
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

+ (int)count;

@end

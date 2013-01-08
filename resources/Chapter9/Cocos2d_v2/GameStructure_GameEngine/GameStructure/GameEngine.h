//
//  GameEngine.h
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "AppData.h"
#import "Player.h"
#import "Enemy.h"
#import "ScoreObject.h"
#import "ScoreNodes.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"



@interface GameEngine : CCLayer {
    
    int lives;
    int level;
    
    int tilt;
    
    int ticker;
    
    int screenWidth;
    int screenHeight;
    
    NSString* backgroundString;
    NSString* scrollingBgString1;
    NSString* scrollingBgString2;
    
    Player* player;
    
    NSMutableArray* scoreObjArray;
    NSMutableArray* enemyArray;
}


@property (retain, nonatomic)  NSMutableArray* scoreObjArray;
@property (retain, nonatomic) NSMutableArray* enemyArray;

+(CCScene *) scene;


@end

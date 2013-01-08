//
//  GameMenu.h
//  GameStructure
//
//  Created by Justin's Clone on 10/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppData.h"
#import "SimpleAudioEngine.h"
#import "GameEngine.h"
#import "Constants.h"
#import "GameSounds.h"

@interface GameMenu : CCLayer {
    
    NSString* soundBtn;
    NSString* soundBtnDim;
    
    NSString* btn1;
    
    NSString* btn2;
    NSString* btnLocked2;
    
    NSString* btn3;
    NSString* btnLocked3;
    
    NSString* btn4;
    NSString* btnLocked4;
    
    NSString* btn5;
    NSString* btnLocked5;
    
    CGPoint SoundFXMenuLocation;
    CCMenu* SoundFXMenu;
    
    int screenWidth;
    int screenHeight;
    
    int currentLevel;
    
    GameSounds* sharedSounds;
    
}

+(CCScene *) scene;


@end

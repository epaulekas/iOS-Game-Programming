//
//  GameMenu.m
//  GameStructure
//
//  Created by Justin's Clone on 10/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameMenu.h"


@implementation GameMenu

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameMenu *layer = [GameMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    
    if( (self=[super init])) {
        
        sharedSounds = [GameSounds sharedSounds];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        screenWidth = size.width;
        screenHeight = size.height;
        
        btn1 = @"levelButton1.png";
        
        btn2 = @"levelButton2.png";
        btnLocked2 = @"levelButton2_locked.png";
        
        btn3 = @"levelButton3.png";
        btnLocked3 = @"levelButton3_locked.png";
        
        btn4 = @"levelButton4.png";
        btnLocked4 = @"levelButton4_locked.png";
        
        btn5 = @"levelButton5.png";
        btnLocked5 = @"levelButton5_locked.png";
        
        soundBtn = @"soundButtonOn.png";
        soundBtnDim = @"soundButtonOff.png";
        
        
        CCSprite* theBackground = [CCSprite spriteWithFile:@"menu_background.png" ];
        theBackground.position = ccp (screenWidth / 2 , screenHeight / 2);
        [self addChild:theBackground z:0];
        
        
        currentLevel = [[AppData sharedData] returnLevel];
        
        [self createLevelMenu];
        [self createResetMenu];
        [self createReturnMenu];
        
        if (sharedSounds.isAudioMuted == NO) {
        
            [self createSoundMenuOn];
        } else {
            
            [self createSoundMenuOff];
        }
        
        
        
    }
	return self;
    
}


-(void) createSoundMenuOn {
     [self removeChild:SoundFXMenu cleanup:YES];
    
    sharedSounds.isAudioMuted = NO;
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:soundBtn  selectedImage:soundBtn target:self selector:@selector(createSoundMenuOff)];
    SoundFXMenu = [CCMenu menuWithItems:button1, nil];
    SoundFXMenu.position = ccp( screenWidth/2, 200);
    [self addChild:SoundFXMenu z:10];
    
}
-(void) createSoundMenuOff {
    
     [self removeChild:SoundFXMenu cleanup:YES];
    
        sharedSounds.isAudioMuted = YES;
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:soundBtnDim  selectedImage:soundBtnDim target:self selector:@selector(createSoundMenuOn)];
    SoundFXMenu = [CCMenu menuWithItems:button1, nil];
    SoundFXMenu.position = ccp( screenWidth/2, 195);
    [self addChild:SoundFXMenu z:10];
    
}
-(void) createResetMenu {
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"resetButton.png"  selectedImage:@"resetButton.png" target:self selector:@selector(resetGame)];
    CCMenu *menu = [CCMenu menuWithItems:button1, nil];
    menu.position = ccp( screenWidth/2 -200, 200);
    [self addChild:menu z:10];
    
}

-(void) createReturnMenu {
    
    CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"returnButton.png" selectedImage:@"returnButton.png" block:^(id sender) {[self jumpToThisLevel:currentLevel ];}];
    CCMenu *menu = [CCMenu menuWithItems:button1, nil];
    menu.position = ccp( screenWidth/2 + 200, 200);
    [self addChild:menu z:10];
}


-(void) resetGame{
    
    [self jumpToThisLevel:kGameNeedsHardReset];
    
}


-(void) createLevelMenu {
    
    CCMenuItem *button1;
    CCMenuItem *button2;
    CCMenuItem *button3;
    CCMenuItem *button4;
    CCMenuItem *button5;
    
     button1  = [CCMenuItemImage itemWithNormalImage:btn1 selectedImage:btn1 block:^(id sender) {[self jumpToThisLevel:1 ];}];
    
    if (  [[AppData sharedData] canYouGoToThisLevel:2] == NO ) {
        
        button2 = [CCMenuItemImage itemWithNormalImage:btnLocked2 selectedImage:btnLocked2 target:self selector:@selector(bloop)];
        
    } else {
        
        button2  = [CCMenuItemImage itemWithNormalImage:btn2 selectedImage:btn2 block:^(id sender) {[self jumpToThisLevel:2 ];}];
    }
    
    if (  [[AppData sharedData] canYouGoToThisLevel:3] == NO ) {
        
        button3 = [CCMenuItemImage itemWithNormalImage:btnLocked3 selectedImage:btnLocked3 target:self selector:@selector(bloop)];
        
    } else {
        
        button3  = [CCMenuItemImage itemWithNormalImage:btn3 selectedImage:btn3 block:^(id sender) {[self jumpToThisLevel:3 ];}];
    }
    
    if (  [[AppData sharedData] canYouGoToThisLevel:4] == NO ) {
        
        button4 = [CCMenuItemImage itemWithNormalImage:btnLocked4 selectedImage:btnLocked4 target:self selector:@selector(bloop)];
        
    } else {
        
        button4  = [CCMenuItemImage itemWithNormalImage:btn4 selectedImage:btn4 block:^(id sender) {[self jumpToThisLevel:4 ];}];
    }
    
    if (  [[AppData sharedData] canYouGoToThisLevel:5] == NO ) {
        
        button5 = [CCMenuItemImage itemWithNormalImage:btnLocked5 selectedImage:btnLocked5 target:self selector:@selector(bloop)];
        
    } else {
        
        
        button5  = [CCMenuItemImage itemWithNormalImage:btn5 selectedImage:btn5 block:^(id sender) {[self jumpToThisLevel:5 ];}];
                                                               
    }

    CCMenu *menu = [CCMenu menuWithItems:button1, button2, button3, button4, button5, nil];
    menu.position = ccp( screenWidth/2, screenHeight / 2);
    [menu alignItemsHorizontallyWithPadding:10];
    [self addChild:menu z:1];
    
}

-(void) jumpToThisLevel:(int)theLevel {
    
    if ( theLevel == kGameNeedsHardReset){
        
        
        if ([[AppData sharedData] returnGameStatus] == kGameNotInProgress ) {
        
            CCLOG(@"GAME NOT IN PROGRESS, FULL RESET");
        } else if ([[AppData sharedData] returnGameStatus] == kGameEnginePaused ) {
            
            CCLOG(@"GAME PAUSED, FULL RESET");
            [[CCDirector sharedDirector] popScene];
        }
        
        [[AppData sharedData] resetGame];
        [[AppData sharedData] changeLevelTo:1];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameEngine scene] withColor:ccBLACK]];
        
        
    }  else if ( [[AppData sharedData] returnGameStatus] == kGameNotInProgress) {  // must be first run
        
        CCLOG(@"GAME NOT IN PROGRESS, NEW LEVEL STARTING");
        
        [[AppData sharedData] changeLevelTo:theLevel];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameEngine scene] withColor:ccBLACK]];
        
    
    } else if ( currentLevel == theLevel ) {
        
            CCLOG(@"RETURNING TO THE SAME LEVEL");
        
            [[AppData sharedData] setGameStatus:kGameEngineRunning];
            [[CCDirector sharedDirector] popScene];
        
    
    } else if (currentLevel != theLevel) {
        
                CCLOG(@"CHANGING LEVELS");
        
                [[CCDirector sharedDirector] popScene];
                [[AppData sharedData] resetGame];
                [[AppData sharedData] changeLevelTo:theLevel];
                [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameEngine scene] withColor:ccBLACK]]; 
    }
  
}





-(void) bloop {
    
    //play a sound indicating this level isn't available
    
    //[[SimpleAudioEngine sharedEngine] playEffect:@"bloop.mp3"];
    
    [sharedSounds playSoundFX:@"bloop.mp3"];
    
}

- (void) dealloc
{
    
    CCLOG(@"GAMEMENU HAS BEEN REMOVED");
      
    // don't forget to call "super dealloc"
	[super dealloc];
    
   	
}

@end

//
//  GameEngine.m
//  GameStructure
//
//  Created by Justin's Clone on 9/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameEngine.h"


@implementation GameEngine

@synthesize  scoreObjArray, enemyArray;


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameEngine *layer = [GameEngine node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{
	if( (self=[super init])) {
        
        
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        screenWidth = size.width;
        screenHeight = size.height;
        
        ticker = screenWidth;
        
        lives = [[AppData sharedData] returnLives];
        level = [[AppData sharedData] returnLevel];
        
        
       
        CCLOG(@"level is %i", level);
        
        
        maxHealthUnits = 500;
        currentHealthUnits = maxHealthUnits;
        
        self.isAccelerometerEnabled = YES;
        
       
        //Get level-specific properties from the .plist
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        
        NSMutableArray* levelArray = [NSMutableArray arrayWithArray:[plistData objectForKey:@"Levels"]];
        NSDictionary *levelDict = [NSDictionary dictionaryWithDictionary:[ levelArray objectAtIndex:level - 1  ]];
        
        levelPassedAt = [[levelDict objectForKey:@"LevelPassedAt"] integerValue];
        
        
        scoreObjArray = [[NSMutableArray alloc] initWithArray:[levelDict objectForKey:@"ScoreObjects"] ];
        enemyArray = [[NSMutableArray alloc] initWithArray:[levelDict objectForKey:@"Enemies"] ];
        
       
        //add the player
        
        NSDictionary* playerDict = [NSDictionary dictionaryWithDictionary:[levelDict objectForKey:@"PlayerProperties"]];
        player = [Player createWithDictionary:playerDict];
        [self addChild:player z:kPlayerLevel];
        
        
        //setup scrolling background
        
        backgroundString = [levelDict objectForKey:@"BackgroundArt"];
        scrollingBgString1 = [levelDict objectForKey:@"ScrollingArt1"];
        scrollingBgString2 = [levelDict objectForKey:@"ScrollingArt2"];
        
        [self setupBackground];
        
        
        // Score label...
        
        scoreLabel = [CCLabelBMFont labelWithString:@"0000" fntFile:@"green_arcade.fnt"];
        scoreLabel.position = ccp( screenWidth - 100, screenHeight - 30);
        [self addChild:scoreLabel z:kInterfaceElements];
        scoreLabel.anchorPoint = ccp(1.0f, 0.5f); 
       
        
        score = [[AppData sharedData] returnTotalScore];
        NSString* scoreString = [NSString stringWithFormat:@"%i", score];
        [scoreLabel setString: scoreString];
        
        
        //health meter
        
        meter = [HealthMeter createWithPercentage: ( currentHealthUnits / maxHealthUnits)  ];
        [self addChild:meter z:kInterfaceElements];
        meter.position = ccp( 200, screenHeight - 30);
        
        
        // life icons
        
        CGPoint iconPos = ccp( 380, screenHeight - 30 );
        
        for (int i=1; i <= lives; i++ ) {
            
            CCSprite* icon = [CCSprite spriteWithFile:@"player_icon.png"];
            [self addChild:icon z:kInterfaceElements tag:i ];
            icon.position = ccp( iconPos.x + (i * icon.contentSize.width  ), iconPos.y);
            
        }
        
        NSString* message = [NSString stringWithFormat:@"Level %i", level];
        [self showMessage:message ];
               
        // main engine loop
        
        [self schedule:@selector(mainLoop:) interval:1.0f/60.0f];
        
        
        //setup the Game Menu button
        
        CCMenuItem *button1 = [CCMenuItemImage itemWithNormalImage:@"gameMenu.png"  selectedImage:@"gameMenu.png" target:self selector:@selector(showMenu )];
        CCMenu *Menu = [CCMenu menuWithItems:button1, nil];
        Menu.position = ccp( screenWidth -150, 60 );
        [self addChild:Menu z:kInterfaceElements];
        
        [[AppData sharedData] setGameStatus:kGameEngineRunning]; //***** don't forget to add this
        
    }
    
    return self;
}


-(void) showMenu {
    
        [[AppData sharedData] setGameStatus:kGameEnginePaused];
        [[CCDirector sharedDirector] pushScene:[GameMenu scene]];
    
}


-(void) mainLoop: (ccTime) delta {
    
    
    ticker ++;
    
    if ( ticker == levelPassedAt ){
        
        [self levelPassed];
    }
    
    //CCLOG ( @"ticker %i", ticker);
    
    [self adjustPlayerPosition];
    
    [self setupEnemies];
    
    [self setupScoreObjects];
    
    [self checkScoreObjectCollisions];
    
    [self checkEnemyCollisions];
    
    
}

-(void) adjustPlayerPosition {
    
    if (player.position.y < screenHeight + 10 && player.position.y > 0) {
        
        player.position = ccp(player.position.x, player.position.y + tilt );
    }
    else if ( player.position.y >= screenHeight + 10){
        
        player.position = ccp(player.position.x, screenHeight );
        
    } else if ( player.position.y <= 0 ){
        
        player.position = ccp(player.position.x, 2 );
        
    }
    
}




-(void) setupEnemies {
    
    
    
    for ( int i = 0; i < [enemyArray count]; i++ ) {
        NSDictionary *enemyDict = [NSDictionary dictionaryWithDictionary:[ enemyArray objectAtIndex:i ]];
        
        CGPoint startPosition =  CGPointFromString( [enemyDict objectForKey:@"EnemyLocation"] );
        
        if (startPosition.x < ticker ) {
            
            CCLOG(@"creating new enemy or enemy block");
            
            [enemyArray removeObjectAtIndex:i];
        
            Enemy* someEnemy = [Enemy createWithDictionary:enemyDict];
            [self addChild:someEnemy z: [[enemyDict objectForKey:@"ZDepth"] integerValue] ];
            
            
            if (startPosition.x > screenWidth){ // anything that didn't originally start on the board
                
                startPosition = ccp( screenWidth + (someEnemy.enemySprite.contentSize.width /2) , startPosition.y );  //offset by contentwidth 
                
            }
            
            someEnemy.position = startPosition;
        
        
            int multiples = [[enemyDict objectForKey:@"PlaceThisManyMore"] integerValue];
        
            if ( multiples > 0 ) {
            
                CCLOG(@"placing multiples of this object");
                int count = 1;
                int padding = [[enemyDict objectForKey:@"XPaddingOfMultiples"] integerValue];
            
                while ( count <= multiples) {
                
                    Enemy* someEnemy = [Enemy createWithDictionary:enemyDict];
                    [self addChild:someEnemy z:kEnemiesLevel ];
                    someEnemy.position = ccp( startPosition.x + ( count * padding ), startPosition.y );
                
                    count++;
                }
            
            } //end if
            
            break;
        
        } // ends if (startPosition.x < ticker)
        
    } //end for

}



-(void) setupScoreObjects {
    
   
    
    for ( int i = 0; i < [scoreObjArray count]; i++ ) {
        NSDictionary *scoreObjDict = [NSDictionary dictionaryWithDictionary:[ scoreObjArray objectAtIndex:i ]];
        
        CGPoint startPosition =  CGPointFromString( [scoreObjDict objectForKey:@"ObjectLocation"] );
        
        if (startPosition.x < ticker) {
            
            
            CCLOG(@"creating new score object set");
            [scoreObjArray removeObjectAtIndex:i];
        
            ScoreNodes* someGroup = [ScoreNodes createWithSpeed:[[scoreObjDict objectForKey:@"Speed"]integerValue]  ];
            [self addChild:someGroup z: [[scoreObjDict objectForKey:@"ZDepth"] integerValue]];
        
        
            ScoreObject* someObject = [ScoreObject createWithDictionary:scoreObjDict];
            [someGroup addChild:someObject ];
            
            
            //because we are waiting for offscreen objects to become "just" within view, we need to place them right at the edge of the screen width

            if (startPosition.x > screenWidth){              
               startPosition = ccp( screenWidth + (someObject.objectSprite.contentSize.width /2) , startPosition.y );
            
            } 
                
            someObject.position = startPosition;
                
          
        
            int multiples = [[scoreObjDict objectForKey:@"PlaceThisManyMore"] integerValue];
        
            if ( multiples > 0 ) {
            
                CCLOG(@"placing multiples of this object");
                int count = 1;
                int padding = [[scoreObjDict objectForKey:@"XPaddingOfMultiples"] integerValue];
            
                while ( count <= multiples) {
                
                    ScoreObject* someObject = [ScoreObject createWithDictionary:scoreObjDict];
                    [someGroup addChild:someObject];
                    someObject.position = ccp( startPosition.x + ( count * padding ), startPosition.y );
                
                    count++;
                }
            
            } //end if
            
            
            break;
            
        } // end     if (startPosition.x < ticker) 
        
    } //end for
    
    
}




-(void) checkScoreObjectCollisions {
    
    for (ScoreNodes* group in self.children) {
        
        if ( [ group isKindOfClass:[ScoreNodes class]]) {
            
            
            for (ScoreObject* object in group.children) {
                
                if ( [ object isKindOfClass:[ScoreObject class]]) {
                    
                    
                    CGPoint worldCoord = [group convertToWorldSpace: object.position];
                    
                    //CCLOG(@"object world space x:%f y:%f", worldCoord.x, worldCoord.y  );
                    
                    //CCLOG(@" group has this many children %i ", [group.children count] );
                    
                    
                    CGRect objRect = CGRectMake( worldCoord.x - (object.objectSprite.contentSize.width / 2) ,
                                                worldCoord.y - (object.objectSprite.contentSize.height /2 ),
                                                object.objectSprite.contentSize.width,
                                                object.objectSprite.contentSize.height);
                    
                    if ( CGRectContainsPoint( objRect, player.position) ) {
                        
                        //get points from object
                        [self addToScore: object.pointValue];
                        
                        
                        [group removeChild:object cleanup:NO];
                        
                        if ([group.children count] == 0){
                            
                            CCLOG(@"no more children, removing parent");
                            [self removeChild:group cleanup:YES];
                            
                            break;
                            
                        }
                        
                        
                    }
                    
                    
                    else if (worldCoord.x < -100 ) {
                        
                        [group removeChild:object cleanup:NO];
                        
                        if ([group.children count] == 0){
                            
                            CCLOG(@"no more children, removing parent");
                            [self removeChild:group cleanup:YES];
                            
                            break;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}


-(void) checkEnemyCollisions {
    
    
    for (Enemy* enemy in self.children) {
        
        if ( [ enemy isKindOfClass:[Enemy class]]) {
            
            CGRect enemyRect = CGRectMake( enemy.position.x - (enemy.enemySprite.contentSize.width / 2) ,
                                          enemy.position.y - (enemy.enemySprite.contentSize.height /2 ),
                                          enemy.enemySprite.contentSize.width,
                                          enemy.enemySprite.contentSize.height);
            
            
            if (CGRectContainsPoint( enemyRect, player.position) ){
                
                [self enemyCollisionOccurred];
                
            }
        }
        
    }
    
    
}

-(void) enemyCollisionOccurred {
    
    [player showBruisedState];
    currentHealthUnits = currentHealthUnits - 2;
    [meter adjustPercentage: (currentHealthUnits / maxHealthUnits) ];
    
    if (currentHealthUnits <= 0){
        
        [self unschedule:@selector(mainLoop:)];
        
        [[AppData sharedData] subtractLife];
        
        CCFadeOut *fade = [CCFadeOut actionWithDuration:1.0f];
        CCBlink *blink = [CCBlink actionWithDuration:1.0 blinks:5];
        CCSpawn *spawn = [CCSpawn actions:fade, blink, nil]; 
        [[self getChildByTag:lives] runAction:spawn];
        
        
        NSString* message = [NSString stringWithFormat:@"Level %i Failed", level];
        [self showMessage:message];
        
        
        if ( [[AppData sharedData] returnLives] == 0 ) {
            [[AppData sharedData] setGameStatus:kGameNotInProgress];
            [[AppData sharedData] resetGame];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:3.0 scene:[GameMenu scene] withColor:ccBLACK]];
             
            
        } else {
            
            [self scheduleOnce:@selector(reloadLevel) delay:1.0f];
            
        }
        
    }
    
}


-(void) addToScore:(int)thePoints {
    
    
    CCLOG(@"the points are %i", thePoints);
    
    score = score + thePoints;
    [[AppData sharedData] addToTotalScore:thePoints];
    
    NSString* scoreString = [NSString stringWithFormat:@"%i", score];
    [scoreLabel setString: scoreString];
}


-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    tilt = (acceleration.y * 20);
    
}


-(void) reloadLevel {
    
    CCTransitionFade *transition = [CCTransitionFade transitionWithDuration:2 scene:[GameEngine scene] ];
    [[CCDirector sharedDirector] replaceScene:transition];
    
}

-(void) levelPassed {
    
    [self unschedule:@selector(mainLoop:)];
    
    [[AppData sharedData] advanceLevel ];
    
    CCMoveBy *move = [CCMoveBy actionWithDuration:2.0 position:ccp( screenWidth, 0) ];
    [player runAction:move];
    
    
    NSString* message = [NSString stringWithFormat:@"Level %i Passed", level];
    [self showMessage:message]; 
    
    [self scheduleOnce:@selector(reloadLevel) delay:3.0f];
    
    
    
}

-(void) showMessage:(NSString*) theMessage {
    
    CCLabelTTF *message = [CCLabelTTF labelWithString:theMessage fontName:@"Marker Felt" fontSize:40];
    [self addChild:message z:kInterfaceElements];
    message.position = ccp(0, screenHeight / 2);
    
    CCMoveTo *move = [CCMoveTo actionWithDuration:0.5 position:ccp( screenWidth /2 , screenHeight /2)];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:2.0];
    CCMoveTo *move2 = [CCMoveTo actionWithDuration:0.5 position:ccp( screenWidth + 200, screenHeight /2)];
    CCCallFuncN *callFunc = [CCCallFuncN actionWithTarget:self  selector:@selector( finishSeq:)];
    CCSequence* sequence = [CCSequence actions: move, delay, move2, callFunc, nil];
    [message runAction:sequence];

}

-(void)finishSeq:(id) sender {
    
    CCLOG(@"removing message");
    [self removeChild:sender cleanup:NO];
    
}

- (void) setupBackground {
    
    CCSprite* background = [CCSprite spriteWithFile: backgroundString ];
    background.position = ccp( screenWidth / 2 , screenHeight /2);
    [self addChild:background z:kSkyLevel];
    
    CCSprite* scrollingArt = [CCSprite spriteWithFile:scrollingBgString1 rect:CGRectMake(0, 0, screenWidth* 2, 512 )];
    ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};   
    [scrollingArt.texture setTexParameters:&params];
    scrollingArt.position = ccp( screenWidth , 255);
    [self addChild:scrollingArt z:kLandscapeLevel];
    
    
    CCMoveBy* move = [CCMoveBy actionWithDuration:15.0 position:ccp( screenWidth * -1, 0)];
    CCPlace* place  = [CCPlace actionWithPosition:ccp( screenWidth , 255 ) ];
    CCSequence* scrollingArtSequence = [CCSequence actions: move, place, nil];
    CCRepeatForever* repeatSequence = [CCRepeatForever actionWithAction:scrollingArtSequence];
    [scrollingArt runAction:repeatSequence];
    
 
    
    CCSprite* scrollingArt2 = [CCSprite spriteWithFile:scrollingBgString2 rect:CGRectMake(0, 0, screenWidth* 2, screenHeight )];
    ccTexParams params2 = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT}; 
    [scrollingArt2.texture setTexParameters:&params2];
    scrollingArt2.position = ccp( screenWidth  , screenHeight /2);
    [self addChild:scrollingArt2 z:kCloudsLevel];
    
    
    CCMoveBy* move2 = [CCMoveBy actionWithDuration:40.0 position:ccp( screenWidth * -1, 0)];
    CCPlace* place2  = [CCPlace actionWithPosition:ccp(  screenWidth  , screenHeight /2) ];
    CCSequence* scrollingArtSequence2 = [CCSequence actions: move2, place2, nil];
    CCRepeatForever* repeatSequence2 = [CCRepeatForever actionWithAction:scrollingArtSequence2];
    [scrollingArt2 runAction:repeatSequence2];
    
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    [scoreObjArray release];
    [enemyArray release];
    
    enemyArray = nil;
	scoreObjArray = nil;
    
	[super dealloc];
}
@end

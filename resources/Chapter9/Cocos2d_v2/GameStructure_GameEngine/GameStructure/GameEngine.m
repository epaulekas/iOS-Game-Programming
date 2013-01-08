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
        CCLOG( @"The lives left is: %i , and the level is %i", lives, level);
        
        
        self.isAccelerometerEnabled = YES;
        
       
        //Get level-specific properties from the .plist
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        
        NSMutableArray* levelArray = [NSMutableArray arrayWithArray:[plistData objectForKey:@"Levels"]];
        NSDictionary *levelDict = [NSDictionary dictionaryWithDictionary:[ levelArray objectAtIndex:level - 1  ]];
        
        
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
        
       
        
               
        // main engine loop
        
        [self schedule:@selector(mainLoop:) interval:1.0f/60.0f];
        
        
    }
    
    return self;
}


-(void) mainLoop: (ccTime) delta {
    
    
    ticker ++;
    
    // CCLOG ( @"ticker %i", ticker);
    
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
                
                CCLOG(@"collision");
                
                [player showBruisedState];
                
            }
        }
        
    }
    
    
}


-(void) addToScore:(int)thePoints {
    
    
    CCLOG(@"the points are %i", thePoints);
}


-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    tilt = (acceleration.y * 20);
    
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

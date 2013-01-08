//
//  HelloWorldLayer.m
//  Actions
//
//  Created by Justin Dike on 5/16/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        
     
        
        self.isTouchEnabled = YES;
        
        CGSize size = [ [CCDirector sharedDirector] winSize ]; 
        screenWidth = size.width;
        screenHeight = size.height;
        
		
        
        background = [CCSprite spriteWithFile:@"weapons_board.png"];
        background.position = ccp( screenWidth / 2 , screenHeight /2);
        [self addChild:background z:-5];
       
        
        weapon1 = [CCSprite spriteWithFile:@"weapon1.png"];
        weapon1.position = ccp( 230 , 550 );
        [self addChild:weapon1 z:20];
        
        weapon2 = [CCSprite spriteWithFile:@"weapon2.png"];
        weapon2.position = ccp( 470 , 550 );
        [self addChild:weapon2 ];
        
        weapon3 = [CCSprite spriteWithFile:@"weapon3.png"];
        weapon3.position = ccp( 710 , 550 );
        [self addChild:weapon3 ];
        
        weapon4 = [CCSprite spriteWithFile:@"weapon4.png"];
        weapon4.position = ccp( 230 , 350 );
        [self addChild:weapon4 ];
        
        weapon5 = [CCSprite spriteWithFile:@"weapon5.png"];
        weapon5.position = ccp( 470 , 350 );
        [self addChild:weapon5 ];
        
        weapon6 = [CCSprite spriteWithFile:@"weapon6.png"];
        weapon6.position = ccp( 710 , 350 );
        [self addChild:weapon6 ];
        
        weapon7 = [CCSprite spriteWithFile:@"weapon7.png"];
        weapon7.position = ccp( 230 , 150 );
        [self addChild:weapon7 ];
        
        weapon8 = [CCSprite spriteWithFile:@"weapon8.png"];
        weapon8.position = ccp( 470 , 150 );
        [self addChild:weapon8 ];
        
        weapon9 = [CCSprite spriteWithFile:@"weapon9.png"];
        weapon9.position = ccp( 710 , 150 );
        [self addChild:weapon9 z:21 ];


        
	}
	return self;
}





-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( CGRectContainsPoint(weapon1.boundingBox, location) ) {
        
        [self specialAction1];
        
    } 
    else if ( CGRectContainsPoint(weapon2.boundingBox, location) ) {
        
         [self specialAction2];
    }
    else if ( CGRectContainsPoint(weapon3.boundingBox, location) ) {
        
        [self specialAction3];
    }
    
    else if ( CGRectContainsPoint(weapon4.boundingBox, location) ) {
        
        [self specialAction4];
    }
    
    else if ( CGRectContainsPoint(weapon5.boundingBox, location) ) {
        
        [self specialAction5];
    }
    else if ( CGRectContainsPoint(weapon6.boundingBox, location) ) {
        
        [self specialAction6];
    }
    else if ( CGRectContainsPoint(weapon7.boundingBox, location) ) {
        
        [self specialAction7];
    } 
    else if ( CGRectContainsPoint(weapon8.boundingBox, location) ) {
        
        [self specialAction8];
    }
    else if ( CGRectContainsPoint(weapon9.boundingBox, location) ) {
        
        [self specialAction9];
    }
    
}

-(void) specialAction1 {
    
    
    [self resetWeapons];
    
    CCFlipX3D* flip = [CCFlipX3D  actionWithDuration:3.0];
    
    CCSequence* sequence = [CCSequence actions: flip, [flip reverse], nil];
    
    repeat = [CCRepeatForever actionWithAction: sequence];
    
    [weapon1 runAction: repeat];
    
}


-(void) specialAction2 {
    
        
    
    [self resetWeapons];
    
    CCShaky3D* shaky = [CCShaky3D actionWithRange:10 shakeZ:YES grid:ccg(20,16) duration:5];
    
    repeat = [CCRepeatForever actionWithAction: shaky];
    [weapon2 runAction: repeat];
    
    
}

-(void) specialAction3 {
    
  
     [self resetWeapons];
    
    CCWaves* waves = [CCWaves actionWithWaves:5 amplitude:20 horizontal:YES vertical:NO grid:ccg(20,20) duration:5];
    
    repeat = [CCRepeatForever actionWithAction: waves];
    [weapon3 runAction: repeat];
   
}

-(void) specialAction4 {
    
     [self resetWeapons];
    
    CCRipple3D* ripple = [CCRipple3D actionWithPosition:weapon4.position radius:weapon4.contentSize.width  waves:3 amplitude:15 grid:ccg(40,40) duration:8.0];
   
    
    repeat = [CCRepeatForever actionWithAction: ripple];
    [weapon4 runAction:repeat ];
    
   
}



-(void) specialAction5 {
    
    [self resetWeapons];
    
    
     CCTwirl* twirl = [CCTwirl actionWithPosition:weapon5.position twirls:1 amplitude:3 grid:ccg(20, 20) duration:3.0 ];
     
     repeat = [CCRepeatForever actionWithAction: twirl];
     [weapon5 runAction:repeat];
    

    
    
}

-(void) specialAction6 {
    
    [self resetWeapons];
    
    CCWaves3D* waves = [CCWaves3D actionWithWaves:5 amplitude:50 grid:ccg(20, 20) duration:2.0];
    
    repeat = [CCRepeatForever actionWithAction: waves];
    [weapon6 runAction: repeat];    
    
    
}

-(void) specialAction7 {
    
    [self resetWeapons];
    
    CCLiquid* liquid = [CCLiquid actionWithWaves:5 amplitude:20 grid:ccg(20,20) duration:3.0 ];
    
    repeat = [CCRepeatForever actionWithAction: liquid];
    [weapon7 runAction: repeat];    
    
    
}

-(void) specialAction8 {
    
   [self resetWeapons];
    
    
    CCShakyTiles3D* shaky = [CCShakyTiles3D actionWithRange:4 shakeZ:YES grid:ccg(20, 20) duration:1.0];
    CCShakyTiles3D* shaky2 = [CCShakyTiles3D actionWithRange:10 shakeZ:YES grid:ccg(20, 20) duration:1.0];
    CCShakyTiles3D* shaky3 = [CCShakyTiles3D actionWithRange:20 shakeZ:YES grid:ccg(20, 20) duration:1.0];
    
    CCFadeOutBLTiles* tileEffect = [CCFadeOutBLTiles actionWithSize:ccg(20, 20) duration:2.0];
    id reverseTiles = [tileEffect reverse];
    CCFadeOutTRTiles* tileEffect2 = [CCFadeOutTRTiles actionWithSize:ccg(20, 20) duration:2.0];
    id reverseTiles2 = [tileEffect2 reverse];
   
    CCWavesTiles3D* tileWaves = [CCWavesTiles3D actionWithWaves:3 amplitude:15 grid:ccg(20,20) duration:5];
    
    CCSequence* sequence = [CCSequence actions: tileWaves, shaky,shaky2, shaky3,  tileEffect,reverseTiles,tileEffect2, reverseTiles2,   nil];
    repeat = [CCRepeatForever actionWithAction: sequence];
    [weapon8 runAction: repeat];    
    
    
}

-(void) specialAction9 {
    
    
    [self resetWeapons];
    
    
    CCJumpTiles3D* jump = [CCJumpTiles3D actionWithJumps:3 amplitude:10 grid:ccg(30,30) duration:5];
    CCShatteredTiles3D* shatter = [CCShatteredTiles3D actionWithRange:20 shatterZ:NO grid:ccg(20,20) duration:.2];
    CCShuffleTiles* shuffle = [CCShuffleTiles actionWithSize:ccg(20,20) duration:2];
    id reverse = [ shuffle reverse];
    
    CCFadeOutDownTiles* fadeDown = [CCFadeOutDownTiles actionWithSize:ccg(20, 20) duration:4.0];
    CCFadeOutUpTiles* fadeUp = [CCFadeOutUpTiles actionWithSize:ccg(20, 20) duration:4.0];
    
    CCSplitCols* split = [CCSplitCols actionWithCols:30 duration:2.0];
    CCSplitRows* split2 = [CCSplitRows actionWithRows:30 duration:2.0];
 
    CCSequence* sequence = [CCSequence actions: jump,shatter,shuffle,reverse,split,split2, fadeDown, fadeUp,  nil];
    
     
    
    repeat = [CCRepeatForever actionWithAction: sequence];
    [weapon9 runAction: repeat];    
    
    
}


-(void) resetWeapons {
    
   [self stopAction:repeat];
   
    
    [weapon1 setGrid:nil];
    [weapon2 setGrid:nil];
    [weapon3 setGrid:nil];
    [weapon4 setGrid:nil];
    [weapon5 setGrid:nil];
    [weapon6 setGrid:nil];
    [weapon7 setGrid:nil];
    [weapon8 setGrid:nil];
    [weapon9 setGrid:nil];
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

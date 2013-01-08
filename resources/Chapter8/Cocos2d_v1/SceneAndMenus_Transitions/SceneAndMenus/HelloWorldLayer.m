//
//  HelloWorldLayer.m
//  ScenesAndMenus
//
//  Created by Justin Dike on 7/23/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"



static int theCount = 0;


// HelloWorldLayer implementation
@implementation HelloWorldLayer



// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
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

+ (int) count {
    
    
    return theCount;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        CCLOG(@"new instance initialized ");
        
        self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:@"sceneImage.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        
        //adding a fade in of the image to show more of a difference between the scene coming in and leaving
        background.opacity = 0;
        CCFadeTo* fadeTo = [CCFadeTo actionWithDuration:2.0 opacity:255];
        [background runAction: fadeTo];
        
        
        // adding a particle in here to make the transitions more interesting.... 
        CCParticleSystem* system = [CCParticleSun node]; 
        [self addChild: system z:1 ];
        system.position = ccp(0, 100 ); 
        CCJumpBy* jump = [CCJumpBy actionWithDuration: 5 position: ccp(1000, 0) height:300 jumps:2 ];
        id reverse = [jump reverse];
        CCSequence* sequence = [CCSequence actions: jump, reverse, nil ];
        CCRepeatForever* repeat = [ CCRepeatForever actionWithAction: sequence];
        [system runAction: repeat];
        
        
        
        
        theCount ++; 
        
        //comment out the line below to stop the scene transitions...
        
        [self schedule:@selector(replaceWithMyself) interval:6.0f];
        
        
	}
	return self;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // you shouldn't see this in the output window when the Preferences screen is pushed
    CCLOG(@"touching the HelloWorldLayer class");
    
    
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( location.x < 100 && location.y > 700) {
        
        [[CCDirector sharedDirector] pushScene:[Preferences scene]];
        
    }
    
}

-(void) replaceWithMyself {
    
    if (theCount == 9) {
        
        theCount = 1;
        
    }
    
    CCLOG(@"theCount is... %i", theCount);
    
    if (theCount == 1) {
        CCTransitionFadeTR *transition = [CCTransitionFadeTR transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 2) {
        
        CCTransitionSplitCols *transition = [CCTransitionSplitCols transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 3) {
        CCTransitionMoveInB *transition = [CCTransitionMoveInB transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 4) {
        CCTransitionJumpZoom *transition = [CCTransitionJumpZoom transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 5) {
         CCTransitionZoomFlipAngular *transition = [CCTransitionZoomFlipAngular transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 6) {
        CCTransitionFlipY *transition = [CCTransitionFlipY transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 7) {
        CCTransitionShrinkGrow *transition = [CCTransitionShrinkGrow transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    else if (theCount == 8) {
        CCTransitionZoomFlipY *transition = [CCTransitionZoomFlipY transitionWithDuration:2 scene:[HelloWorldLayer scene] orientation:kOrientationDownOver ];
        [[CCDirector sharedDirector] replaceScene:transition];
    } 
    
    
    
    CCLOG(@"transitioning scene over the next 2 seconds");
    
    [self unschedule:_cmd];
}
/*
 -(void) justABunchOfCode  {
 
 
 
 CCTransitionCrossFade *transition1 =[CCTransitionCrossFade transitionWithDuration:2 scene: [HelloWorldLayer scene]];
 CCTransitionFade *transition2 = [CCTransitionFade transitionWithDuration:2 scene:[HelloWorldLayer scene] withColor:ccBLACK];
 CCTransitionFadeBL *transition3 = [CCTransitionFadeBL transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionFadeDown *transition4 = [CCTransitionFadeDown transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionFadeTR *transition5 = [CCTransitionFadeTR transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionFadeUp *transition6 = [CCTransitionFadeUp transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionFlipAngular *transition7 = [CCTransitionFlipAngular transitionWithDuration:2 scene:[HelloWorldLayer scene]  ];
 CCTransitionFlipX *transition8 =[CCTransitionFlipX transitionWithDuration:2 scene:[HelloWorldLayer scene] orientation:kOrientationLeftOver];
 CCTransitionFlipY *transition9 = [CCTransitionFlipY transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionJumpZoom *transition10 = [CCTransitionJumpZoom transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionMoveInB *transition11 = [CCTransitionMoveInB transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionMoveInL *transition12 = [CCTransitionMoveInL transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionMoveInR *transition13 = [CCTransitionMoveInR transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionMoveInT *transition14 = [CCTransitionMoveInT transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionPageTurn *transition15 = [CCTransitionPageTurn transitionWithDuration:2 scene:[HelloWorldLayer scene]backwards:NO ];
 CCTransitionProgress *transition16 = [CCTransitionProgress transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionProgressHorizontal *transition17 = [CCTransitionProgressHorizontal transitionWithDuration:2 scene:[HelloWorldLayer scene]  ];
 CCTransitionProgressInOut *transition18 = [CCTransitionProgressInOut transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionProgressOutIn *transition19 = [CCTransitionProgressOutIn transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionProgressRadialCCW *transition20 = [CCTransitionProgressRadialCCW transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionProgressRadialCW *transition21 = [CCTransitionProgressRadialCW transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionProgressVertical *transition22 = [CCTransitionProgressVertical transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionRotoZoom *transition23 = [CCTransitionRotoZoom transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionScene *transition24 = [CCTransitionScene transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSceneOriented *transition25 = [CCTransitionSceneOriented transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionShrinkGrow *transition26 = [CCTransitionShrinkGrow transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSlideInB *transition27 = [CCTransitionSlideInB transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSlideInL *transition28 = [CCTransitionSlideInL transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSlideInR *transition29 = [CCTransitionSlideInR transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSlideInT *transition30 = [CCTransitionSlideInT transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSplitCols *transition31 = [CCTransitionSplitCols transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionSplitRows *transition32 = [CCTransitionSplitRows transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionTurnOffTiles *transition33 = [CCTransitionTurnOffTiles transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionZoomFlipAngular *transition34 = [CCTransitionZoomFlipAngular transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionZoomFlipX *transition35 = [CCTransitionZoomFlipX transitionWithDuration:2 scene:[HelloWorldLayer scene] ];
 CCTransitionZoomFlipY *transition36 = [CCTransitionZoomFlipY transitionWithDuration:2 scene:[HelloWorldLayer scene] orientation:kOrientationDownOver ];
 
 
 
 }
 */


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    CCLOG(@"removing instance");
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end

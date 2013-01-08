//
//  HelloWorldLayer.m
//  SpriteSheets
//
//  Created by Justin Dike on 5/31/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize walkRight, walkLeft, punch, kick, jump;

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
		
		
        
        CGSize size = [ [CCDirector sharedDirector] winSize ];
        screenWidth = size.width;
        screenHeight = size.height;
        
        
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        [self addChild:background z:-2];
        background.position = ccp( screenWidth /2, screenHeight/2);
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hanksheet_poses.plist"];
        
        defaultPose = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"hank_fighting_default.png"]; 
        zombie = [CCSprite spriteWithSpriteFrame:defaultPose];
        [self addChild: zombie];
        zombie.position = ccp(300, 300 );
        
        
        
    
        shadow = [CCSprite spriteWithFile:@"shadow.png"];
        [self addChild:shadow z:-1];
        shadow.position = ccp( zombie.position.x - 10, zombie.position.y - 100);
        
        
        //set up walk
        
        NSMutableArray *walkingFrames = [NSMutableArray arrayWithCapacity:9];
        for(int i = 1; i <= 9; ++i) {
            
            NSString* file = [NSString stringWithFormat:@"hank_walkforward%i.png", i];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file]; 
            [walkingFrames addObject:frame];
        }
        
        CCCallFunc* moveDone = [CCCallFunc actionWithTarget: self selector:@selector( allowAnotherMove )];
        
        CCAnimation* walkAnimation = [CCAnimation animationWithFrames:walkingFrames delay:0.1f ];
        CCAnimate* animateWalk = [CCAnimate actionWithAnimation:walkAnimation];
        CCMoveBy* moveRight = [ CCMoveBy actionWithDuration:1 position:ccp( 50, 0 )];
        CCSpawn* spawnWalkRight = [CCSpawn actions:animateWalk, moveRight, nil];
        self.walkRight = [CCSequence actions:spawnWalkRight, [CCCallFunc actionWithTarget: self selector:@selector( allowAnotherMove )], nil];
        
        
        CCMoveBy* moveLeft = [ CCMoveBy actionWithDuration:1 position:ccp( -50, 0 )];
        CCSpawn* spawnWalkLeft = [CCSpawn actions:animateWalk, moveLeft, nil];
        self.walkLeft = [CCSequence actions:spawnWalkLeft, moveDone , nil];
        
        [self addSwipeToMoveGestures];
        
        
        ////////////////////////////////////////
        //set up punch ...
        
        NSMutableArray *punchFrames = [NSMutableArray arrayWithCapacity:5];
        for(int i = 0; i <= 4; ++i) {
            
            NSString* file = [NSString stringWithFormat:@"hank_punch%i.png", i];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file]; 
            [punchFrames addObject:frame];
        }
        
        CCAnimation* punchAnimation = [CCAnimation animationWithFrames:punchFrames delay:0.1f ];
        CCAnimate* animatePunch = [CCAnimate actionWithAnimation:punchAnimation restoreOriginalFrame:YES];
        
        CCMoveBy* moveWithPunch = [ CCMoveBy actionWithDuration:.3 position:ccp( 10, 0 )];
        CCEaseOut* easeWithMovePunch = [CCEaseOut actionWithAction:moveWithPunch rate:5];
        CCSpawn* spawnPunchMoves = [CCSpawn actions:animatePunch, easeWithMovePunch, nil];
        self.punch = [CCSequence actions:spawnPunchMoves, moveDone, nil];
        
        [self addTapToPunchGesture];
        
        ////////////////////////////////////////
        //set up kick ...
        
        NSMutableArray *kickFrames = [NSMutableArray arrayWithCapacity:5];
        for(int i = 0; i <= 4; ++i) {
            
            NSString* file = [NSString stringWithFormat:@"hank_kick%i.png", i];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file]; 
            [kickFrames addObject:frame];
        }
        
        CCAnimation* kickAnimation = [CCAnimation animationWithFrames:kickFrames delay:0.1f ];
        CCAnimate* animateKick = [CCAnimate actionWithAnimation:kickAnimation restoreOriginalFrame:YES];
        
        CCMoveBy* moveWithKick = [ CCMoveBy actionWithDuration:.3 position:ccp( -10, 0 )];
        CCEaseOut* easeMoveWithKick = [CCEaseOut actionWithAction:moveWithKick rate:5];
        CCSpawn* spawnKickMoves = [CCSpawn actions:animateKick, easeMoveWithKick, nil];
        self.kick = [CCSequence actions:spawnKickMoves, moveDone, nil];
        
        [self addTapToKickGesture];
        
        ////////////////////////////////////////
        //set up jump ...
        
        
        NSMutableArray *jumpFrames = [NSMutableArray arrayWithCapacity:4];
        for(int i = 0; i <= 3; ++i) {
            
            NSString* file = [NSString stringWithFormat:@"hank_spinning%i.png", i];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file]; 
            [jumpFrames addObject:frame];
        }
        

        
        CCAnimation* jumpAnimation = [CCAnimation animationWithFrames:jumpFrames  delay:0.05f ];
        CCAnimate* animateJump = [CCAnimate actionWithAnimation:jumpAnimation restoreOriginalFrame:YES];
        CCRepeat* repeatAnimation = [CCRepeat actionWithAction:animateJump times:2];
        CCJumpBy* jumpBy = [ CCJumpBy actionWithDuration:0.5 position:ccp(10,0) height:100 jumps:1];
        CCSpawn* spawnJump = [CCSpawn actions:repeatAnimation, jumpBy, nil];
        self.jump = [CCSequence actions:spawnJump, moveDone, nil];
        
        
        
        [self addSwipeToJumpGesture];
        
        
        ////////////////////////////////////////
       
        
        [self scheduleUpdate];
        
        
	}
	return self;
}

-(void) allowAnotherMove {
    
    moveInProgress= NO;
   
    [zombie setDisplayFrame:defaultPose ];
    
}


-(void) addTapToPunchGesture {
    
    tapToPunch = [[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToPunch:)];
    tapToPunch.numberOfTapsRequired = 2;
    tapToPunch.numberOfTouchesRequired = 1;
    [ [[CCDirector sharedDirector]openGLView]  addGestureRecognizer:tapToPunch];
    [tapToPunch release];
    
}

-(void) handleTapToPunch:(UITapGestureRecognizer *)recognizer  { 
	
    if ( moveInProgress == NO) {
        moveInProgress= YES;
        [zombie stopAllActions];
        [zombie runAction:punch];
    } else {
        
        CCLOG(@"move already in progress");
    }
    
}


-(void) addTapToKickGesture {
    
    tapToKick = [[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapToKick:)];
    tapToKick.numberOfTapsRequired = 2;
    tapToKick.numberOfTouchesRequired = 2;
    [ [[CCDirector sharedDirector]openGLView]  addGestureRecognizer:tapToKick];
    [tapToKick release];
    
}

-(void) handleTapToKick:(UITapGestureRecognizer *)recognizer  { 
	
    
    if ( moveInProgress == NO) {
        moveInProgress= YES;
        [zombie stopAllActions];
        [zombie runAction:kick];
    } else {
        
        CCLOG(@"move already in progress");
    }
    
}






-(void) addSwipeToJumpGesture {
    
    swipeUp =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    swipeUp.numberOfTouchesRequired = 1;
	swipeUp.direction = UISwipeGestureRecognizerDirectionUp; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeUp];
	[swipeUp release];
    
    }


-(void) handleSwipeUp:(UISwipeGestureRecognizer *)recognizer  { 
    
    if ( moveInProgress == NO) {
        moveInProgress= YES;
        [zombie stopAllActions];
        [zombie runAction:jump];
    } else {
        
        CCLOG(@"move already in progress");
    }
    
}

-(void) addSwipeToMoveGestures {
    
    
    swipeLeft =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeLeft.numberOfTouchesRequired = 1;
	swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeLeft];
	[swipeLeft release];
    
    
    
    swipeRight =[[ UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeRight.numberOfTouchesRequired = 1;
	swipeRight.direction = UISwipeGestureRecognizerDirectionRight; 
	[[[CCDirector sharedDirector]openGLView]  addGestureRecognizer:swipeRight];
	[swipeRight release];
    
}
-(void) handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer  { 
	
	if ( moveInProgress == NO) {
        
        [zombie stopAllActions];
        [zombie runAction:walkLeft];
    } else {
        
        CCLOG(@"move already in progress");
    }
   
    
}
-(void) handleSwipeRight:(UISwipeGestureRecognizer *)recognizer  { 
	
	if ( moveInProgress == NO) {
        
        [zombie stopAllActions];
        [zombie runAction:walkRight];
    } else {
        
        CCLOG(@"move already in progress");
    }
    
    
}

-(void) update:(ccTime) delta {
    
    shadow.position = ccp( zombie.position.x -10 , shadow.position.y );
    
    if( zombie.position.x < 0) {
        
        [zombie stopAllActions];
        [self allowAnotherMove];
        zombie.position = ccp( 1 , zombie.position.y );
    } 
    else if( zombie.position.x > screenWidth) {
        
        [zombie stopAllActions];
        [self allowAnotherMove];
        zombie.position = ccp( screenWidth - 1 , zombie.position.y );
    }
    
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    self.walkRight = nil;
    self.walkLeft = nil;
    self.jump = nil;
    self.kick = nil;
    self.punch = nil;
    
    
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

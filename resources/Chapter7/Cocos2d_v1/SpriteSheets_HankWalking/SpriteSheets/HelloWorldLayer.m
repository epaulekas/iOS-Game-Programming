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

@synthesize walk;

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
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hanksheet_poses.plist"];
        
        zombie = [CCSprite spriteWithSpriteFrameName:@"hank_fighting_default.png"];
        [self addChild: zombie];
        zombie.position = ccp(300, 300 );
        
        
        NSMutableArray *walkingFrames = [NSMutableArray arrayWithCapacity:9];
        for(int i = 1; i <= 9; ++i) {
            
            NSString* file = [NSString stringWithFormat:@"hank_walkforward%i.png", i];
            CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file]; 
            [walkingFrames addObject:frame];
        }
        
        CCAnimation* walkAnimation = [CCAnimation animationWithFrames:walkingFrames delay:0.1f ];
        CCAnimate* animate = [CCAnimate actionWithAnimation:walkAnimation];
        self.walk = [CCRepeatForever actionWithAction:animate];
        [zombie runAction:walk];
        
        
        //[self schedule:@selector(stopTheWalkAction:) interval:2.0f];
                
        // [self schedule:@selector(changeScenes:) interval:6.0f];
        
        
	}
	return self;
}


-(void) stopTheWalkAction:(ccTime)delta {
    
    [zombie stopAction:walk];
    [self unschedule:_cmd];
    
    CCLOG(@"stop walking");
    [self schedule:@selector(restartTheWalkAction:) interval:2.0f];
}

-(void) restartTheWalkAction:(ccTime)delta {
    
    [zombie runAction:walk];
    [self unschedule:_cmd];
    
    CCLOG(@"start walking again");
    [self schedule:@selector(stopTheWalkAction:) interval:2.0f];
}

-(void) changeScenes:(ccTime)delta {
    

    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
    
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [zombie pauseSchedulerAndActions];
    
}


-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [zombie resumeSchedulerAndActions];
    
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{

    
    
    self.walk = nil;
    
    
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

//
//  HelloWorldLayer.m
//  Actions2
//
//  Created by Justin Dike on 6/12/12.
//  Copyright cartoonsmart.com 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

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
        
		farmer = [CCSprite spriteWithFile:@"farmer.png"];
        farmer.position = ccp( screenWidth * .25, 170);
        [self addChild:farmer z:20 tag:12345]; 
        
        farmer2 = [CCSprite spriteWithFile:@"farmer2.png"];
        farmer2.position = ccp( screenWidth * .75, 170);
        [self addChild:farmer2 z:20 tag:54321]; 
        
        
        CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp( screenWidth / 2 , screenHeight /2);
        [self addChild:background z:-5];
        
        
        CCSprite* foreground = [CCSprite spriteWithFile:@"foreground.png"];
        foreground.position = ccp( screenWidth /2 , 50);
        [self addChild:foreground z:10]; 
        
        
        
        //CCSprite* clouds = [CCSprite spriteWithFile:@"clouds.png"];
        
        
        CCSprite* clouds = [CCSprite spriteWithFile:@"clouds.png" rect:CGRectMake(0, 0, screenWidth* 2, screenHeight )];
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};   // to use GL_REPEAT your image size must be a power of two... ( 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048 )
        [clouds.texture setTexParameters:&params];
        clouds.position = ccp( screenWidth , screenHeight /2);
        [self addChild:clouds z:-1]; 
        
        
        CCMoveBy* move = [CCMoveBy actionWithDuration:20.0 position:ccp( screenWidth * -1, 0)];
        CCPlace* place  = [CCPlace actionWithPosition:ccp( screenWidth , screenHeight /2) ];
        CCSequence* cloudSeqence = [CCSequence actions: move, place, nil];
        CCRepeatForever* repeatSequence = [CCRepeatForever actionWithAction:cloudSeqence];
        [clouds runAction:repeatSequence];
        
        
        
        
        CCSprite* clouds2 = [CCSprite spriteWithFile:@"clouds2.png" rect:CGRectMake(0, 0, screenWidth* 2, screenHeight )];
        
        ccTexParams params2 = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT}; // to use GL_REPEAT your image size must be a power of two... ( 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048 )
        [clouds2.texture setTexParameters:&params2];
        clouds2.position = ccp( screenWidth  , screenHeight /2);
        [self addChild:clouds2 z:-3]; 
        
        
         CCMoveBy* move2 = [CCMoveBy actionWithDuration:40.0 position:ccp( screenWidth * -1, 0)];
         CCPlace* place2  = [CCPlace actionWithPosition:ccp(  screenWidth  , screenHeight /2) ];
         CCSequence* cloudSeqence2 = [CCSequence actions: move2, place2, nil];
         CCRepeatForever* repeatSequence2 = [CCRepeatForever actionWithAction:cloudSeqence2];
         [clouds2 runAction:repeatSequence2];
         
         
        
        
	}
	return self;
}




-(void) finishSeq:(id)sender data:(void*)data  {
    
    
    
    CCLOG(@"finished action on %i", (int)data );
    
    
    CCSprite* sprite = (CCSprite*) sender; 
    
    [self removeChild:sprite cleanup:NO]; 
    
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( CGRectContainsPoint(farmer.boundingBox, location) ) {
        
        [self pointsWithPosition:farmer.position andValue:100];
        
    } 
    else if ( CGRectContainsPoint(farmer2.boundingBox, location) ) {
        
        [self labelWithPosition:farmer2.position andValue:100];
    }
    
}



-(void) pointsWithPosition:(CGPoint)pos andValue:(int)value  {
    
    
    CCSprite* points = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%ipoints.png", value ]];
    points.position = ccp( pos.x , pos.y + 100  );
    [self addChild:points];
    
    CCFadeOut* fade = [CCFadeOut actionWithDuration:1.0];
    CCMoveBy* move = [CCMoveBy actionWithDuration:1.0 position:ccp(0, 100)];
    CCCallFuncN* remove =[CCCallFuncN actionWithTarget:self selector:@selector(removePoints:)];
    CCSpawn* spawn = [CCSpawn actions:fade, move, nil];
    CCSequence* sequence = [CCSequence actions:spawn,remove, nil];
    [points runAction:sequence];
    
    
}

-(void) labelWithPosition:(CGPoint)pos andValue:(int)value  {
    
    CCLabelTTF* label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", value] fontName:@"Marker Felt" fontSize:30];
    label.position = ccp( pos.x , pos.y + 100  );
    [self addChild:label];
    
    CCFadeOut* fade = [CCFadeOut actionWithDuration:1.0];
    CCMoveBy* move = [CCMoveBy actionWithDuration:1.0 position:ccp(0, 100)];
    CCEaseOut* ease = [CCEaseOut actionWithAction:move rate:5];
    CCCallFuncN* labelChange =[CCCallFuncN actionWithTarget:self selector:@selector(changeLabel:)];
    CCCallFuncN* remove =[CCCallFuncN actionWithTarget:self selector:@selector(removePoints:)];
    
    
    CCSequence* sequence = [CCSequence actions:ease,labelChange,fade, remove, nil];
    [label runAction:sequence];
    
    
}

-(void) changeLabel:(id) sender {
    
    
    CCLabelTTF* label = (CCLabelTTF*)sender; 
    
    [label setString:@"good!"];
    
}


-(void) removePoints:(id)sender {
    
    CCLOG(@" removing score");
    
    [self removeChild:sender cleanup:NO];
    
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

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end

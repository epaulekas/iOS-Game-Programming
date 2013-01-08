//
//  Preferences.m
//  ScenesAndMenus
//
//  Created by Justin Dike on 7/24/12.
//  Copyright 2012 cartoonsmart.com. All rights reserved.
//

#import "Preferences.h"

#define kMuteSelected 0
#define kMusicSelected 1
#define kArcadeSelected 2
#define kBarSelected 3

static int selection = kMusicSelected;


@implementation Preferences

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Preferences *layer = [Preferences node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        menuPosition = ccp( size.width/2, size.height/2 );
        
        CCSprite *background = [CCSprite spriteWithFile:@"Preferences.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild: background];
        
        
        CCSprite *menuBar = [CCSprite spriteWithFile:@"menu_bar.png"];
        menuBar.position = ccp(size.width/2, size.height/2);
        [self addChild: menuBar];
        
        switch (selection) {
            case kMuteSelected:
                [self createMenuWithMuteSelected];
                break;
            case kMusicSelected:
                [self createMenuWithMusicSelected];
                break;
            case kArcadeSelected:
                [self createMenuWithArcadeSelected];
                break;
            case kBarSelected:
                [self createMenuWithBarSelected];
                break;
            default:
                [self createMenuWithMusicSelected];
                break;
        }
        
        
        self.isTouchEnabled = YES;
        
	}
	return self;
}

-(void) createMenuWithMuteSelected{
    
    selection = kMuteSelected;
    
    
    muteItem = [CCMenuItemImage itemFromNormalImage:@"icon_mute_on.png" selectedImage:@"icon_mute_on.png" target:self selector:@selector(createMenuWithMuteSelected)];
    musicItem = [CCMenuItemImage itemFromNormalImage:@"icon_music_off.png" selectedImage:@"icon_music_on.png" target:self selector:@selector(createMenuWithMusicSelected)];
    arcadeItem = [CCMenuItemImage itemFromNormalImage:@"icon_arcade_off.png" selectedImage:@"icon_arcade_on.png" target:self selector:@selector(createMenuWithArcadeSelected)];
    barItem = [CCMenuItemImage itemFromNormalImage:@"icon_bar_off.png" selectedImage:@"icon_bar_on.png" target:self selector:@selector(createMenuWithBarSelected)];
    
    [self addMenuItems]; 
    
}

-(void) createMenuWithMusicSelected{
    
    selection = kMusicSelected; 
    
    
    
    muteItem = [CCMenuItemImage itemFromNormalImage:@"icon_mute_off.png" selectedImage:@"icon_mute_on.png" target:self selector:@selector(createMenuWithMuteSelected)];
    musicItem = [CCMenuItemImage itemFromNormalImage:@"icon_music_on.png" selectedImage:@"icon_music_on.png" target:self selector:@selector(createMenuWithMusicSelected)];
    arcadeItem = [CCMenuItemImage itemFromNormalImage:@"icon_arcade_off.png" selectedImage:@"icon_arcade_on.png" target:self selector:@selector(createMenuWithArcadeSelected)];
    barItem = [CCMenuItemImage itemFromNormalImage:@"icon_bar_off.png" selectedImage:@"icon_bar_on.png" target:self selector:@selector(createMenuWithBarSelected)];
    
    [self addMenuItems]; 
    
    
    
    
    
}

-(void) createMenuWithArcadeSelected{
    
    selection = kArcadeSelected; 
    
    
    muteItem = [CCMenuItemImage itemFromNormalImage:@"icon_mute_off.png" selectedImage:@"icon_mute_on.png" target:self selector:@selector(createMenuWithMuteSelected)];
    musicItem = [CCMenuItemImage itemFromNormalImage:@"icon_music_off.png" selectedImage:@"icon_music_on.png" target:self selector:@selector(createMenuWithMusicSelected)];
    arcadeItem = [CCMenuItemImage itemFromNormalImage:@"icon_arcade_on.png" selectedImage:@"icon_arcade_on.png" target:self selector:@selector(createMenuWithArcadeSelected)];
    barItem = [CCMenuItemImage itemFromNormalImage:@"icon_bar_off.png" selectedImage:@"icon_bar_on.png" target:self selector:@selector(createMenuWithBarSelected)];
    
    [self addMenuItems]; 
    
}

-(void) createMenuWithBarSelected{
    
    selection = kBarSelected; 
    
    
    muteItem = [CCMenuItemImage itemFromNormalImage:@"icon_mute_off.png" selectedImage:@"icon_mute_on.png" target:self selector:@selector(createMenuWithMuteSelected)];
    musicItem = [CCMenuItemImage itemFromNormalImage:@"icon_music_off.png" selectedImage:@"icon_music_on.png" target:self selector:@selector(createMenuWithMusicSelected)];
    arcadeItem = [CCMenuItemImage itemFromNormalImage:@"icon_arcade_off.png" selectedImage:@"icon_arcade_on.png" target:self selector:@selector(createMenuWithArcadeSelected)];
    barItem = [CCMenuItemImage itemFromNormalImage:@"icon_bar_on.png" selectedImage:@"icon_bar_on.png" target:self selector:@selector(createMenuWithBarSelected)];
    
    [self addMenuItems]; 
    
}

-(void) addMenuItems {
    
    [self removeChild:menu cleanup:NO];
    
    menu = [CCMenu menuWithItems:muteItem, musicItem, arcadeItem, barItem,  nil];
    
    [menu alignItemsHorizontallyWithPadding:0];
    [menu setPosition:menuPosition];
    [self addChild:menu z:10];
    
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if ( location.x > 950 && location.y > 700) {
        
        [[CCDirector sharedDirector] popScene];
        
    }
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    CCLOG(@"removing preferences instance");
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

        
@end

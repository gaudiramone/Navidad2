//
//  PauseScene.m
//  Navidad
//
//  Created by Gaudencio Garcinuño on 20/12/11.
//  Copyright 2011 Gaudencio Garcinuño Muñoz. All rights reserved.
//

#import "PauseScene.h"
#import "HelloWorldLayer.h"


@implementation PauseScene
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        // LABEL CON PAUSA
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Pausa" fontName:@"Marker Felt" fontSize:60];
        label.color=ccRED;
        label.position =  ccp( 140,250 );
        [self addChild: label];
        
        
        // MENU  RESUME y QUIT        
        //Create menu
        [CCMenuItemFont setFontName:@"Marker Felt"]; //type Font
        [CCMenuItemFont setFontSize:35];         // Size font
        
        
        CCMenuItem *Resume  = [CCMenuItemFont itemFromString:@"Continuar" target: self selector:@selector(resume:)];
        CCMenuItem *Quit  = [CCMenuItemFont itemFromString:@"Salir" target: self selector:@selector(GoToMainMenu:)];
        
        
        CCMenu *menu = [CCMenu menuWithItems: Resume, Quit, nil];
        
        menu.position=ccp(140,131.67f);
        [menu alignItemsVerticallyWithPadding:12.5f];
        
        [self addChild: menu];
        
	}
	return self;
}


-(void) resume:(id) sender{
    [[CCDirector sharedDirector] popScene];
    
}


-(void) GoToMainMenu: (id) sender{
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[HelloWorldLayer node]]];
}
@end

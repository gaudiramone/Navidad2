//
//  GameOver.m
//  Navidad
//
//  Created by Gaudencio Garcinuño on 20/12/11.
//  Copyright 2011 Gaudencio Garcinuño Muñoz. All rights reserved.
//

#import "GameOver.h"
#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h" //para poder capturar los toques en la pantalla
#import "Inicio.h"

@implementation GameOver

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOver *layer = [GameOver node];
	
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
        //para que lleve los eventos del touch el método
        self.isTouchEnabled=YES;		
        
        CCLabelTTF *label= [CCLabelTTF labelWithString:@"Juego terminado" fontName:@"Marker Felt" fontSize:40];
        label.position =ccp(170,240);
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Toca la pantalla" fontName:@"Marker Felt" fontSize:35];
        label2.position=ccp(170, 131.67f);
        
        [self addChild:label];
        [self addChild:label2];
        
	}
	return self;
}



-(void) registerWithTouchDispatcher
{
    //queremos que los elementos elegidos utilicen el set standart de eventos del touch
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
}

//SOBREESCRIBIMOS LOS MÉTODOS aqui  Began
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Inicio node]]];
    
    
    return YES;
}
@end

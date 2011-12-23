//
//  Inicio.m
//  Navidad
//
//  Created by Gaudencio Garcinuño on 23/12/11.
//  Copyright 2011 Gaudencio Garcinuño Muñoz. All rights reserved.
//

#import "Inicio.h"
#import "HelloWorldLayer.h"


@implementation Inicio


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Inicio *layer = [Inicio node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)efectoFondo:(CCSprite *) bg {
    // Le ponemos una sondulaciones al fondo
    //id waves = [CCWaves actionWithWaves:5 amplitude:20 horizontal:YES vertical:NO grid:ccg(15,10) duration:5];
    //[bg runAction:[CCRepeatForever actionWithAction:waves]];
    
    //Wawes 3d
    //id waves3d = [CCWaves3D actionWithWaves:5 amplitude:20 grid:ccg(10,15) duration:5];
    //[bg runAction:[CCRepeatForever actionWithAction:waves3d]];   
    
    //Wawes 3d Tiles
    //id waves3dTiles = [CCWavesTiles3D actionWithWaves:5 amplitude:20 grid:ccg(10,15) duration:5];
    //[bg runAction:[CCRepeatForever actionWithAction:waves3dTiles]];
    
    // Le ponemos una ccliquid
    id liquid = [CCLiquid  actionWithWaves:3 amplitude:10 grid:ccg(5,15) duration:5];
    [bg runAction:[CCRepeatForever actionWithAction:liquid]];
    
    // Le ponemos una TWIRL
    //id twirl = [CCTwirl actionWithPosition: CGPointMake(10, 10) twirls:1 amplitude:2 grid:ccg(5,10) duration:5];
    //[bg runAction:[CCRepeatForever actionWithAction:twirl]];
    
    
    // Le pongo un Shaky3D al fondo
    //id shaky = [CCShaky3D actionWithRange:4 shakeZ:NO grid:ccg(10,15) duration:5];
    //[bg runAction:[CCRepeatForever actionWithAction:shaky]];        
    
    
    // Le pongo un FADEOUT TRTIles
    //id fade = [CCFadeOutTRTiles actionWithSize:ccg(10,15) duration:5];
    //[bg runAction:[CCRepeatForever actionWithAction:fade]];
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        
        // FONDO DE ESCRITORIO
        CCSprite *bg = [CCSprite spriteWithFile:@"Fondo2.png"];//enlaza el png a la variable
        CCSprite *bg2=[CCSprite spriteWithFile:@"Fondo2.png"];//enlaza el png a la variable
        
        bg.anchorPoint=ccp(0,0);
        bg.position=ccp(0,0);
        
        bg2.anchorPoint=ccp(0,0);
        bg2.position=ccp(0,-480);
        
        
        
        [self addChild:bg z:0 tag:kTagFondo1]; //Muestra el fondo 
        [self addChild:bg2 z:0 tag:kTagFondo2]; //Muestra el fondo 
        [self efectoFondo:bg];
        // FIN FONDO DE ESCRITORIO
        
        
        
        
        
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Navidad" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , (size.height/2)+200 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        
        
        
        
        
        
        
        // MENU        
        //Create menu
        [CCMenuItemFont setFontName:@"Marker Felt"]; //type Font
        [CCMenuItemFont setFontSize:40];         // Size font
        CCMenuItem *Play  = [CCMenuItemFont itemFromString:@"Empezar" target: self selector:@selector(goToGameplay:)];
        CCMenuItem *Instrucciones= [CCMenuItemFont itemFromString:@"Instrucciones" target: self selector:@selector(showInstrucciones:)];
       
        
        
        CCMenu *menu = [CCMenu menuWithItems: Play,Instrucciones,  nil];
        menu.position=ccp(150,90);
        //esta linea me separa verticalmente los menus
        [menu alignItemsVerticallyWithPadding:20.5f]; 
        [self addChild: menu];

        
        
	}
	return self;
}

-(void) goToGameplay: (id) sender{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:1 scene:[HelloWorldLayer node]]
     ];
}

-(void)showInstrucciones:(id) sender{
    double altoPantalla,anchoPantalla;
    
    //**Tamaño de la pantalla
    CGSize winsize=[[CCDirector sharedDirector] winSize];
    altoPantalla=winsize.height;
    anchoPantalla=winsize.width;
    //**FIN Tamaño de la pantalla
    
    // SANTA
    CCSprite *santa = [CCSprite spriteWithFile:@"santa.png"];//enlaza el png a la variable
    santa.anchorPoint=ccp(0,0);
    santa.position=ccp((anchoPantalla/2.0)- 150.0 ,(altoPantalla/2.0)+100);
    
    [self addChild:santa z:100 tag:kTagSanta]; //Muestra Santa
    // FIN SANTA
    
    
    // create and initialize a Label
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Controla a Santa" fontName:@"Marker Felt" fontSize:30];
    
    
    // position the label on the center of the screen
    label.position =  ccp( 190 , (altoPantalla/2.0)+ 130 );
    
    // add the label as a child to this Layer
    [self addChild: label];
    
    
    
    //Arboles Navidad
    CCSprite *Arbol1 = [CCSprite spriteWithFile:@"Arbol1.png"];//enlaza el png a la variable    
    Arbol1.anchorPoint=ccp(0,0);
    Arbol1.position=ccp(1,250);

    CCSprite *Arbol2 = [CCSprite spriteWithFile:@"Arbol2.png"];//enlaza el png a la variable
    Arbol2.anchorPoint=ccp(0,0);
    Arbol2.position=ccp(50,250);

    
    
    [self addChild:Arbol1 z:101 tag:kTagArbol1]; //Muestra Arbol  
    [self addChild:Arbol2 z:102 tag:kTagArbol2]; //Muestra Arbol 
    // FIN Arboles Navidad
    
    
    // create and initialize a Label
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Esquivalos!" fontName:@"Marker Felt" fontSize:30];
    
    
    // position the label on the center of the screen
    label2.position =  ccp( 190 , 290 );
    
    // add the label as a child to this Layer
    [self addChild: label2];   
    
    
    //Regalos de Navidad
    CCSprite *Regalo1 = [CCSprite spriteWithFile:@"regalo1.png"];//enlaza el png a la variable
    
    Regalo1.anchorPoint=ccp(0,0);
    Regalo1.position=ccp(1 , 190);
    
    CCSprite *Regalo2 = [CCSprite spriteWithFile:@"regalo2.png"];//enlaza el png a la variable    
    Regalo2.anchorPoint=ccp(0,0);
    Regalo2.position=ccp(50,190);
    
    [self addChild:Regalo1 z:103 tag:kTagRegalo1]; //Muestra Arbol  
    [self addChild:Regalo2 z:104 tag:kTagRegalo2]; //Muestra Arbol 
    //FIN Regalos de Navidad
    
    
    // create and initialize a Label
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Recogelos!" fontName:@"Marker Felt" fontSize:30];
    
    
    // position the label on the center of the screen
    label3.position =  ccp( 190 , 220 );
    
    // add the label as a child to this Layer
    [self addChild: label3]; 
    
    
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end

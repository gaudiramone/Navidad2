//
//  HelloWorldLayer.m
//  Navidad
//
//  Created by Gaudencio Garcinuño on 19/12/11.
//  Copyright Gaudencio Garcinuño Muñoz 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "GameOver.h"
#import "PauseScene.h"
#import "CCTouchDispatcher.h" //para poder capturar los toques en la pantalla


// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize altoPantalla,anchoPantalla;
@synthesize XOri,YOri;
@synthesize arbol1IsRunning, arbol2IsRunning;
@synthesize regalo1IsRunning, regalo2IsRunning;

@synthesize puntos;

CCLabelTTF *label;

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
    //**Tamaño de la pantalla
        CGSize winsize=[[CCDirector sharedDirector] winSize];
        altoPantalla=winsize.height;
        anchoPantalla=winsize.width;
        NSLog(@"Tamaño de la pantalla %fx%f", altoPantalla,anchoPantalla);
    //**FIN Tamaño de la pantalla

    // FONDO DE ESCRITORIO
        CCSprite *bg = [CCSprite spriteWithFile:@"Fondo2.png"];//enlaza el png a la variable
        CCSprite *bg2=[CCSprite spriteWithFile:@"Fondo2.png"];//enlaza el png a la variable
        
        bg.anchorPoint=ccp(0,0);
        bg.position=ccp(0,0);
        
        bg2.anchorPoint=ccp(0,0);
        bg2.position=ccp(0,-480);
        
        //arranca la acción
        [bg runAction:[CCMoveTo actionWithDuration:10 position:ccp(0,480)]];
        [bg2 runAction:[CCMoveTo actionWithDuration:10 position:ccp(0,0)]];

        
        
        [self addChild:bg z:0 tag:kTagFondo1]; //Muestra el fondo 
        [self addChild:bg2 z:0 tag:kTagFondo2]; //Muestra el fondo 
        //[self addChild:bg2 z:0]; //Muestra el fondo        
    // FIN FONDO DE ESCRITORIO

        
        //Ponemos el botón de pause arriba a la izquierda  
        CCMenuItem *Pause  = [CCMenuItemImage itemFromNormalImage:@"pausebutton.png" selectedImage:@"pausebutton.png" target:self selector:@selector(pause:)];
        CCMenu *PauseButton = [CCMenu menuWithItems: Pause,nil];
        PauseButton.position =ccp(25,altoPantalla - 20);
        [self addChild:PauseButton z:1000];
        //--- fin del botón de pausa ---        
        
        
    // SANTA
        CCSprite *santa = [CCSprite spriteWithFile:@"santa.png"];//enlaza el png a la variable
        santa.anchorPoint=ccp(0,0);
        santa.position=ccp((anchoPantalla/2.0)- 25.0 ,(altoPantalla/2.0));
    
        [self addChild:santa z:100 tag:kTagSanta]; //Muestra Santa
    // FIN SANTA
        
        
    //Arboles Navidad
        CCSprite *Arbol1 = [CCSprite spriteWithFile:@"Arbol1.png"];//enlaza el png a la variable
        CGSize arbol1Size = [Arbol1 contentSize];

        Arbol1.anchorPoint=ccp(0,0);
        int posAleatoria;
        posAleatoria = fmod(arc4random() , anchoPantalla - arbol1Size.width);
        Arbol1.position=ccp(posAleatoria , -arbol1Size.height);
        arbol1IsRunning=FALSE;

        CCSprite *Arbol2 = [CCSprite spriteWithFile:@"Arbol2.png"];//enlaza el png a la variable
        CGSize arbol2Size = [Arbol2 contentSize];
        Arbol2.anchorPoint=ccp(0,0);
        posAleatoria = fmod(arc4random() , anchoPantalla - arbol2Size.width);
        Arbol2.position=ccp(posAleatoria, - arbol2Size.height);
        arbol2IsRunning=FALSE;

        
        [self addChild:Arbol1 z:101 tag:kTagArbol1]; //Muestra Arbol  
        [self addChild:Arbol2 z:102 tag:kTagArbol2]; //Muestra Arbol 
    // FIN Arboles Navidad
        
    //Regalos de Navidad
        CCSprite *Regalo1 = [CCSprite spriteWithFile:@"regalo1.png"];//enlaza el png a la variable
        CGSize regalo1Size = [Regalo1 contentSize];
        
        Regalo1.anchorPoint=ccp(0,0);
        posAleatoria = fmod(arc4random() , anchoPantalla - regalo1Size.width);
        Regalo1.position=ccp(posAleatoria , altoPantalla);
        [self setRegalo1IsRunning:FALSE];
        
        CCSprite *Regalo2 = [CCSprite spriteWithFile:@"regalo2.png"];//enlaza el png a la variable
        CGSize regalo2Size = [Regalo2 contentSize];
        
        Regalo2.anchorPoint=ccp(0,0);
        posAleatoria = fmod(arc4random() , anchoPantalla - regalo2Size.width);
        Regalo2.position=ccp(posAleatoria , altoPantalla);
        [self setRegalo2IsRunning:FALSE];
        
        [self addChild:Regalo1 z:103 tag:kTagRegalo1]; //Muestra Arbol  
        [self addChild:Regalo2 z:104 tag:kTagRegalo2]; //Muestra Arbol 
    //FIN Regalos de Navidad
        

        
    //PUNTOS
        // LABEL CON PAUSA
        label = [CCLabelTTF labelWithString:@"000" fontName:@"Marker Felt" fontSize:30];
        label.color=ccRED;
        label.position =  ccp( anchoPantalla-30,altoPantalla-20 );
        [self addChild: label];
                
        [self setPuntos:0];
        
        
    //FIN Puntos
    
        
        
        //crea la agenda para el fondo
        [self schedule:@selector(nextFrame:)];
        
        //crea una agenda para los arboles
        [self schedule:@selector(gestionArboles:) interval: .03];
        
        //crea una agenda para los regalos
        [self schedule:@selector(gestionRegalos:) interval: 1];
        
        //creamos un schedule para que llame a la función De las colisiones
        [self schedule:@selector(SpritesDidColide) interval:.01];
        
    }
    
    //para que lleve los eventos del touch el método
    self.isTouchEnabled=YES;
    
	return self;
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





-(void)spriteArbol1EmpiezaMove:(id)sender{
    arbol1IsRunning = YES;
}
-(void)spriteArbol1TerminaMove:(id)sender{
    CCNode *a1 =[self getChildByTag:kTagArbol1];  // arbol tipo 1
    CGSize a1Size = [a1 contentSize];
    
    int posAleatoria;
    posAleatoria = fmod(arc4random() , anchoPantalla-(a1Size.width));
    a1.position=ccp(posAleatoria , -(a1Size.height));
    
    arbol1IsRunning = FALSE;
}
-(void)spriteArbol2EmpiezaMove:(id)sender{
    arbol2IsRunning = YES;
}
-(void)spriteArbol2TerminaMove:(id)sender{
    CCNode *a2 =[self getChildByTag:kTagArbol2];  // arbol tipo 2
    CGSize a2Size = [a2 contentSize];

    
    int posAleatoria;
    posAleatoria = fmod(arc4random() , anchoPantalla-(a2Size.width));
    a2.position=ccp(posAleatoria , -a2Size.height);
    
    arbol2IsRunning = FALSE;
}



-(void) gestionArboles:(ccTime)dt{
    CCNode *a1 =[self getChildByTag:kTagArbol1];  // arbol tipo 1
    CCNode *a2 =[self getChildByTag:kTagArbol2];  // arbol tipo 2
    
    
//Arbol1
    if (!arbol1IsRunning){
        int probabilidadSacaArbol1;
        probabilidadSacaArbol1 = fmod(arc4random() , 5);// una de cada 5
        if (probabilidadSacaArbol1==0){
            id action1 = [CCMoveTo actionWithDuration:5 position:ccp(a1.position.x,altoPantalla)];
            id actionEmpiezaArbol1 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteArbol1EmpiezaMove:)];
            id actionTerminaArbol1 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteArbol1TerminaMove:)];
            
            [a1 runAction:[CCSequence actions: actionEmpiezaArbol1,action1, actionTerminaArbol1, nil]];   
        }
    } // ENDIF de No esta Corriendo
    
    
//Arbol2
    if (!arbol2IsRunning){
        int probabilidadSacaArbol2;
        probabilidadSacaArbol2 = fmod(arc4random() , 5);// una de cada 5
        if(probabilidadSacaArbol2==0){
            id action2 = [CCMoveTo actionWithDuration:3 position:ccp(a2.position.x,altoPantalla)];
            id actionEmpiezaArbol2 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteArbol2EmpiezaMove:)];
            id actionTerminaArbol2 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteArbol2TerminaMove:)];
            
            [a2 runAction:[CCSequence actions: actionEmpiezaArbol2,action2, actionTerminaArbol2, nil]]; 
        }

    }
    
    
}





-(void)spriteRegalo1EmpiezaMove:(id)sender{
    regalo1IsRunning = YES;
}
-(void)spriteRegalo1TerminaMove:(id)sender{
    CCNode *a1 =[self getChildByTag:kTagRegalo1];  // arbol tipo 1
    CGSize a1Size = [a1 contentSize];
    
    int posAleatoria;
    posAleatoria = fmod(arc4random() , anchoPantalla-(a1Size.width));
    a1.position=ccp(posAleatoria , altoPantalla);
    
    regalo1IsRunning = FALSE;
}
-(void)spriteRegalo2EmpiezaMove:(id)sender{
    regalo2IsRunning = YES;
}
-(void)spriteRegalo2TerminaMove:(id)sender{
    CCNode *a2 =[self getChildByTag:kTagRegalo2];  // arbol tipo 2
    CGSize a2Size = [a2 contentSize];
    
    
    int posAleatoria;
    posAleatoria = fmod(arc4random() , anchoPantalla-(a2Size.width));
    a2.position=ccp(posAleatoria , altoPantalla);
    
    regalo2IsRunning = FALSE;
}

-(void) gestionRegalos:(ccTime)dt{
    CCNode *a1 =[self getChildByTag:kTagRegalo1];  // regalo tipo 1
    CCNode *a2 =[self getChildByTag:kTagRegalo2];  // regalo tipo 2
    
    
    //Regalo1
    if (!regalo1IsRunning){
        int probabilidadSacaRegalo1;
        probabilidadSacaRegalo1 = fmod(arc4random() , 5);// una de cada 5
        if (probabilidadSacaRegalo1==0){
            id action1 = [CCMoveTo actionWithDuration:5 position:ccp(a1.position.x,0)];
            id actionEmpiezaRegalo1 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteRegalo1EmpiezaMove:)];
            id actionTerminaRegalo1 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteRegalo1TerminaMove:)];
            
            [a1 runAction:[CCSequence actions: actionEmpiezaRegalo1,action1, actionTerminaRegalo1, nil]];   
        }
    } // ENDIF de No esta Corriendo
    
    
    //Regalo2
    if (!regalo2IsRunning){
        int probabilidadSacaRegalo2;
        probabilidadSacaRegalo2 = fmod(arc4random() , 5);// una de cada 5
        if(probabilidadSacaRegalo2==0){
            id action2 = [CCMoveTo actionWithDuration:3 position:ccp(a2.position.x,0)];
            id actionEmpiezaRegalo2 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteRegalo2EmpiezaMove:)];
            id actionTerminaRegalo2 = [CCCallFuncN actionWithTarget:self 
                                                          selector:@selector(spriteRegalo2TerminaMove:)];
            
            [a2 runAction:[CCSequence actions: actionEmpiezaRegalo2,action2, actionTerminaRegalo2, nil]]; 
        }
        
    }
    
    
}

-(void)terminaAgendas{
    [self unschedule:@selector(SpritesDidColide)];
    [self unschedule:@selector(nextFrame:)];
    [self unschedule:@selector(gestionArboles:)];
    [self unschedule:@selector(gestionRegalos:)];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameOver node]]];
}

-(float) dameDistancia:(CCNode *)hero Atacante:(CCNode *)enemy{
    
    //calculo las distancias
    float xDif = enemy.position.x - hero.position.x;
    float yDif = enemy.position.y - hero.position.y;
    float distancia = sqrtf(xDif*xDif + yDif*yDif);
    
    return (distancia);
    
}


-(void)sumaPunto:(int)inc elRegalo:(CCNode *)regalo{
    [self setPuntos:[self puntos]+inc];
    [label setString:[NSString stringWithFormat:@"%00d",puntos]];
    
    
    [regalo stopAllActions];
    
    CGSize regaloSize = [regalo contentSize];
    int posAleatoria = fmod(arc4random() , anchoPantalla - regaloSize.width);
    
    [regalo setPosition:ccp(posAleatoria,altoPantalla)];
    
}

//Detecta las colisiones
-(void)  SpritesDidColide{
    CCNode *santa=[self getChildByTag:kTagSanta];
    CCNode *arbol1 =[self getChildByTag:kTagArbol1];
    CCNode *arbol2 =[self getChildByTag:kTagArbol2];
    CCNode *regalo1 =[self getChildByTag:kTagRegalo1];
    CCNode *regalo2 =[self getChildByTag:kTagRegalo2];



    if ([self dameDistancia:santa Atacante:arbol1] < 45)
        [self terminaAgendas];
    
    if ([self dameDistancia:santa Atacante:arbol2] < 45)
        [self terminaAgendas];
   
    if ([self dameDistancia:santa Atacante:regalo1] < 45){
        regalo1IsRunning = FALSE;
        [self sumaPunto:1 elRegalo:regalo1];
    }
    if ([self dameDistancia:santa Atacante:regalo2] < 45){
        regalo2IsRunning = FALSE;
        [self sumaPunto:5 elRegalo:regalo2];
    }
    
    
}




//Esta será la función metida en la agenda para que se ejecute cada cierto tiempo.
-(void) nextFrame:(ccTime)dt{
    CCNode *b1 =[self getChildByTag:kTagFondo1];
    CCNode *b2 =[self getChildByTag:kTagFondo2];
    
    
    //El movimiento de Santa
    if (b1.position.y>=480){
    //CGPoint location = fondo.position;
    
        [b1 stopAllActions];
        [b2 stopAllActions];

        b1.position=ccp(0,0);  
        b2.position=ccp(0,-480);
        [b1 runAction:[CCMoveTo actionWithDuration:10 position:ccp(0,480)]];
        [b2 runAction:[CCMoveTo actionWithDuration:10 position:ccp(0,0)]];        
        }
    
    
}


-(void) registerWithTouchDispatcher
{
    //queremos que los elementos elegidos utilicen el set standart de eventos del touch
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
}


//SOBREESCRIBIMOS LOS MÉTODOS aqui  Began, Ended , Moved
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    //COORD a local
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    //GUardo los valores
    XOri = location.x;
    
    
    return YES;
}
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    //COORD a local
    CGPoint location = [self convertTouchToNodeSpace:touch];
    float XLocal, YLocal;
    float XDelta;

    //get santa position
    CCNode *santa = [self getChildByTag:kTagSanta];
    
    XDelta =  location.x - XOri;// lo que se ha desplazado
    XLocal=santa.position.x+XDelta;
    YLocal=santa.position.y;
    
    //NSLog(@"XLocal %f", XLocal);
    //fix Xlocal
    if (XLocal<=0) XLocal=0;
    if (XLocal>=(anchoPantalla-55)) XLocal=anchoPantalla-55;

    
    //set Santa position with new pos
    santa.position= ccp(XLocal,YLocal);
    
    //set New Origen X & Y
    XOri = location.x;
    
    
    //Set Acctions
    [santa stopAllActions];
    [santa runAction:[CCMoveTo actionWithDuration:10 position:ccp(XLocal,YLocal)]];
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
}


-(void) pause :(id) sender {
    
    [[CCDirector sharedDirector] pushScene:[PauseScene node]];
}

@end

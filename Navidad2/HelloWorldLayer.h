//
//  HelloWorldLayer.h
//  Navidad
//
//  Created by Gaudencio Garcinuño on 19/12/11.
//  Copyright Gaudencio Garcinuño Muñoz 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"



enum{
    kTagFondo1,
    kTagFondo2,
    kTagArbol1,
    kTagArbol2,
    kTagSanta,
    kTagRegalo1,
    kTagRegalo2,
    kTagActionRegalo1,
    kTagActionRegalo2
};
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    double contador;

}

@property (nonatomic) double altoPantalla,anchoPantalla;
@property (nonatomic) BOOL arbol1IsRunning,arbol2IsRunning;
@property (nonatomic) BOOL regalo1IsRunning,regalo2IsRunning;


@property (nonatomic) double XOri,YOri;
@property (nonatomic) int puntos;




// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

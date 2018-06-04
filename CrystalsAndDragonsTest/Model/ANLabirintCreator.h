//
//  ANLabirintCreator.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANLabyrinth;

@interface ANLabirintCreator : NSObject

+(ANLabirintCreator *) getCreateLabirinthManager;
-(ANLabyrinth *) createLabirinth:(NSInteger)x :(NSInteger)y;

@end

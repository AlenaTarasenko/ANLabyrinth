//
//  ANPlayer.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANItem.h"

@interface ANPlayer : NSObject

@property (strong, nonatomic) NSMutableArray *itemArray;
@property (assign, nonatomic) NSInteger hitPointer;
@property (assign, nonatomic) unsigned int xPosition;
@property (assign, nonatomic) unsigned int yPosition;

+(ANPlayer *) getPlayer;
-(void)addItem:(ANItem *)item;
-(void)deleteItem:(ANItem *)item;
-(ANItem *)deleteItemWithTag:(NSInteger) tag;
-(void) saveCoordinatesX:(NSInteger)x andY:(NSInteger)y;

@end

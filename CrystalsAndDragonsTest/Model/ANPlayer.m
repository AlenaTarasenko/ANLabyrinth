//
//  ANPlayer.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANPlayer.h"

@implementation ANPlayer

- (instancetype)init
{
    self = [super init];
    if (self){
        _itemArray = [NSMutableArray array];
        _hitPointer = 0;
    }
    return self;
}

+(ANPlayer *) getPlayer{
    static ANPlayer *player = nil;
    if(!player){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            player = [[ANPlayer alloc] init];
        });
    }
    return player;
}

-(void)addItem:(ANItem *)item{
    [self.itemArray addObject:item];
}

-(void)deleteItem:(ANItem *)item{
     [self.itemArray removeObject:item];
}

-(ANItem *)deleteItemWithTag:(NSInteger) tag{
    ANItem * curentItem;
    for(ANItem * tempItem in self.itemArray){
        if(tempItem.tag == tag){
            curentItem = tempItem;
            [self.itemArray removeObject:tempItem];
            break;
        }
    }
    return curentItem;
}

-(void) saveCoordinatesX:(NSInteger)x andY:(NSInteger)y{
    self.xPosition = (uint)x;
    self.yPosition = (uint)y;
}
@end

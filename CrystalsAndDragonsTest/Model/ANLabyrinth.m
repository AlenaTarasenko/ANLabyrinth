//
//  ANLabyrinth.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANLabyrinth.h"
#import "ANRoom.h"

@implementation ANLabyrinth

- (instancetype)init
{
    return [self initWithX:3 andY:3];
}

- (instancetype) initWithX:(NSInteger)x andY:(NSInteger)y{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

@end

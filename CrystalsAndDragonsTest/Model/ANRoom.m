//
//  ANRoom.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANRoom.h"

@implementation ANRoom

- (instancetype)init
{
    self = [super init];
    if (self) {
        _northRoom = nil;
        _southRoom = nil;
        _westRoom  = nil;
        _eastRoom  = nil;
        _color = 0;
    }
    return self;
}

@end

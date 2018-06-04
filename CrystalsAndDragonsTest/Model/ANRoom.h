//
//  ANRoom.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANItem.h"

@interface ANRoom : NSObject

@property (strong, nonatomic) ANRoom *northRoom;
@property (strong, nonatomic) ANRoom *southRoom;
@property (strong, nonatomic) ANRoom *westRoom;
@property (strong, nonatomic) ANRoom *eastRoom;
@property (assign, nonatomic) NSInteger x;
@property (assign, nonatomic) NSInteger y;
@property (strong, nonatomic) ANItem *item;
@property (assign,nonatomic)  NSInteger color;

@end


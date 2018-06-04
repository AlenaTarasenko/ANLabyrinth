//
//  ANLabyrinth.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANRoom;

@interface ANLabyrinth : NSObject


@property (assign,nonatomic) NSInteger x;
@property (assign,nonatomic) NSInteger y;
@property (strong, nonatomic) NSMutableArray *roomArray;

- (instancetype)initWithX:(NSInteger)x andY:(NSInteger)y;


@end

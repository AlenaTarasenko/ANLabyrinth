//
//  ANLabirintCreator.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 10.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANLabirintCreator.h"
#import "ANLabyrinth.h"
#import "ANRoom.h"
#import "ANPlayer.h"
#import "ANItem.h"
#import "ANTagResource.h"
#import <UIKit/UIKit.h>


@interface ANLabirintCreator ()

@property (strong, nonatomic) ANLabyrinth * labyrinth;
@property (strong, nonatomic) NSArray * namesItem;
@property (assign, nonatomic) CGPoint firstPoint;

@end

@implementation ANLabirintCreator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _namesItem = @[@"box", @"key", @"boun", @"shroom", @"stone"];
    }
    return self;
}

+(ANLabirintCreator *) getCreateLabirinthManager{
    static ANLabirintCreator *manager = nil;
    if(!manager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[ANLabirintCreator alloc] init];
        });
    }
    return manager;
}

-(ANLabyrinth *) createLabirinth:(NSInteger)x :(NSInteger)y{
    self.labyrinth = [[ANLabyrinth alloc] initWithX:x andY:y];
    self.labyrinth.roomArray = [NSMutableArray array];
            for(int i=0; i<x; ++i){
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int j=0; j<y; ++j) {
                    ANRoom * room = [[ANRoom alloc] init];
                    room.x =i;
                    room.y =j;
                    [tempArray addObject:room];
                }
                [self.labyrinth.roomArray addObject:tempArray];
            }
    [self createWallInLabyrint];
    [self insertItem];
    return self.labyrinth;
}

-(void) printLabyrinth{
    for(int i=0; i<self.labyrinth.x; ++i){
        NSMutableArray *tempArray = [self.labyrinth.roomArray objectAtIndex:i];
        NSString *string = @" ";
        for (ANRoom *room in tempArray) {
            NSString *temp = [NSString stringWithFormat:@"%ld ", room.color];
            string = [NSString stringWithFormat:@"%@ %@",string, temp];
        }
        NSLog(@"%@", string);
    }
}

-(void) createWallInLabyrint{
    NSInteger i = self.labyrinth.x;
    NSInteger j = self.labyrinth.y;
    NSMutableArray *stac = [NSMutableArray array];
    NSMutableArray *roomArray = self.labyrinth.roomArray;
    NSArray *arrayNeighboursRoom;
    //algorithm
    //получим первую ячейку и занесем ее в стек
    NSInteger xFirstRoom = arc4random_uniform((int32_t)i);
    NSInteger yFirstRoom = arc4random_uniform((int32_t)j);
    [[ANPlayer getPlayer] saveCoordinatesX:xFirstRoom andY:yFirstRoom];
    [ANPlayer getPlayer].hitPointer = i*j*2;
    //текущая ячейка = первой ячейке
    self.firstPoint = CGPointMake(xFirstRoom, yFirstRoom);
    ANRoom *firstRoom = [[roomArray objectAtIndex:xFirstRoom] objectAtIndex:yFirstRoom];
    ANRoom *curentRoom = firstRoom;
    //добавим первуюячейку на стек
    [stac addObject:firstRoom];
    firstRoom.color = 1;
    //пока в стеке есть элемент
    while (stac.count != 0) {
        //получим смежные серые ячейки
        arrayNeighboursRoom = [self getNeighboursForRoom:curentRoom];
        
        if (arrayNeighboursRoom.count != 0){
            int rand = arc4random_uniform((unsigned int)(arrayNeighboursRoom.count-1)*100)/100;
            ANRoom *nextRoom = [arrayNeighboursRoom objectAtIndex:rand];
            //Create the door
            [self createTheDoorFrom:curentRoom intoThe:nextRoom];
            curentRoom = nextRoom;
            curentRoom.color = 1;
            [stac  addObject:curentRoom];
        }else{
            curentRoom.color = 4;
            [stac removeObject:[stac lastObject]];
            curentRoom = [stac lastObject];
        }
    }
    curentRoom.color = 4;
}

-(NSArray *) getNeighboursForRoom:(ANRoom *) curentRoom {
    NSMutableArray *arrayNeighbours = [NSMutableArray array];
    NSMutableArray *roomArray = self.labyrinth.roomArray;
    NSArray * pointArray = [self getPointArrayForX:curentRoom.x
                                              andY:curentRoom.y];
    //проверяем, не выходят ли координаты смежных ячеек за границы массива
    //и является ли смежная ячейка серой(не посещалась)
    for(NSValue *value in pointArray){
        CGPoint p = [value CGPointValue];
        if( p.x>=0 && p.x<self.labyrinth.x && p.y>=0 && p.y<self.labyrinth.y){
            ANRoom * tempRoom = [[roomArray objectAtIndex:p.x] objectAtIndex:p.y];
            if (tempRoom.color == 0){
                [arrayNeighbours addObject: tempRoom];
            }
        }
    }
    return arrayNeighbours;
}

//массив из координат для смежных ячеек
-(NSArray *) getPointArrayForX:(NSInteger) x andY:(NSInteger) y {
    CGPoint  pointUp ;
    pointUp.x = x-1;
    pointUp.y = y;
    CGPoint  pointDoun ;
    pointDoun.x = x+1;
    pointDoun.y = y;
    CGPoint  pointLeft ;
    pointLeft.x = x;
    pointLeft.y = y-1;
    CGPoint  pointRight ;
    pointRight.x = x;
    pointRight.y = y+1;
    NSArray * pointArray = @[[NSValue  valueWithCGPoint : pointUp],
                                    [NSValue valueWithCGPoint: pointDoun],
                                    [NSValue valueWithCGPoint: pointLeft],
                                    [NSValue valueWithCGPoint: pointRight]];
    return pointArray;
}

- (void) createTheDoorFrom:(ANRoom *) roomA intoThe:(ANRoom *) roomB{
    if (roomA.x>roomB.x){
        roomA.northRoom = roomB;
        roomB.southRoom = roomA;
    }
    if (roomA.x<roomB.x){
        roomA.southRoom = roomB;
        roomB.northRoom = roomA;
    }
    if (roomA.y>roomB.y){
        roomA.westRoom = roomB;
        roomB.eastRoom = roomA;
    }
    if (roomA.y<roomB.y){
        roomA.eastRoom = roomB;
        roomB.westRoom = roomA;
    }
}

-(void)insertItem{
    for(NSString *nameItem in self.namesItem){
        ANItem *item = [[ANItem alloc] init];
        item.name = nameItem;
        if([nameItem isEqualToString:@"key"]){
            item.tag = 10;
        }
        else if([nameItem isEqualToString:@"box"]){
            item.tag = 11;
        }
        else if([nameItem isEqualToString:@"boun"]){
            item.tag = 12;
        }
        else if([nameItem isEqualToString:@"shroom"]){
            item.tag = 13;
        }
        else if([nameItem isEqualToString:@"stone"]){
            item.tag = 14;
        }
        [self loadItemInRoom:item];
    }
}

-(void) loadItemInRoom:(ANItem*)item{
    BOOL f = NO;
    while (!f){
        int x = arc4random_uniform((uint32_t)self.labyrinth.x);
        int y = arc4random_uniform((uint32_t)self.labyrinth.y);
        ANRoom * tempRoom =[[self.labyrinth.roomArray objectAtIndex:x] objectAtIndex:y];
        if (!tempRoom.item){
            f=YES;
            tempRoom.item = item;
        }
    }
}

@end

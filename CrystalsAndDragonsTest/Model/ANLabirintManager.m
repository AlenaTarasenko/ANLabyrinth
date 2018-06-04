//
//  ANLabirintManager.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANLabirintManager.h"
#import "ANLabyrinth.h"
#import "ANLabirintCreator.h"
#import "ANPlayer.h"
#import "ANRoom.h"

@interface ANLabirintManager ()

@property (strong,nonatomic) ANLabirintCreator * creator ;
@property (strong, nonatomic)  ANRoom * curentRoom;

@end

@implementation ANLabirintManager

+(ANLabirintManager *) getLabirintManager{
   static ANLabirintManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager =[[ANLabirintManager alloc] init];
    });
    return manager;
}

-(ANLabyrinth *) createLabyrinthWithWidth:(NSInteger)x andHight:(NSInteger)y {
    self.creator = [ANLabirintCreator getCreateLabirinthManager];
    self.labyrinth = [self.creator createLabirinth:x :y];
    self.player = [ANPlayer getPlayer];
    self.curentRoom = [[self.labyrinth.roomArray objectAtIndex:self.player.xPosition] objectAtIndex:self.player.yPosition];
    return self.labyrinth;
}

-(ANRoom*) getCurentRoom{
    return self.curentRoom;
}

-(void) chandeCurentRoomToRoom:(ANRoom*) newRoom{
    self.player.xPosition = newRoom.x;
    self.player.yPosition = newRoom.y;
    self.curentRoom = newRoom;
    
}

@end

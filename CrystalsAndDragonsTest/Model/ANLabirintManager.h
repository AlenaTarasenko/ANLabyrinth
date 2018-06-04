//
//  ANLabirintManager.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANLabyrinth;
@class ANPlayer;
@class ANRoom;

@interface ANLabirintManager : NSObject

@property (strong, nonatomic)  ANLabyrinth  *labyrinth;
@property (strong, nonatomic)  ANPlayer     *player;


+(ANLabirintManager * ) getLabirintManager;
-(void) createLabyrinthWithWidth:(NSInteger) x andHight:(NSInteger) y;
-(ANRoom *) getCurentRoom;
-(void) chandeCurentRoomToRoom:(ANRoom *) newRoom;


@end

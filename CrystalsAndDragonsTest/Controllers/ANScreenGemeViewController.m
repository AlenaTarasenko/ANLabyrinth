//
//  ANScreenGemeViewController.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANScreenGemeViewController.h"
#import "ANPlayer.h"
#import "ANLabirintManager.h"
#import "ANRoom.h"
#import "ANLabyrinth.h"
#import "ANRoutsView.h"
#import "ANTagResource.h"

#import "ANItemView.h"
 //[view removeFromSuperview];

@class ANItem;

@interface ANScreenGemeViewController ()

@property (weak, nonatomic) IBOutlet UIView *bagView;
@property (strong, nonatomic) ANLabirintManager * manager;
@property (strong, nonatomic) ANRoom * curentRoom;
@property (strong, nonatomic) ANPlayer * player;
@property (strong, nonatomic) NSArray * routeViewArray;
@property (strong, nonatomic) NSMutableArray * itemViewArrayInRoom;
@property (strong, nonatomic) NSMutableArray * itemViewArrayInBag;
@property (weak,   nonatomic) UIView * draggingView;
@property (assign, nonatomic) CGPoint deltaPoint;
@property (weak,   nonatomic) UIView * draggingViewInBag;
@property (assign, nonatomic) BOOL movingFlag;

@end

@implementation ANScreenGemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stoneWall1.png"]]];
    self.manager = [ANLabirintManager getLabirintManager];
    self.player = [ANPlayer getPlayer];
    self.curentRoom = [self.manager getCurentRoom];
    //create View
   self.routeViewArray =  [ANRoutsView drawRoutsViewForRoom:self.curentRoom OnView:self.view];
    self.itemViewArrayInBag = [ANItemView  drowItemInBag:self.bagView onRootView:self.view forePlayer:self.player];
    if (self.curentRoom.item){
       self.itemViewArrayInRoom =  [ANItemView drowItem:self.curentRoom.item onView:self.view];
    }
    self.player.hitPointer --;
    self.hitPointLabel.text = [NSString stringWithFormat:@"%ld", (long)self.player.hitPointer];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    self.movingFlag = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    UIView *resultView = [self.view hitTest:point withEvent:event];
    [self.view bringSubviewToFront:resultView];
    ANRoom *newRoom ;
    if(!([resultView isEqual:self.view]) && resultView.tag != 11){
        if([self.routeViewArray containsObject: resultView ]){
            if(self.player.hitPointer ==0){
                [self performSegueWithIdentifier:@"endNavigation" sender:nil];
            }
            switch (resultView.tag) {
                case 1:
                    newRoom =self.curentRoom.northRoom;
                    break;
                case 4:
                    newRoom = self.curentRoom.eastRoom;
                    break;
                case 3:
                    newRoom = self.curentRoom.southRoom;
                    break;
                case 2:
                    newRoom = self.curentRoom.westRoom;
                    break;
                default:
                    return;
                    break;
            }
            [self.manager chandeCurentRoomToRoom:newRoom];
            self.curentRoom = [self.manager getCurentRoom];
         //   gameNavigation
           [self performSegueWithIdentifier:@"gameNavigation" sender:nil];
        }
        else if([self.itemViewArrayInRoom containsObject: resultView ]){
            self.draggingView = resultView;
            CGPoint tachPoint = [touch locationInView:self.draggingView];
            self.deltaPoint = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - tachPoint.x,
                                          CGRectGetMidY(self.draggingView.bounds) - tachPoint.y) ;
        }
        else if([self.itemViewArrayInBag containsObject: resultView]){
            self.draggingViewInBag = resultView;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    self.movingFlag = YES;
    if(self.draggingView){
        UITouch *touch = [touches anyObject];
        CGPoint pointOnMainView = [touch locationInView:self.view];
        self.draggingView.center = CGPointMake(pointOnMainView.x + self.deltaPoint.x,
                                               pointOnMainView.y + self.deltaPoint.y);
    }
    if(self.draggingViewInBag){
        UITouch *touch = [touches anyObject];
        CGPoint pointOnMainView = [touch locationInView:self.view];
        self.draggingViewInBag.center =CGPointMake(pointOnMainView.x ,
                                                   pointOnMainView.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    //из комнаты в сумку
    if(self.draggingView){
        UITouch *touch = [touches anyObject];
        CGPoint pointOnBagView = [touch locationInView:self.bagView];
        if (pointOnBagView.y>-45 || !self.movingFlag){
            [self.draggingView removeFromSuperview];
            [self.player addItem:self.curentRoom.item];
            self.curentRoom.item = nil;
            [self.draggingView removeFromSuperview];
            for(UIView *temp in self.itemViewArrayInBag){
                [temp removeFromSuperview];
            }
            self.itemViewArrayInBag = [ANItemView drowItemInBag:self.bagView
                                                     onRootView:self.view
                                                     forePlayer:self.player];
        }
        self.draggingView = nil;
    }
    //из сумки
    if(self.draggingViewInBag){
        UITouch *touch = [touches anyObject];
        CGPoint pointOnBagView = [touch locationInView:self.bagView];
        if(self.draggingViewInBag.tag == 10  && [self.curentRoom.item.name isEqualToString:@"box"]){
            UIView *boxView = [self.itemViewArrayInRoom lastObject];
            CGPoint pointOnBoxView = [touch locationInView:[self.itemViewArrayInRoom lastObject]];
            if(CGRectContainsPoint(boxView.bounds, pointOnBoxView)){
                //   gameNavigation
                [self performSegueWithIdentifier:@"victoryNavigation" sender:nil];
            }
        }
        //из сумки в комнату
        if (pointOnBagView.y<= -45){
            ANItem * curentItem = [self.player deleteItemWithTag: self.draggingViewInBag.tag];
            [self.itemViewArrayInBag removeObject:self.draggingViewInBag];
            self.curentRoom.item = curentItem;
            [self.itemViewArrayInRoom addObject:self.draggingViewInBag];
            }
        self.draggingViewInBag = nil;
    }
    self.movingFlag = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    self.draggingView = nil;
}


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
}


@end

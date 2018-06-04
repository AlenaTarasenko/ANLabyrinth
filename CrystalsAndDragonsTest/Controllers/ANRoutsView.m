//
//  ANRoutsViev.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANRoutsView.h"
#import "ANRoom.h"

NSString * upPath = @"up.png";
NSString * dwPath = @"dw.png";
NSString * ltPath = @"lt.png";
NSString * rtPath = @"rt.png";

@implementation ANRoutsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(NSMutableArray *) drawRoutsViewForRoom:(ANRoom *) room OnView:(UIView *) rootView{
    
    NSMutableArray * routeViewArray =[NSMutableArray array];
    if(room){
        if(room.northRoom){
            UIView * routeViewUp = [[UIView alloc] initWithFrame:
                                         CGRectMake((rootView.center.x)-37, 50, 75, 100)];
            routeViewUp.tag =1;
            [self addPointerView:routeViewUp OnView:rootView From:upPath];
            [routeViewArray addObject:routeViewUp];
        }
        if(room.westRoom){
            UIView * routeViewLt = [[UIView alloc] initWithFrame:
                                         CGRectMake(15, (rootView.bounds.size.height)/2.f - 50-37, 100, 75)];
            routeViewLt.tag =2;
            [self addPointerView:routeViewLt OnView:rootView From:ltPath];
            [routeViewArray addObject:routeViewLt];
        }
        if(room.southRoom){
            UIView * routeViewDw = [[UIView alloc] initWithFrame:
                                         CGRectMake((rootView.bounds.size.width)/2.f-37,
                                                    (rootView.bounds.size.height) - 100 - 100 - 15,
                                                    75, 100)];
            routeViewDw.tag =3;
            [self addPointerView:routeViewDw OnView:rootView From:dwPath];
            [routeViewArray addObject:routeViewDw];
        }
        if(room.eastRoom){
            UIView * routeViewRt = [[UIView alloc] initWithFrame:
                                         CGRectMake((rootView.bounds.size.width)-15-100,
                                                    (rootView.bounds.size.height)/2.f - 50 - 37, 100, 75)];
            routeViewRt.tag =4;
            [self addPointerView:routeViewRt OnView:rootView From:rtPath];
            [routeViewArray addObject:routeViewRt];
        }
    }
    return routeViewArray;
}

+(void) addPointerView:(UIView *) routeView OnView:(UIView*) rootView From:(NSString *) path {
    routeView.backgroundColor =[UIColor clearColor];
    routeView.alpha = 1;
    [rootView addSubview:routeView];
    UIImageView * imageRouteView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:path]];
    [routeView addSubview:imageRouteView];
}

@end

//
//  ANItemView.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANItem;
@class ANPlayer;

@interface ANItemView : UIImageView

+(NSMutableArray *)drowItem:(ANItem *)item onView:(UIView *)rootView;
+(UIView *)drowItem:(ANItem *)item onView:(UIView *)rootView withRect:(CGRect)rect;
+(NSMutableArray *) drowItemInBag:(UIView *) bagView onRootView:(UIView *) rootView forePlayer:(ANPlayer*) player;
@end

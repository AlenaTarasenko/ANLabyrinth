//
//  ANBagView.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANItemView.h"
#import "ANPlayer.h"

@interface ANBagView : UIImageView

+(UIView *) drowBagInView:(UIView *) rootView;
+(NSArray *) drowItemInBag:(UIView *) rootView forePlayer:(ANPlayer*) player;
@end

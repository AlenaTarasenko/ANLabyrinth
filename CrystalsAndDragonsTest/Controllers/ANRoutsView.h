//
//  ANRoutsViev.h
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANRoom;

@interface ANRoutsView : UIImageView

+(NSMutableArray *) drawRoutsViewForRoom:(ANRoom *) room OnView:(UIView*) rootView;

@end

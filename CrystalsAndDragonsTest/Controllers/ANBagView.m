//
//  ANBagView.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANBagView.h"
#import "ANPlayer.h"
#import "ANItem.h"
#import "ANItemView.h"

static const int countBagWidth = 4;

@implementation ANBagView

+(UIView *) drowBagInView:(UIView *) rootView {
    UIView *bagView = [[UIImageView alloc] initWithFrame: CGRectMake(0 ,rootView.bounds.size.height - 100, rootView.bounds.size.width, 100)];
    bagView.backgroundColor = [UIColor brownColor];
    [rootView addSubview:bagView];
    return bagView;
}

+(NSArray *) drowItemInBag:(UIView *) bagView forePlayer:(ANPlayer*) player{
    NSMutableArray *itemArray = [NSMutableArray array];
    int i = 0;
    for (ANItem *tempItem in player.itemArray){
        CGFloat x = (bagView.bounds.size.width/4.f)*i + (bagView.bounds.size.width/8.f)-25;
        CGFloat y = (bagView.bounds.size.height/2.f)-25;
       UIView *tempView = [ANItemView drowItem:tempItem onView:bagView withRect:CGRectMake(x, y, 50, 50)];
        [itemArray addObject:tempView];
        ++i;
    }
    return itemArray;
}
@end

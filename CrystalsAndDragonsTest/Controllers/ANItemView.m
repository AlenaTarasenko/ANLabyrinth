//
//  ANItemView.m
//  CrystalsAndDragonsTest
//
//  Created by Admin on 12.05.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANItemView.h"
#import "ANItem.h"
#import "ANItemView.h"
#import "ANPlayer.h"


@implementation ANItemView


+(NSMutableArray *)drowItem:(ANItem *)item onView:(UIView *)rootView{
    NSMutableArray * itemViewArray = [NSMutableArray  array];
    NSString* pathItemPicture = [NSString stringWithFormat:@"%@.png", item.name];
    UIImageView* itemViewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pathItemPicture]];
    CGRect rect;
    rect = CGRectMake(rootView.center.x - itemViewImage.bounds.size.width/2.f,
                      rootView.center.y - itemViewImage.bounds.size.height/2.f - 50,
                      itemViewImage.bounds.size.width,
                      itemViewImage.bounds.size.height);
    UIView * itemView = [[UIView alloc] initWithFrame:rect];
    itemView.backgroundColor = [UIColor clearColor];
    itemView.alpha = 1;
    itemView.tag = item.tag;
    [itemView addSubview:itemViewImage];
    [rootView addSubview: itemView];
    [itemViewArray addObject:itemView];
    return itemViewArray;
}


+(UIView *)drowItem:(ANItem *)item onView:(UIView *)rootView withRect:(CGRect)rect{
    NSString* pathItemPicture = [NSString stringWithFormat:@"%@.png", item.name];
    UIImageView* itemViewImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pathItemPicture]];
    UIView * itemView = [[UIView alloc] initWithFrame:rect];
    itemView.backgroundColor = [UIColor clearColor];
    itemView.alpha = 1;
    itemView.tag = item.tag;
    [itemView addSubview:itemViewImage];
    [rootView addSubview: itemView];
    return itemView;
}


+(NSMutableArray *) drowItemInBag:(UIView *) bagView onRootView:(UIView *) rootView forePlayer:(ANPlayer*) player{
    NSMutableArray *itemArray = [NSMutableArray array];
    int i = 0;
    for (ANItem *tempItem in player.itemArray){
        
        CGFloat x = (bagView.bounds.size.width/4.f)*i + (bagView.bounds.size.width/8.f)-25;
        CGFloat y = (bagView.bounds.size.height/2.f) + 25;
        CGFloat xOnRootView = x;
        CGFloat yOnRootView = rootView.bounds.size.height - y;
        
        UIView *tempView = [ANItemView drowItem:tempItem onView:rootView withRect:CGRectMake(xOnRootView, yOnRootView, 50, 50)];
        [itemArray addObject:tempView];
        ++i;
    }
    return itemArray;
}
@end


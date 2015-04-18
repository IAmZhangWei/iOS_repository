//
//  ZWTabBar.h
//  Weibo
//
//  Created by qianfeng on 15/4/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTabBar;

@protocol ZWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ZWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface ZWTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic, weak) id<ZWTabBarDelegate> delegate;

@end

//
//  ZWStatusCell.h
//  Weibo
//
//  Created by qianfeng on 15/4/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWStatusFrame;
@interface ZWStatusCell : UITableViewCell
@property (nonatomic, strong) ZWStatusFrame *statusFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

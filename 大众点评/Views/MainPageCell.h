//
//  MainCell.h
//  大众点评
//
//  Created by qianfeng on 4/6/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainPageModel;

@interface MainPageCell : UITableViewCell

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UILabel *addressLabel;

@property (nonatomic, retain) MainPageModel *model;

@end

//
//  ZWTitleButton.m
//  Weibo
//
//  Created by qianfeng on 15/4/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWTitleButton.h"

#define ZWTitleButtonImageW 20

@implementation ZWTitleButton

+ (instancetype)titleButton {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:19];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        //背景
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = ZWTitleButtonImageW;
    CGFloat imageH = CGRectGetHeight(contentRect);
    CGFloat imageX = CGRectGetWidth(contentRect)-imageW;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = CGRectGetWidth(contentRect)-ZWTitleButtonImageW;
    CGFloat titleH = CGRectGetHeight(contentRect);
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

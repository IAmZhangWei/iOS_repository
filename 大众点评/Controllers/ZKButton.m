//
//  ZKButton.m
//  03-block的基本知识
//
//  Created by zhaokai on 15-3-6.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKButton.h"

@interface ZKButton ()

//给block变量写合成存取 一定要用copy
@property (nonatomic, copy) block myBlock;

@end

@implementation ZKButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title target:(id)target andAction:(SEL)sel{
    
    ZKButton *button = [ZKButton buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock
{
    ZKButton *button = [ZKButton buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    button.myBlock = tempBlock;
    
    return button;
}

+ (ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title backgroundImage:(NSString *)background andimage:(NSString *)image andBlock:(block)tempBlock
{
    ZKButton *button = [ZKButton buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:background] forState:UIControlStateNormal];
    
    button.myBlock = tempBlock;
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    
    //标题是蓝色 写成死的
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return button;
}

- (void)buttonClicked:(ZKButton *)button
{
    NSLog(@"这里是buttonClicked方法的内部");
    //触发按钮  把自己传过去 ()里面写self也行
    button.tag = 10;
    button.myBlock(button);
}

+ (ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type normalImage:(NSString *)image SelectedImage:(NSString *)select target:(id)target andAction:(SEL)sel
{
    ZKButton *button = [ZKButton buttonWithType:type];
    
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

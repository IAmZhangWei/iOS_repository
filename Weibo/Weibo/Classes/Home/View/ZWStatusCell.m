//
//  ZWStatusCell.m
//  Weibo
//
//  Created by qianfeng on 15/4/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWStatusCell.h"
#import "ZWStatusFrame.h"
#import "UIImage+MJ.h"
#import "ZWStatus.h"
#import "UIImageView+WebCache.h"
#import "ZWUser.h"

@interface ZWStatusCell ()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (nonatomic, weak) UIImageView *statusToolbar;
@end

@implementation ZWStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    ZWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        //2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        //3.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews {
    //0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    
    /*1.顶部的view*/
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /*2.头像*/
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /*3.会员图标*/
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /*4.配图*/
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /*5.昵称*/
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = ZWStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /*6.时间*/
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = ZWStatusTimeFont;
    timeLabel.textColor = ZWColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /*7.来源*/
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = ZWStatusSourceFont;
    sourceLabel.textColor = ZWColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /*8.正文\内容*/
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = ZWColor(39, 39, 39);
    contentLabel.font = ZWStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
-(void)setupRetweetSubviews {
    /*1.被转发微博的view(父控件)*/
    UIImageView *retweetView = [[UIImageView alloc] init];
    [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = ZWRetweetStatusNameFont;
    retweetNameLabel.textColor = ZWColor(67, 107, 163);
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /*3.被转发微博的正文\内容*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetNameLabel.font = ZWRetweetStatusContentFont;
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.textColor = ZWColor(90, 90, 90);
    [self.retweetContentLabel addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /*4.被转发微博的配图*/
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar {
    /*1.微博的工具条*/
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    statusToolbar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    statusToolbar.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.y += ZWStatusTableBorder;
    frame.origin.x = ZWStatusTableBorder;
    frame.size.width -= 2*ZWStatusTableBorder;
    frame.size.height -= ZWStatusTableBorder;
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(ZWStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    //1.原创微博
    [self setupOriginalData];
    
    //2.被转发微博
    [self setupRetweetData];
    
    //3.微博工具条
    [self setupStatusToolbarData];
}
/**
 *  原创微博
 */
- (void)setupOriginalData {
    ZWStatus *status = self.statusFrame.status;
    ZWUser *user = status.user;
    
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    //2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    //4.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageWithName:imageName];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + ZWStatusCellBorder*0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:ZWStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    //6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + ZWStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:ZWStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    //8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    } else {
        self.photoView.hidden = YES;
    }
}

/**
 *  被转发微博
 */
- (void)setupRetweetData {
    ZWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    ZWUser *user = retweetStatus.user;
    
    //1.父控件
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        //2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        //3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        //4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic]  placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
}

/**
 *  微博工具条
 */
- (void)setupStatusToolbarData {
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}

@end

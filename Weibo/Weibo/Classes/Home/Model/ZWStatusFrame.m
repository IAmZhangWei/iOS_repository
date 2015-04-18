//
//  ZWStatusFrame.m
//  Weibo
//
//  Created by qianfeng on 15/4/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ZWStatusFrame.h"
#import "ZWStatus.h"
#import "ZWUser.h"

@implementation ZWStatusFrame


/**
 *  获得微博模型数据之后, 根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(ZWStatus *)status {
    _status = status;
    
    //cell的高度
    CGFloat cellW = CGRectGetWidth([UIScreen mainScreen].bounds) - 2*ZWStatusTableBorder;
    
    //1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = ZWStatusCellBorder;
    CGFloat iconViewY = ZWStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + ZWStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:ZWStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    //4.会员图标
    if (status.user.mbtype) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + ZWStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + ZWStatusCellBorder*0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:ZWStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + ZWStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:ZWStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    //7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + ZWStatusCellBorder * 0.5;
    CGFloat contentLabelMaxW = topViewW - 2 * ZWStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:ZWStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    //8.配图
    if (status.thumbnail_pic) {
        CGFloat photoViewWH = 70;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + ZWStatusCellBorder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
    
    //9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewH = 0;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + ZWStatusCellBorder * 0.5;
        
        //10.被转发微博的昵称
        CGFloat retweetNameLabelX = ZWStatusCellBorder;
        CGFloat retweetNameLabelY = ZWStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:ZWRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        //11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + ZWStatusCellBorder*0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2*ZWStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:ZWRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        //12.被转发微博的配图
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewWH = 70;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + ZWStatusCellBorder;
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
    
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        } else {//没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += ZWStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        //有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else {//没有转发微博
        if (status.thumbnail_pic) {//有图
            topViewH = CGRectGetMaxY(_photoViewF);
        } else {//无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += ZWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    //14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + ZWStatusTableBorder;
    
}

@end

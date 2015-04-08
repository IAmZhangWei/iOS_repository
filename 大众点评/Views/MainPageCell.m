//
//  MainCell.m
//  大众点评
//
//  Created by qianfeng on 4/6/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "MainPageCell.h"
#import "MainPageModel.h"
#import "UIImageView+WebCache.h"

@implementation MainPageCell

@synthesize imageView = _imageView;
@synthesize nameLabel = _nameLabel;
@synthesize priceLabel = _priceLabel;
@synthesize addressLabel = _addressLabel;
@synthesize model = _model;

- (void)dealloc
{
    self.imageView = nil;
    self.nameLabel = nil;
    self.priceLabel = nil;
    self.addressLabel = nil;
    self.model = nil;
    [super dealloc];
}

- (void)setModel:(MainPageModel *)model {
    _model = model;
    [self.imageView setImageWithURL:[NSURL URLWithString:model.photo_url]];
    self.nameLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"%@", model.address];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%ld元", model.avg_price];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat leftGap = 5;
        CGFloat gap = 5;
        CGFloat topGap = 10;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftGap, topGap, 100, 80)];
        [self.imageView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.imageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftGap+ CGRectGetMaxX(self.imageView.frame), topGap, CGRectGetWidth(self.frame)-2*leftGap-CGRectGetMaxX(self.imageView.frame), 20)];
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.nameLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+leftGap, CGRectGetMaxY(self.nameLabel.frame)+gap, 200, 15)];
        [self.priceLabel setFont:UIFont13];
        [self.contentView addSubview:self.priceLabel];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+leftGap, CGRectGetMaxY(self.priceLabel.frame)+gap, 200, 100-CGRectGetMaxY(self.priceLabel.frame)- gap-topGap)];
        self.addressLabel.numberOfLines = 0;
        [self.addressLabel setFont:UIFont12];
        [self.contentView addSubview:self.addressLabel];
    }
    return self;
}


@end

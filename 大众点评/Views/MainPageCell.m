//
//  MainCell.m
//  大众点评
//
//  Created by qianfeng on 4/6/15.
//  Copyright (c) 2015 张维. All rights reserved.
//

#import "MainPageCell.h"
#import "MainPageModel.h"

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
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [UIImage imageWithContentsOfFile:<#(NSString *)#>]
//        self.imageView =
    }
    return self;
}


@end

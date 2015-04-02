//
//  MainVC.m
//  大众点评
//
//  Created by qianfeng on 3/29/15.
//  Copyright (c) 2015 张维. All rights reserved.
//


#import "MainVC.h"
#import "ZKButton.h"

#import "HelpNetWorking.h"

@interface MainVC () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIPageControl *pageControll;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    
    [self setTableView];
    
    [HelpNetWorking getCarDataWithBlock:^(NSObject *car, NSError *error) {
        ;
    }];
}

#pragma mark --添加tableView
- (void)setTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark --添加tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        return 10;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        //设置scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        [cell addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        [self setButton];
        
        //设置pageControl
        _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame) - 20, self.view.frame.size.width - 50, 20)];
        [cell addSubview:_pageControll];
        _pageControll.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControll.numberOfPages = 3;
        _pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
        
        return cell;
    } else {
        
        static NSString *ident = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident] autorelease];
        }
        return cell;
    }
}

#pragma mark --添加scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset:CGPointMake(self.view.frame.size.width * 3, 0) animated:NO];
        _pageControll.currentPage = 2;
        return;
    }
    if (scrollView.contentOffset.x == self.view.frame.size.width * 4) {
        [scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
        _pageControll.currentPage = 0;
        return;
    }
    _pageControll.currentPage = scrollView.contentOffset.x / self.view.frame.size.width - 1;
}

#pragma mark --添加button
- (void)setButton
{
    NSArray *imagesArr = @[@"footer", @"scenicspots_o@2x", @"ktv_u@2x", @"shoppingmall", @"vip", @"marry_u@2x", @"food_u", @"", @"food_u", @"snack_o", @"relax", @"more_o@2x", @"groupon_u@2x", @"hotel_u@3x", @"takeaway_u@2x", @"film_u@2x", @"beauty", @"baby", @"marry", @"jiazhuang", @"booking_u@2x", @"discount_u@2x", @"food_u", @"food_u", @"footer", @"scenicspots_o@2x", @"ktv_u@2x", @"shoppingmall", @"vip", @"marry_u@2x", @"food_u", @"", @"food_u", @"snack_o", @"relax", @"more_o@2x", @"groupon_u@2x", @"hotel_u@2x", @"takeaway_u@2x", @"film_u@2x"];
    
    NSArray *titleArr = @[@"足疗按摩", @"周边游", @"KTV", @"团购商城", @"会员卡",@"拍婚照",@"爱车", @"", @"美食", @"小吃快餐", @"休闲娱乐", @"全部分类", @"团购", @"订酒店", @"订外卖", @"看电影", @"丽人", @"亲子", @"结婚", @"家装", @"订座", @"找优惠", @"有料", @"看演出", @"足疗按摩", @"周边游", @"KTV", @"团购商城", @"会员卡",@"拍婚照",@"爱车", @"", @"美食", @"小吃快餐", @"休闲娱乐", @"全部分类", @"团购", @"订酒店", @"订外卖", @"看电影"];
    
    CGFloat gap = self.view.frame.size.width / 12;
    
    CGFloat btnW = (self.view.frame.size.width - 5 * gap) / 4;
    
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, _tableView.frame.size.height)];
        [_scrollView addSubview:view];
        for (int j = 0; j < 8; j++) {
            ZKButton *btn = [ZKButton buttonWithFrame:CGRectMake(gap + (j % 4) * (gap + btnW), (j / 4) * 70 + 15, btnW, btnW) type:UIButtonTypeCustom title:nil backgroundImage:nil andimage:imagesArr[i * 8 + j] andBlock:^(ZKButton *button) {
                
            }];
            
            UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(gap + (j % 4) * (gap + btnW), CGRectGetMaxY(btn.frame), btnW, 20)];
            titleLabel.text = titleArr[i * 8 + j];
            titleLabel.font = [UIFont systemFontOfSize:10];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [view addSubview:titleLabel];
            
            [view addSubview:btn];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

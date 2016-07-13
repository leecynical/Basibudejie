//
//  XMGRecommendationViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/6/30.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGRecommendationViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "XMGRecommendCategory.h"
#import "XMGRecommendCategoryCell.h"
#import "XMGRecommendUserCell.h"
#import "XMGRecommendUser.h"


#define XMGSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface XMGRecommendationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  储存请求参数，判断是不是重复请求
 */
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation XMGRecommendationViewController

static NSString * const XMGCategoryId = @"category";
static NSString * const XMGUserId = @"user";

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  初始化tableView控件
     */
    [self setupTableView];
    /**
     *  设置刷新控件
     */
    [self setupRefresh];
    /**
     *  加载左侧category数据
     */
    [self loadCategories];
}
/**
 *  tableView的控件初始化
 */
-(void)setupTableView
{
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = XMGGlobalBg;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGUserId];
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
}
/**
 *  加载左侧category数据
 */
-(void)loadCategories
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        [SVProgressHUD dismiss];
        
        self.categories = [XMGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
    }failure:^(NSURLSessionDataTask *task, id responseObject){
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}
/**
 *  设置刷新控件
 */
-(void)setupRefresh
{
    //设置header
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    // Set title
    [header setTitle:@"刷新成功" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // Hide the time
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // Set textColor
//    header.stateLabel.textColor = [UIColor redColor];
//    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    //设置footer
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    // Set title
    [footer setTitle:@"点击或下拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多的数据" forState:MJRefreshStateNoMoreData];
    
    // Set font
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // Set textColor
//    footer.stateLabel.textColor = [UIColor blueColor];
    
    self.userTableView.mj_header = header;
    self.userTableView.mj_footer = footer;
    
    self.userTableView.mj_footer.hidden = YES;
}

-(void)loadNewUsers
{
    XMGRecommendCategory *category = XMGSelectedCategory;
    category.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        
        NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users removeAllObjects];
        
        [category.users addObjectsFromArray:users];
        
        category.total = [responseObject[@"total"] integerValue];
        //判断是不是最后一次发的请求，避免重复发请求
        if(self.params != params) return;
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self checkFooterState];
    }failure:^(NSURLSessionDataTask *task, id responseObject){
        if(self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        [self.userTableView.mj_header endRefreshing];
    }];
}

-(void)loadMoreUsers
{
    XMGRecommendCategory *category = XMGSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        
        NSArray *users = [XMGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:users];
        //判断是不是最后一次发的请求，避免重复发请求
        if(self.params != params) return;
        
        [self.userTableView reloadData];
        
        [self checkFooterState];
    }failure:^(NSURLSessionDataTask *task, id responseObject){
        if(self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        [self.userTableView.mj_footer endRefreshing];
    }];
}

-(void)checkFooterState
{
    XMGRecommendCategory *category = XMGSelectedCategory;
    
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    if (category.users.count == category.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark -- UITableView data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.categoryTableView){
        return self.categories.count;
    }else{
        [self checkFooterState];
        return [XMGSelectedCategory users].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        XMGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else{
        XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        cell.user = [XMGSelectedCategory users][indexPath.row];
        return cell;
    }
}
#pragma mark -- UITableViewdelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    XMGRecommendCategory *category = self.categories[indexPath.row];
    if (category.users.count) {
        [self.userTableView reloadData];
    }else{
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
    }
}

-(void)dealloc
{
    //停止请求操作
    [self.manager.operationQueue cancelAllOperations];
}
@end

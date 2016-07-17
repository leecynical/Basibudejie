//
//  XMGRecommendTagsViewController.m
//  百思不得姐
//
//  Created by 李金钊 on 16/7/14.
//  Copyright © 2016年 lijinzhao. All rights reserved.
//

#import "XMGRecommendTagsViewController.h"
#import "XMGRecommendTag.h"
#import "XMGRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface XMGRecommendTagsViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSArray *tags;
@end

static NSString * const XMGTagID = @"tag";

@implementation XMGRecommendTagsViewController

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

-(void)loadTags
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        [SVProgressHUD dismiss];
        self.tags = [XMGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    }failure:^(NSURLSessionDataTask *task, id responseObject){
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

-(void)setupTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XMGTagID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.backgroundColor = XMGGlobalBg;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier: XMGTagID];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

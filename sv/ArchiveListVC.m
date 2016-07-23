//
//  ArchiveListVC.m
//  SV
//
//  Created by BaoAnh on 2/21/15.
//  Copyright (c) 2015 patrik. All rights reserved.
//

#import "ArchiveListVC.h"
#import "ArchiveCell.h"
#import "Constant.h"
#import "WebService.h"
#import "JSONKit.h"
#import "AppDelegate.h"

@interface ArchiveListVC ()

@end

@implementation ArchiveListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupInterface];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!dataSource || dataSource.count == 0) {
//        startIndex = 1;
        nextPageToken = @"";
        [self loadData];
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData{
//    startIndex = 1;
    nextPageToken = @"";
    dataSource = [[NSMutableArray alloc]init];
}
- (void)setupInterface{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sv backr"]];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.frame = CGRectMake(0, 0, 26, 26);
    indicatorView.center = self.tableView.center;
    [self.view addSubview:indicatorView];
}
#pragma mark - Calling API
- (NSDictionary *)getParameter{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           nextPageToken, @"pageToken",
                           [NSString stringWithFormat:@"%d", PAGES_SIZE], @"max-results",
                           @"date", @"order",
                           CHANNEL_ID, @"channelId",
                           nil];
    return param;
}
- (void)loadData{
    [self startAnimating];
    NSDictionary *param = [self getParameter];
    [WEBSERVICE loadRequest:@"" param:param success:^(id responseObject) {
        NSDictionary *json = [responseObject objectFromJSONString];
        NSDictionary *jsonFeed = [json objectForKey:@"items"];
        
        // calcul loadMore value
//        NSDictionary *jsontotalResults = [jsonFeed objectForKey:@"openSearch$totalResults"];
//        NSDictionary *jsonstartIndex   = [jsonFeed objectForKey:@"openSearch$startIndex"];
//        NSDictionary *jsonitemsPerPage = [jsonFeed objectForKey:@"openSearch$itemsPerPage"];
        
        NSDictionary *jsontotalResults = [json objectForKey:@"pageInfo"];
        nextPageToken = [json objectForKey:@"nextPageToken"];
        NSInteger _totalResults = [[jsontotalResults objectForKey:@"totalResults"] integerValue];
        NSInteger _startIndex   = 1;
        NSInteger _itemsPerPage = [[jsontotalResults objectForKey:@"resultsPerPage"]integerValue];
        if (_startIndex + _itemsPerPage < _totalResults) {
            isMore = YES;
        }else{
            isMore = NO;
        }
        // get list movie
        if ([nextPageToken isEqual:@""]) {
            [dataSource removeAllObjects];
        }
        int item = 0;
        for (NSDictionary *jsonItem in jsonFeed) {
            item = item + 1;
            Video *video = [[Video alloc]initWithJson:jsonItem];
            if (video != nil) {
                [dataSource addObject:video];
                if ([dataSource count] == 24){
                    NSLog(@"24th video:----%@",video.name);
                }
                if ([dataSource count] == 25){
                    NSLog(@"25th video:----%@",video.name);
                }
            }
        }
        [self stopAnimating];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [self stopAnimating];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ArchiveCell";
    ArchiveCell *cell = (ArchiveCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Video *video = [dataSource objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    [cell configCell:video];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < dataSource.count) {
        APPDELEGATE.videoSelected = [dataSource objectAtIndex:indexPath.row];
        NSLog(@"video selected: %@", APPDELEGATE.videoSelected.iD);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= 495) {
        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
        NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
            // This is the last cell
            [self loadMore];
        }
    }
}

- (void)refresh{
//    startIndex = 1;
    nextPageToken = @"";
    [self loadData];
}
- (void)loadMore{
    if (isMore) {
//        startIndex = dataSource.count + 1;
        nextPageToken = nextPageToken;
        [self loadData];
    }
}
- (void)updateDataSourcewithIsMore:(BOOL)_isMore andPageIndex:(int) pageIndex{
    if (pageIndex == 1) {
        [dataSource removeAllObjects];
    }else{
        
    }
    if (_isMore) {
        
    }else{
        
    }
}
- (void)startAnimating{
    if (dataSource.count == 0) {
        indicatorView.hidden = NO;
        [indicatorView startAnimating];
    }else{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}
- (void)stopAnimating{
    indicatorView.hidden = YES;
    [indicatorView stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//
//- (IBAction)btnCancelTap:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
@end

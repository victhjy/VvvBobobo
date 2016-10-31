//
//  VBSearchViewController.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBSearchViewController.h"
#import "VBSearchResultModel.h"
#import "VBSearchListCell.h"
#import "VBMBlogModel.h"
#import "VBFilterViewController.h"

@interface VBSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray* resultMBlogs;
@end

@implementation VBSearchViewController
static NSString* reuseCell=@"reuseSearchResultCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"搜什么搜";
    [self _createUI];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)_createUI{
    UISearchBar* searchBar=[[UISearchBar alloc]init];
    searchBar.delegate=self;
    [searchBar setTag:10086];
    
    [self.view addSubview:searchBar];
    [self.view addSubview:self.tableView];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.view);
        make.width.mas_equalTo(UIScreenWidth/2);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(searchBar.mas_bottom);
    }];
    
    [self.tableView registerClass:[VBSearchListCell class] forCellReuseIdentifier:reuseCell];
    
    
}

#pragma mark - SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    VBLog(@"%@",searchBar.text);
    [searchBar resignFirstResponder];
    NSString* containerid=[NSString stringWithFormat:@"100103type=1&q=%@&t=0",searchBar.text];
    NSString* fid=[NSString stringWithFormat:@"100103type=1&q=%@&t=0",searchBar.text];
    NSDictionary* parmaDic=@{
                             @"gsid":@"_2A251Ee_6DeTxGedJ7FoQ9ibKwzuIHXVXh2QyrDV6PUJbkdANLWzxkWppJ9OfhFUhzPDe1Sf4tft3-h0vsQ..",
                             @"wm":@"3333_2001",
                             @"i":@"c69d5f6",
                             @"b":@"1",
                             @"from":@"106B093010",
                             @"c":@"iphone",
                             @"networktype":@"wifi",
                             @"v_p":@"38",
                             @"skin":@"default",
                             @"v_f":@"1",
                             @"s":@"b09c5b4a",
                             @"lang":@"zh_CN",
                             @"sflag":@"1",
                             @"ua":@"iPhone8,4__weibo__6.11.0__iphone__os10.0.2",
                             @"aid":@"01AkbDNvLxFfY7O9lcUheY8g4T1xzGcFf9B_9yD5cy2f5J_Fo.",
                             @"lon":@"113.945531",
                             @"uid":@"1778168687",
                             @"container_ext":@"nettype%3Awifi%7Cgps_timestamp%3A1477884736897.419",
                             @"count":@"20",
                             @"luicode":@"10000010",
                             @"containerid":containerid,
                             @"featurecode":@"10000085",
                             @"uicode":@"10000003",
                             @"fid":fid,
                             @"need_head_cards":@"1",
                             @"lat":@"22.557542",
                             @"page":@"1",
                             @"lfid":@"231091",
                             @"moduleID":@"pagecard"
                             };
    __weak typeof(self) weakself=self;
    [[VBNetManager sharedManager] requestWithMethod:GET WithPath:APISearch WithParams:parmaDic WithSuccessBlock:^(NSDictionary *dic) {
        NSArray* cards=[dic valueForKey:@"cards"];
        NSMutableArray* testArr=[NSMutableArray new];
        for (NSDictionary* dic in cards) {
            if ([[dic valueForKey:@"card_type_name"] isEqualToString:@"微博"]) {
                [testArr addObjectsFromArray:[dic objectForKey:@"card_group"]];
            }
        }
        weakself.resultMBlogs=[VBSearchResultModel mj_objectArrayWithKeyValuesArray:testArr];
        [weakself.tableView reloadData];
        [VBTools showMessage:@"加载成功" inView:weakself.view seconds:2];

    } WithFailurBlock:^(NSError *error) {
        VBLog(@"Error :%@",error);
        NSString* errorString=[NSString stringWithFormat:@"加载失败:%@",error];
        [VBTools showMessage:errorString inView:weakself.view seconds:2];
    }];
    
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    searchBar.text=@"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultMBlogs.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBSearchResultModel* model=self.resultMBlogs[indexPath.row];
    
    VBSearchListCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell configWithModel:(VBMBlogModel* )model.mblog];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBSearchResultModel* model=self.resultMBlogs[indexPath.row];
    
    VBSearchListCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseCell];
    [cell configWithModel:(VBMBlogModel* )model.mblog];
    return [cell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VBFilterViewController* filterVC=[VBFilterViewController new];
    VBSearchResultModel* model=self.resultMBlogs[indexPath.row];
    filterVC.mblogModel=model.mblog;
    
    [self.navigationController pushViewController:filterVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UISearchBar* searchBar=[self.view viewWithTag:10086];
    [searchBar resignFirstResponder];
}
#pragma mark - Getter

-(UITableView* )tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        [self scrollViewDidScroll:_tableView];
    }
    return _tableView;
}

-(NSMutableArray* )resultMBlogs{
    if (!_resultMBlogs) {
        _resultMBlogs=[NSMutableArray new];
    }
    return _resultMBlogs;
}

@end

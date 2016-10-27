//
//  VBFilterViewController.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBFilterViewController.h"
#import "VBCommentModel.h"
#import "VBFiltedCommentCell.h"
@interface VBFilterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITextField* inputField;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray* allCommentsArr;
@property(nonatomic,strong)NSMutableArray* filtedArr;
@property(nonatomic,assign)BOOL isShowingOriginalMBlog;
@property(nonatomic,strong)UIView* bgView;
@end

static NSString* reuseCell=@"reuseCell";
@implementation VBFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createUI];
    
    [self loadAllComments];
    // Do any additional setup after loading the view.
}

-(void)_createUI{
    UIBarButtonItem* showMblogVButton=[[UIBarButtonItem alloc]initWithTitle:@"原博" style:UIBarButtonItemStyleDone target:self action:@selector(showOriginalMBlog)];
    self.navigationItem.rightBarButtonItem=showMblogVButton;
    
    UITextField* input=[UITextField new];
    self.inputField=input;
    self.inputField.placeholder=@"广东 深圳";
    UIButton* doneButton=[[UIButton alloc]init];
    [doneButton setTitle:@"OK" forState:UIControlStateNormal];
    
    doneButton.titleLabel.textColor=[UIColor blackColor];
    doneButton.backgroundColor=[UIColor lightGrayColor];
    
    [doneButton addTarget:self action:@selector(gotoSelect) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubviews:@[self.inputField,doneButton,self.tableView]];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
        make.height.equalTo(@30);
        make.right.equalTo(self.view.mas_centerX);
    }];
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputField);
        make.right.equalTo(self.view).offset(-10);
        make.left.equalTo(self.inputField.mas_right);
        make.height.equalTo(@30);
    }];
    
    [self.tableView registerClass:[VBFiltedCommentCell class] forCellReuseIdentifier:reuseCell];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.inputField.mas_bottom).offset(10);
    }];
    
}

-(void)gotoSelect{
    [self.inputField resignFirstResponder];
    self.filtedArr=[NSMutableArray new];
    for (VBCommentModel * commentModel in self.allCommentsArr) {
        if ([commentModel.user.gender isEqualToString:@"f"]&&[commentModel.user.location isEqualToString:self.inputField.text]) {
//            NSLog(@"%@",commentModel.user.location);
            [self.filtedArr addObject:commentModel];
        }
    }
    [self.tableView reloadData];

}

-(void)loadAllComments{
   
    NSDictionary* paramDic=@{
                             @"gsid":@"_2A251FF3ZDeTxGedJ7FoQ9ibKwzuIHXVXgNYRrDV6PUJbkdANLUTFkWp-BlP3z3nhj313BjT5D1xQ1wwNCQ..",
                             @"wm":@"3333_2001",
                             @"i":@"c69d5f6",
                             @"b":@"1",
                             @"from":@"106A293010",
                             @"c":@"iphone",
                             @"networktype":@"wifi",
                             @"v_p":@"36",
                             @"skin":@"default",
                             @"v_f":@"1",
                             @"s":@"b09c5b4a",
                             @"lang":@"zh_CN",
                             @"sflag":@"1",
                             @"ua":@"iPhone8,4__weibo__6.10.2__iphone__os10.0.2",
                             @"aid":@"01AkbDNvLxFfY7O9lcUheY8g4T1xzGcFf9B_9yD5cy2f5J_Fo.",
                             @"id":self.mblogModel.mid,
                             @"mid":self.mblogModel.mid,
                             @"trim_level":@"1",
                             @"_status_id":self.mblogModel.mid,
                             @"count":@"200",
                             @"is_show_bulletin":@"2",
                             @"luicode":@"10000001",
                             @"featurecode":@"10000001",
                             @"uicode":@"10000002",
                             @"fetch_level":@"0",
                             @"rid":@"7_0_8_2598765662932679989",
                             @"fromlog":@"100011778168687",
                             @"is_reload":@"1",
                             @"page":@"0",
                             @"lfid":@"100011778168687",
                             @"moduleID":@"feed",
                             @"since_id":@"0"
                             };
    __weak typeof(self) weakself=self;
    [[VBNetManager sharedManager] requestWithMethod:GET WithPath:APIGetAllComments WithParams:paramDic WithSuccessBlock:^(NSDictionary *dic) {
        [VBTools showMessage:@"加载所有评论成功" inView:weakself.view seconds:2];
        if (dic&&[dic valueForKey:@"root_comments"]) {
            weakself.allCommentsArr=[NSMutableArray new];
            NSArray* someComments=[VBCommentModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"root_comments"]];
            [weakself.allCommentsArr addObjectsFromArray:someComments];
            
            
            [weakself loadMoreComments:dic];
            
        }
        
        [weakself.tableView reloadData];
        
    } WithFailurBlock:^(NSError *error) {
        [VBTools showMessage:[NSString stringWithFormat:@"加载失败:%@",error] inView:weakself.view seconds:2];
    }];
    
    // @"gsid":@"3333"
}

-(void)loadMoreComments:(NSDictionary* )dic{
    NSDictionary* paramDic=@{
        @"flow":@"0",
        @"gsid":@"_2A251FF3ZDeTxGedJ7FoQ9ibKwzuIHXVXgNYRrDV6PUJbkdANLUTFkWp-BlP3z3nhj313BjT5D1xQ1wwNCQ..",
        @"wm":@"3333_2001",
        @"i":@"c69d5f6",
        @"b":@"1",
        @"from":@"106A293010",
        @"c":@"iphone",
        @"networktype":@"wifi",
        @"v_p":@"36",
        @"skin":@"default",
        @"v_f":@"1",
        @"s":@"b09c5b4a",
        @"lang":@"zh_CN",
        @"sflag":@"1",
        @"ua":@"iPhone8,4__weibo__6.10.2__iphone__os10.0.2",
        @"aid":@"01AkbDNvLxFfY7O9lcUheY8g4T1xzGcFf9B_9yD5cy2f5J_Fo.",
        @"id":[dic objectForKey:@"id"],
        @"mid":[dic objectForKey:@"id"],
        @"trim_level":@"1",
        @"_status_id":[dic objectForKey:@"id"],
        @"count":@"20",
        @"is_show_bulletin":@"2",
        @"luicode":@"10000001",
        @"featurecode":@"10000001",
        @"uicode":@"10000002",
        @"fetch_level":@"0",
        @"rid":@"11_0_8_2666932652280369984",
        @"fromlog":@"100011778168687",
        @"max_id_type":@"0",
        @"max_id":[dic objectForKey:@"max_id"],
        @"page":@"0",
        @"lfid":@"100011778168687",
        @"moduleID":@"feed"
    };
    
    __weak typeof(self) weakself=self;
    [[VBNetManager sharedManager] requestWithMethod:GET WithPath:APIGetAllComments WithParams:paramDic WithSuccessBlock:^(NSDictionary *dic) {
        if (dic&&[dic valueForKey:@"root_comments"]) {
            
            NSArray* someComments=[VBCommentModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"root_comments"]];
            NSNumber* count=[dic valueForKey:@"total_number"];
            if (weakself.allCommentsArr.count<count.intValue&&someComments.count>0) {
                    [weakself.allCommentsArr addObjectsFromArray:someComments];
                    
                    [weakself loadMoreComments:dic];
                    return ;
            }
            else{
                weakself.filtedArr=[NSMutableArray new];
                for (VBCommentModel * commentModel in weakself.allCommentsArr) {
                    if ([commentModel.user.gender isEqualToString:@"f"]) {
                        NSLog(@"%@",commentModel.user.location);
                            [weakself.filtedArr addObject:commentModel];
                    }
                }
                [weakself.tableView reloadData];
                return ;
            }
        }

    } WithFailurBlock:^(NSError *error) {
        [VBTools showMessage:[NSString stringWithFormat:@"Error:%@",error] inView:weakself.view seconds:1];
    }];
}

-(void)showOriginalMBlog{
    if (!self.isShowingOriginalMBlog) {
        self.bgView.hidden=NO;
//        [self.view setNeedsUpdateConstraints];
//        [self.view updateConstraintsIfNeeded];
//        [self.view updateConstraints];
//        [self.view layoutIfNeeded];
    }
    else{
        self.bgView.hidden=YES;
    }
    self.isShowingOriginalMBlog=!self.isShowingOriginalMBlog;
}

#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filtedArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBCommentModel* model=self.filtedArr[indexPath.row];
    VBFiltedCommentCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseCell];
    
    [cell configWithModel:model];
    return [cell cellHeight];

}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBCommentModel* model=self.filtedArr[indexPath.row];
    VBFiltedCommentCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    
    [cell configWithModel:model];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}


#pragma mark - Getter

-(UITableView* )tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}

-(UIView* )bgView{
    if (!_bgView) {
        _bgView=[UIView new];
        UILabel* originalText=[UILabel new];
        originalText.font=[UIFont systemFontOfSize:12];
        
        originalText.text=self.mblogModel.text;
        originalText.numberOfLines=0;
        CGFloat height=[UILabel getHeightByWidth:UIScreenWidth-20 title:originalText.text font:originalText.font];
        
        originalText.frame=CGRectMake(0, 0, UIScreenWidth-20, height);
        
        [_bgView addSubview:originalText];
        [self.view addSubview:_bgView];
        _bgView.backgroundColor=[UIColor lightGrayColor];
        _bgView.frame=CGRectMake(10, 10, UIScreenWidth-20, UIScreenHeight-74);
        _bgView.hidden=YES;
    }
    return _bgView;
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

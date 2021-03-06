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
@property(nonatomic,strong)UIButton* gender;
@property(nonatomic,strong)NSMutableDictionary* thisLoadDic;   //本次加载时候的参数，用来重新加载

@end

static NSString* reuseCell=@"reuseCell";
@implementation VBFilterViewController
{
    NSInteger _totalPage;
    NSInteger _firstPagesCount;
    NSString *_genderStr;    //   F   M
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createUI];
    
    _totalPage=0;
    [self loadAllComments];
    // Do any additional setup after loading the view.
}

-(void)_createUI{
    UIBarButtonItem* showMblogVButton=[[UIBarButtonItem alloc]initWithTitle:@"原博" style:UIBarButtonItemStyleDone target:self action:@selector(showOriginalMBlog)];
    self.navigationItem.rightBarButtonItem=showMblogVButton;
    
    UITextField* input=[UITextField new];
    self.inputField=input;
    self.inputField.text=@"广东 深圳";
    UIButton* doneButton=[[UIButton alloc]init];
    [doneButton setTitle:@"按地区" forState:UIControlStateNormal];
    
    doneButton.titleLabel.textColor=[UIColor blackColor];
    doneButton.backgroundColor=[UIColor lightGrayColor];
    
    [doneButton addTarget:self action:@selector(gotoSelect) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* showAll=[[UIButton alloc]init];
    [showAll setTitle:@"所有" forState:UIControlStateNormal];
    showAll.titleLabel.textColor=[UIColor blackColor];
    showAll.backgroundColor=[UIColor lightGrayColor];
    [showAll addTarget:self action:@selector(showAllComments) forControlEvents:UIControlEventTouchUpInside];
    
    self.gender=[[UIButton alloc]init];
     [self.gender setTitle:@"f" forState:UIControlStateNormal];
    self.gender.titleLabel.textColor=[UIColor blackColor];
    self.gender.backgroundColor=[UIColor lightGrayColor];
    [self.gender addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
    _genderStr=self.gender.titleLabel.text;
    
    
    [self.view addSubviews:@[self.inputField,doneButton,self.tableView,showAll,self.gender]];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(10);
        make.height.equalTo(@30);
        make.width.mas_equalTo((UIScreenWidth-25)/4);
    }];
    [doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputField);
        make.width.mas_equalTo(self.inputField);
        make.left.equalTo(self.inputField.mas_right).offset(5);
        make.height.equalTo(@30);
    }];
    [self.gender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputField);
        make.height.mas_equalTo(self.inputField);
        make.left.equalTo(doneButton.mas_right).offset(5);
        make.width.mas_equalTo(self.inputField);
    }];
    [showAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputField);
        make.left.equalTo(self.gender.mas_right).offset(5);
        make.height.mas_equalTo(self.inputField);
        make.width.mas_equalTo(self.inputField);
    }];
    
    
    [self.tableView registerClass:[VBFiltedCommentCell class] forCellReuseIdentifier:reuseCell];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.inputField.mas_bottom).offset(10);
    }];
    
}

#pragma mark - actions

-(void)gotoSelect{
    [self.inputField resignFirstResponder];
    self.filtedArr=[NSMutableArray new];
    for (VBCommentModel * commentModel in self.allCommentsArr) {
        if ([commentModel.user.gender isEqualToString:@"f"]&&[commentModel.user.location isEqualToString:self.inputField.text]) {
            [self.filtedArr addObject:commentModel];
        }
    }
    [self.tableView reloadData];

}

-(void)showAllComments{
    self.filtedArr=[NSMutableArray new];
    self.filtedArr=[self.allCommentsArr mutableCopy];
    [self.tableView reloadData];
}

-(void)selectGender:(UIButton* )sender{
    self.filtedArr=[NSMutableArray new];
    if ([self.gender.titleLabel.text isEqualToString:@"f"]) {
        _genderStr=@"m";
    }else{
        _genderStr=@"f";
    }
    for (VBCommentModel * commentModel in self.allCommentsArr) {
        if ([commentModel.user.gender isEqualToString:_genderStr]&&[commentModel.user.location isEqualToString:self.inputField.text]) {
            //            NSLog(@"%@",commentModel.user.location);
            [self.filtedArr addObject:commentModel];
        }
    }
    self.gender.titleLabel.text=_genderStr;
    [self.tableView reloadData];
}


#pragma mark - request


-(void)loadAllComments{
   
    NSDictionary* paramDic=@{
                             @"gsid":@"_2A251Ee_6DeTxGedJ7FoQ9ibKwzuIHXVXh2QyrDV6PUJbkdANLWzxkWppJ9OfhFUhzPDe1Sf4tft3-h0vsQ..",
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
                             @"count":self.mblogModel.comments_count<200?[NSString stringWithFormat:@"%zd",self.mblogModel.comments_count]:@"200",
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
        _totalPage++;
        if (dic&&[[dic valueForKey:@"root_comments"] count]>0) {
            [VBTools showMessage:[NSString stringWithFormat:@"加载第%zd页评论成功",_totalPage] inView:weakself.view seconds:1];
            weakself.allCommentsArr=[NSMutableArray new];
            NSArray* someComments=[VBCommentModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"root_comments"]];
            [weakself.allCommentsArr addObjectsFromArray:someComments];
            
            weakself.thisLoadDic=[dic mutableCopy]; //把加载更多时候的参数存下来
            [weakself.thisLoadDic setValue:@0 forKey:@"loadTimes"];
            
            //有更多评论时加载更多
            if (weakself.allCommentsArr.count<weakself.mblogModel.comments_count) {
                _firstPagesCount=weakself.allCommentsArr.count;
                [weakself loadMoreComments:dic];
            }
            
            [weakself.tableView reloadData];
        }
        
        
        
    } WithFailurBlock:^(NSError *error) {
        [VBTools showMessage:[NSString stringWithFormat:@"加载第%zd页评论失败",_totalPage] inView:weakself.view seconds:1];
    }];
    
    // @"gsid":@"3333"
}

-(void)loadMoreComments:(NSDictionary* )dic{
    NSDictionary* paramDic=@{
        @"flow":@"0",
        @"gsid":@"_2A251Ee_6DeTxGedJ7FoQ9ibKwzuIHXVXh2QyrDV6PUJbkdANLWzxkWppJ9OfhFUhzPDe1Sf4tft3-h0vsQ..",
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
    NSNumber* times=self.thisLoadDic[@"loadTimes"];
    times=@(times.integerValue+1);
    [self.thisLoadDic setValue:times forKey:@"loadTimes"];
    [[VBNetManager sharedManager] requestWithMethod:GET WithPath:APIGetAllComments WithParams:paramDic WithSuccessBlock:^(NSDictionary *dic) {
        if (dic&&[dic valueForKey:@"root_comments"]) {
            
            NSArray* someComments=[VBCommentModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"root_comments"]];
            NSNumber* count=[dic valueForKey:@"total_number"];
            if (weakself.allCommentsArr.count<count.intValue||someComments.count==0) {
                //没加载完
                if (someComments.count==0) {
                    if (times.integerValue>(weakself.mblogModel.comments_count - _firstPagesCount)/20) {
                        //没加载完
                        [VBTools showMessage:[NSString stringWithFormat:@"没加载完，共%zd条评论，请求到%zd条",weakself.mblogModel.comments_count,weakself.allCommentsArr.count] inView:weakself.view seconds:2];
                        weakself.filtedArr=[NSMutableArray new];
                        for (int i=0;i<weakself.allCommentsArr.count;i++) {
                            VBCommentModel * commentModel=weakself.allCommentsArr[i];
                            commentModel.index=i;
                            if ([commentModel.user.gender isEqualToString:@"f"]) {
                                [weakself.filtedArr addObject:commentModel];
                            }
                        }
                        [weakself.tableView reloadData];
                        return ;
                    }
                    else{
                        [weakself performSelector:@selector(loadMoreComments:) withObject:weakself.thisLoadDic afterDelay:0.2];
                    }
                }
                else{
                    _totalPage++;
                   static NSInteger allPages;
                    allPages=(weakself.mblogModel.comments_count - 200)/20;
                    if(weakself.mblogModel.comments_count>200){
                        
                        [VBTools showMessage:[NSString stringWithFormat:@"加载第%zd页评论成功，预计共%zd页",_totalPage,allPages] inView:weakself.view seconds:1];
                    }
                    else{
                        [VBTools showMessage:[NSString stringWithFormat:@"加载第%zd页评论成功，评论不足200条，共一页",_totalPage] inView:weakself.view seconds:1];
                    }
                    
                    [weakself.allCommentsArr addObjectsFromArray:someComments];
                    
                    [weakself loadMoreComments:dic];
                }
                
            }
            else{
                [VBTools showMessage:[NSString stringWithFormat:@"加载完成，请求到%zd页评论，共%zd条评论，请求到%zd条",_totalPage,weakself.mblogModel.comments_count,weakself.allCommentsArr.count] inView:weakself.view seconds:4];
                weakself.filtedArr=[NSMutableArray new];
                for (int i=0;i<weakself.allCommentsArr.count;i++) {
                    VBCommentModel * commentModel=weakself.allCommentsArr[i];
                    commentModel.index=i;
                    if ([commentModel.user.gender isEqualToString:@"f"]) {
//                        NSLog(@"%@",commentModel.user.location);
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    VBCommentModel* model=self.allCommentsArr[indexPath.row];
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
        
        
        
        UITapGestureRecognizer* gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOriginalMBlog)];
        _bgView.userInteractionEnabled=YES;
        [_bgView addGestureRecognizer:gesture];
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

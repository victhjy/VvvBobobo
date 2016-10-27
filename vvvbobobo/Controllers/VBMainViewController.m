//
//  VBMainViewController.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBMainViewController.h"
#import "VBFilterViewController.h"
#import "VBSearchViewController.h"

@interface VBMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* items;
@property(nonatomic,strong)NSArray* controllersArray;
@end

@implementation VBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Main";
    
    [self _createUI];
    // Do any additional setup after loading the view.
}

-(void)_createUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=self.items[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        Class c = NSClassFromString(self.controllersArray[indexPath.row]);
        UIViewController* vc=[[c alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        NSString* firstParam=@"gsid=_2A251FF3ZDeTxGedJ7FoQ9ibKwzuIHXVXgNYRrDV6PUJbkdANLUTFkWp-BlP3z3nhj313BjT5D1xQ1wwNCQ..&wm=3333_2001&i=c69d5f6&b=1&from=106A293010&c=iphone&networktype=wifi&v_p=36&skin=default&v_f=1&s=b09c5b4a&lang=zh_CN&sflag=1&ua=iPhone8,4__weibo__6.10.2__iphone__os10.0.2&aid=01AkbDNvLxFfY7O9lcUheY8g4T1xzGcFf9B_9yD5cy2f5J_Fo.&id=4034973969153610&mid=4034973969153610&trim_level=1&_status_id=4034973969153610&count=20&is_show_bulletin=2&luicode=10000001&featurecode=10000001&uicode=10000002&fetch_level=0&rid=11_0_8_2666932652280369984&fromlog=100011778168687&is_reload=1&page=0&lfid=100011778168687&moduleID=feed&since_id=0";
        
        NSString* newParam=@"flow=0&gsid=_2A251FF3ZDeTxGedJ7FoQ9ibKwzuIHXVXgNYRrDV6PUJbkdANLUTFkWp-BlP3z3nhj313BjT5D1xQ1wwNCQ..&wm=3333_2001&i=c69d5f6&b=1&from=106A293010&c=iphone&networktype=wifi&v_p=36&skin=default&v_f=1&s=b09c5b4a&lang=zh_CN&sflag=1&ua=iPhone8,4__weibo__6.10.2__iphone__os10.0.2&aid=01AkbDNvLxFfY7O9lcUheY8g4T1xzGcFf9B_9yD5cy2f5J_Fo.&id=4034973969153610&mid=4034973969153610&trim_level=1&_status_id=4034973969153610&count=20&is_show_bulletin=2&luicode=10000001&featurecode=10000001&uicode=10000002&fetch_level=0&rid=11_0_8_2666932652280369984&fromlog=100011778168687&max_id_type=0&max_id=147198645238573&page=0&lfid=100011778168687&moduleID=feed";
        
        [VBTools getArrayFromParamString:firstParam];
        [VBTools getArrayFromParamString:newParam];
    }
    
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

-(NSArray* )items{
    return @[@"search",@"getDetail"];
}

-(NSArray* )controllersArray{
    return @[@"VBSearchViewController",@"VBFilterViewController"];
}

@end

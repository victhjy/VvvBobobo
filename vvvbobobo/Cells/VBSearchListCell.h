//
//  VBSearchListCell.h
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBBaseTableViewCell.h"
#import "VBMBlogModel.h"
@interface VBSearchListCell : VBBaseTableViewCell

@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* commentCountLabel;
@property(nonatomic,strong)UILabel* mBlogTextLabel;
@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UILabel* mBlogIdLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)configWithModel:(VBMBlogModel* )model;
-(CGFloat)cellHeight;
@end

//
//  VBSearchListCell.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBSearchListCell.h"

@implementation VBSearchListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createUI];
    }
    return self;
}

-(void)_createUI{
    self.userNameLabel=[UILabel new];
    self.mBlogTextLabel=[UILabel new];
    self.commentCountLabel=[UILabel new];
    self.mBlogIdLabel=[UILabel new];
    self.createTimeLabel=[UILabel new];
    
    self.mBlogTextLabel.numberOfLines=0;
    self.mBlogTextLabel.preferredMaxLayoutWidth=UIScreenWidth-20;
    self.mBlogTextLabel.font=[UIFont systemFontOfSize:14];
    
    self.userNameLabel.font=self.mBlogTextLabel.font;
    self.commentCountLabel.font=self.mBlogTextLabel.font;
    self.mBlogIdLabel.font=self.mBlogTextLabel.font;
    self.createTimeLabel.font=self.mBlogTextLabel.font;
    
    [self.contentView addSubviews:@[self.userNameLabel,self.mBlogTextLabel,self.commentCountLabel,self.createTimeLabel,self.mBlogIdLabel]];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
    }];
    [self.mBlogTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(10);
    }];
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mBlogTextLabel);
        make.top.equalTo(self.mBlogIdLabel.mas_bottom).offset(10);
    }];
    
    [self.mBlogIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mBlogTextLabel);
        make.top.equalTo(self.mBlogTextLabel.mas_bottom).offset(10);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.commentCountLabel);
    }];
    
    
}

-(void)configWithModel:(VBMBlogModel* )model{
    self.userNameLabel.text=model.user.name;
    self.mBlogTextLabel.text=model.text;
    self.commentCountLabel.text=[NSString stringWithFormat:@"评论数:%zd",model.comments_count];
    CGFloat newHeight=[UILabel getHeightByWidth:UIScreenWidth-20 title:self.mBlogTextLabel.text font:self.mBlogTextLabel.font];
    self.mBlogIdLabel.text=[NSString stringWithFormat:@"ID  ：  %zd",model.mBlogId];
    self.createTimeLabel.text=[NSString stringWithFormat:@"时间: %@",[VBTools resolveSinaWeiboDate:model.created_at]];
    
    [self.mBlogTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self updateConstraints];
    [self layoutIfNeeded];
}

-(CGFloat)cellHeight{
    return self.commentCountLabel.height+self.commentCountLabel.y;
}

@end

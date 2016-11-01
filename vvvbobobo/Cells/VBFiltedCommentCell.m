//
//  VBFiltedCommentCell.m
//  vvvbobobo
//
//  Created by jinx huang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBFiltedCommentCell.h"

@implementation VBFiltedCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createUI];
    }
    return self;
}

-(void)_createUI{
    self.nameLabel=[UILabel new];
    self.areaLabel=[UILabel new];
    self.agreeLabel=[UILabel new];
    self.commentLabel=[UILabel new];
    self.indexLabel=[UILabel new];
    self.createTimeLabel=[UILabel new];
    
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    self.areaLabel.font=self.nameLabel.font;
    self.agreeLabel.font=self.nameLabel.font;
    self.indexLabel.font=self.nameLabel.font;
    self.commentLabel.font=self.nameLabel.font;
    self.createTimeLabel.font=self.nameLabel.font;
    self.commentLabel.numberOfLines=0;
    self.commentLabel.preferredMaxLayoutWidth=UIScreenWidth-20;
    
    [self.contentView addSubviews:@[self.nameLabel,self.areaLabel,self.agreeLabel,self.commentLabel,self.indexLabel,self.createTimeLabel]];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
    }];
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(20);
        make.top.equalTo(self.nameLabel);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.commentLabel.mas_bottom).offset(10);
    }];
    [self.agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.areaLabel.mas_right).offset(30);
        make.top.equalTo(self.areaLabel);
    }];
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView);
    }];
    
}

-(void)configWithModel:(VBCommentModel* )model{
    self.nameLabel.text=model.user.name;
    self.commentLabel.text=model.text;
    self.agreeLabel.text=[NSString stringWithFormat:@"赞:%zd",model.like_counts];
    self.areaLabel.text=model.user.location;
    self.indexLabel.text=[NSString stringWithFormat:@"%zd楼",model.index?model.index:0];
    self.createTimeLabel.text=[VBTools resolveSinaWeiboDate:model.created_at];
     CGFloat newHeight=[UILabel getHeightByWidth:UIScreenWidth-20 title:self.commentLabel.text font:self.commentLabel.font];
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self updateConstraints];
    [self layoutIfNeeded];
}

-(CGFloat)cellHeight{
    return self.areaLabel.y+self.areaLabel.height;
}

@end

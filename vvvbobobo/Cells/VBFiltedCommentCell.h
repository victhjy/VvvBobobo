//
//  VBFiltedCommentCell.h
//  vvvbobobo
//
//  Created by jinx huang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBBaseTableViewCell.h"
#import "VBCommentModel.h"
@interface VBFiltedCommentCell : VBBaseTableViewCell

@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* commentLabel;
@property(nonatomic,strong)UILabel* agreeLabel;
@property(nonatomic,strong)UILabel* areaLabel;
@property(nonatomic,strong)UILabel* indexLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)configWithModel:(VBCommentModel* )model;
-(CGFloat)cellHeight;
@end

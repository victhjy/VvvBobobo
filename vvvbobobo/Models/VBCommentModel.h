//
//  VBCommentModel.h
//  vvvbobobo
//
//  Created by jinx huang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VBUserModel.h"
@interface VBCommentModel : NSObject
@property (nonatomic, assign) NSInteger commentId;

@property (nonatomic, assign) NSInteger floor_number;

@property (nonatomic, assign) NSInteger source_allowclick;

@property(nonatomic,strong)NSString* mid;

@property(nonatomic,strong)NSArray* comments;

@property(nonatomic,strong)NSString* created_at;

@property (nonatomic, assign) NSInteger source_type;

@property (nonatomic, assign) NSInteger like_counts;

@property (nonatomic, assign) BOOL isLikedByMblogAuthor;

@property(nonatomic,strong)NSString* source;

@property (nonatomic, assign) NSInteger total_number;

@property(nonatomic,strong)NSString* idstr;

@property(nonatomic,strong)NSString* text;

@property (nonatomic, assign) NSInteger rootid;

@property (nonatomic, assign) NSInteger max_id;

@property (nonatomic, assign) BOOL liked;

@property(nonatomic,strong)VBUserModel* user;

@property(nonatomic,strong)NSArray* url_objects;

@property(nonatomic,assign)NSInteger index;
@end

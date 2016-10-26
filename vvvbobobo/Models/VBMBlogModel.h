//
//  VBMBlogModel.h
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VBUserModel.h"
@interface VBMBlogModel : NSObject
@property (nonatomic, assign) NSInteger mBlogId; ///< 微博ID

@property(nonatomic,strong)NSString* mid;

@property (nonatomic, assign) NSInteger appid;

@property(nonatomic,strong)NSString* created_at;

@property (nonatomic, assign) NSInteger source_type;

@property(nonatomic,strong)NSString* rid;

@property(nonatomic,strong)NSString* mblogid;

@property(nonatomic,strong)NSString* source;

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)NSString* mblogtypename;

@property (nonatomic, assign) NSInteger attitudes_status;

@property(nonatomic,strong)NSString* idstr;

@property(nonatomic,strong)NSString* text; ///<微博内容

@property(nonatomic,strong)NSDictionary* visible;

@property(nonatomic,strong)NSString* itemid;

@property(nonatomic,strong)NSString* scheme;

@property (nonatomic, assign) NSInteger comments_count;///<评论数

@property(nonatomic,strong)VBUserModel* user;

@property (nonatomic, assign) NSInteger recom_state;
@end

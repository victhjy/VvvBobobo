//
//  VBSearchResultModel.h
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VBMBlogModel.h"
@interface VBSearchResultModel : NSObject
@property(nonatomic,strong)NSString* card_type;

@property(nonatomic,strong)NSString* itemid;

@property(nonatomic,strong)NSString* scheme;

@property(nonatomic,strong)NSString* card_type_name;

@property (nonatomic, assign) NSInteger display_arrow;

@property(nonatomic,strong)NSString* title;

@property(nonatomic,strong)VBMBlogModel* mblog;

@property (nonatomic, assign) NSInteger show_type;

@property(nonatomic,strong)NSDictionary* actionlog;

@property(nonatomic,strong)NSString* openurl;
@end

//
//  VBMBlogModel.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBMBlogModel.h"

@implementation VBMBlogModel

+(NSDictionary* )mj_replacedKeyFromPropertyName{
    return @{
             @"mBlogId":@"id"
             };
}

@end

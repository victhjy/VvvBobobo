//
//  VBUserModel.m
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import "VBUserModel.h"

@implementation VBUserModel

+(NSDictionary* )mj_replacedKeyFromPropertyName{
    return @{
             @"userId":@"id",
             @"userClass":@"class",
             @"userDescription":@"description"
             };
}

@end

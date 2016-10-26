//
//  VBUserModel.h
//  vvvbobobo
//
//  Created by huangjinyang on 16/10/26.
//  Copyright © 2016年 huangjinyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBUserModel : NSObject
@property (nonatomic, assign) NSInteger userId;///<用户id

@property (nonatomic, assign) NSInteger bi_followers_count;

@property (nonatomic, assign) NSInteger urank;

@property(nonatomic,strong)NSString* profile_image_url;

@property (nonatomic, assign) NSInteger userClass;

@property(nonatomic,strong)NSString* province;

@property (nonatomic, assign) BOOL verified;

@property(nonatomic,strong)NSString* url;

@property (nonatomic, assign) NSInteger statuses_count;

@property (nonatomic, assign) BOOL geo_enabled;

@property (nonatomic, assign) BOOL follow_me;

@property(nonatomic,strong)NSString* userDescription;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger followers_count;

@property(nonatomic,strong)NSString* location;///<所在地

@property (nonatomic, assign) NSInteger mbrank;

@property(nonatomic,strong)NSString* avatar_large;

@property (nonatomic, assign) NSInteger star;

@property(nonatomic,strong)NSString* verified_trade;

@property(nonatomic,strong)NSString* profile_url;

@property(nonatomic,strong)NSString* weihao;

@property (nonatomic, assign) NSInteger online_status;

@property(nonatomic,strong)NSString* badge_top;

@property(nonatomic,strong)NSString* screen_name;

@property(nonatomic,strong)NSString* verified_source_url;

@property (nonatomic, assign) NSInteger pagefriends_count;

@property(nonatomic,strong)NSString* name;///<用户名

@property(nonatomic,strong)NSString* verified_reason;

@property (nonatomic, assign) NSInteger friends_count;

@property (nonatomic, assign) NSInteger mbtype;

@property (nonatomic, assign) NSInteger block_app;

@property (nonatomic, assign) NSInteger has_ability_tag;

@property(nonatomic,strong)NSString* avatar_hd;

@property (nonatomic, assign) NSInteger credit_score;

@property(nonatomic,strong)NSString* remark;

@property(nonatomic,strong)NSString* created_at;

@property (nonatomic, assign) NSInteger block_word;

@property (nonatomic, assign) NSInteger ulevel;

@property (nonatomic, assign) BOOL allow_all_act_msg;

@property(nonatomic,strong)NSString* domain;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) BOOL allow_all_comment;

@property(nonatomic,strong)NSString* verified_reason_url;

@property(nonatomic,strong)NSString* gender;

@property (nonatomic, assign) NSInteger favourites_count;

@property(nonatomic,strong)NSString* idstr;

@property (nonatomic, assign) NSInteger verified_type;

@property(nonatomic,strong)NSString* city;

@property(nonatomic,strong)NSString* verified_source;

@property(nonatomic,strong)NSDictionary* badge;

@property (nonatomic, assign) NSInteger user_ability;

@property(nonatomic,strong)NSDictionary* extend;

@property(nonatomic,strong)NSString* lang;

@property (nonatomic, assign) NSInteger ptype;

@property (nonatomic, assign) BOOL following;
@end

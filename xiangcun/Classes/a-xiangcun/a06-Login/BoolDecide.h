//
//  BoolDecide.h
//  HealthPilot
//
//  Created by quanwangwulian on 14-3-22.
//  Copyright (c) 2014年 quanwangwulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoolDecide : NSObject




//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;


//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//判读邮编
+ (BOOL) validateYouBian:(NSString *)youbian;

@end

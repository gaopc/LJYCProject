//
//  MyRegex.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

#define PHONENO  @"\\b(1)[3458][0-9]{9}\\b"//手机号正则表达式
#define ZIP_CODE @"\\b[0-9]{6}\\b"//邮政编码

#define NAME_CHINESE @"\\b[\u4e00-\u9fa5 ]{2,55}\\b"//中文名字

#define NAME_ENGLISH @"\\b[\a-zA-Z]{1,55}\\b"//英文名字

#define NAME_CHINESE_ENGLISH @"\\b[\u4e00-\u9fa5a-zA-Z0-9]{0,30}\\b"//中英文混合名字

#define EMAIL @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"//邮箱


#define DATE @"\\b((0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-8])|(0[13-9]|1[0-2])(29|30)|(0[13578]|1[02])31)\\b"//日期（月日）(格式 ：0213)

#define DATE1 @"\\b((0[1-9]|1[0-2])(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9]))\\b"//日期（月日）(格式 ：0213)

#define BIRTHDAY_REGEX   @"\\b((19[0-9]{2}|20((0[0-9]{1})|(1[0-1]{1})))(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))0229)\\b"//出生日期

#define PASSWARD @"\\b^[A-Za-z0-9]+${6,20}\\b"//密码输入设定 字母和数字 6-20位


#define NUMBER @"\\b[0-9]{1,6}\\b"

#define VERIFICATION_CODE  @"\\b[0-9]{1,4}\\b"

#define NUM_WARD @"\\b[a-zA-Z0-9]\\b"  

#define CERT_NUMBER @"\\b^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$\\b"//身份证号码验证

#define NAME_RULE_ZW @"\\b^[\u4e00-\u9fa5a-zA-Z0-9/]{2,55}$\\b" //验证中文名称

#define PASSPORT_CARD @"\\b^[A-Za-z0-9]+$\\b"

#define CREDIT_CARD @"\\b^[0-9]+$\\b"

#define ZHONGWEN_XINGMING @"\\b^[\u4e00-\u9fa5]+$\\b"//中文名字乘机人姓名全中文校验

#define ZHONGWENZIFU @"/[^u4E00-u9FA5] "//中文字符

//辣郊游
#define SHOP_NAME @"\\b^[\u4e00-\u9fa5a-zA-Z0-9]{0,50}$\\b"//中英文混合名字
#define PHOTO_NAME @"\\b[\u4e00-\u9fa5a-zA-Z0-9_]{0,50}\\b"//中英文混合名字

@interface MyRegex : NSObject

+(BOOL)checkname:(NSString*)name;
+(BOOL)checkIsCertificateNum:(NSString *)str;
+(BOOL)CheckLastNum:(NSString*)strNum;
@end

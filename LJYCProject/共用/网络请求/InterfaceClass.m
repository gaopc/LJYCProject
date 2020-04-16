//
//  InterfaceClass.m
//  FlightProject
//
//  Created by longcd on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InterfaceClass.h"
#import "PicModel.h"

@implementation InterfaceClass

// 三期访问接口

+(ASIFormDataRequest *)getConfigurationWithDeviceToken:(NSString *)deviceToken version:(NSString *)version userId:(NSString *)userId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/getConfiguration",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:deviceToken  forKey:@"deviceToken"];
    [theRequest setPostValue:version      forKey:@"version"];
    [theRequest setPostValue:userId       forKey:@"userId"];

    return theRequest;
}

+(ASIFormDataRequest *)getAddress:(NSString *)googleApiUrl
{
    NSLog(@"%@", googleApiUrl);
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",googleApiUrl]]];
    
    return theRequest;
}


+(ASIFormDataRequest *)getShopList:(ShopFindProperty *)shopFindProperty
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@shop/find",ThreeStagesOtherUrl]]];
    if (shopFindProperty._keyword.length > 0) {
        [theRequest setPostValue:@""  forKey:@"cityId"];
        [theRequest setPostValue:@""  forKey:@"districtId"];
        [theRequest setPostValue:@""  forKey:@"longitude"];
        [theRequest setPostValue:@""  forKey:@"latitude"];
    }
    else {
        [theRequest setPostValue:shopFindProperty._cityId  forKey:@"cityId"];
        [theRequest setPostValue:shopFindProperty._districtId  forKey:@"districtId"];
        [theRequest setPostValue:shopFindProperty._longitude  forKey:@"longitude"];
        [theRequest setPostValue:shopFindProperty._latitude  forKey:@"latitude"];
    }
	[theRequest setPostValue:shopFindProperty._type  forKey:@"type"];
	[theRequest setPostValue:shopFindProperty._orderBy  forKey:@"orderBy"];
	[theRequest setPostValue:shopFindProperty._serviceTagId  forKey:@"serviceTagId"];
	[theRequest setPostValue:shopFindProperty._distance  forKey:@"distance"];
	[theRequest setPostValue:shopFindProperty._pageIndex  forKey:@"pageIndex"];
	[theRequest setPostValue:shopFindProperty._keyword  forKey:@"keyword"];
	//[theRequest setPostValue:shopFindProperty._telephone  forKey:@"telephone"];
	[theRequest setPostValue:shopFindProperty._filter  forKey:@"filter"];
	
	
	
	
	return theRequest;
}

+(ASIFormDataRequest *)userLogin:(NSString*)userName password:(NSString*)password
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/login",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userName  forKey:@"username"];
    [theRequest setPostValue:[self md5:password]  forKey:@"password"];
    return theRequest;
}

+(ASIFormDataRequest *)userRegister:(NSString*)userName password:(NSString*)password
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/register",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userName  forKey:@"username"];
    [theRequest setPostValue:[self md5:password]  forKey:@"password"];
    return theRequest;
}

+(ASIFormDataRequest *)serviceTag
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@baseData/serviceTag",ThreeStagesOtherUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)getShopType//获取店铺类型
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@baseData/shopType",ThreeStagesOtherUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)getCountry//获取区县类型
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@baseData/district",ThreeStagesOtherUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)getCity//获取城市
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@baseData/city",ThreeStagesOtherUrl]]];
    return theRequest;
}
+(ASIFormDataRequest *)getConfiguration//获取统一配置
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@configuration",ThreeStagesOtherUrl]]];
    return theRequest;
}

+(ASIFormDataRequest *)advise:(NSString*)problem telephone:(NSString*)telephone email:(NSString*)email userId:(NSString *)userId userType:(NSString*)userType//投诉建议
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@advise",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:problem  forKey:@"problem"];
    [theRequest setPostValue:telephone  forKey:@"telephone"];
    [theRequest setPostValue:email  forKey:@"email"];
    [theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:userType  forKey:@"userType"];
    
    return theRequest;
}

+(ASIFormDataRequest *)addServiceTag:(NSString*)userId name:(NSString*)name//添加服务标签
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/addServiceTag",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:name  forKey:@"name"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)getShopDetail:(NSString*)userId withShopId:(NSString*)shopId withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@shop/detail",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:longitude  forKey:@"longitude"];
    [theRequest setPostValue:latitude  forKey:@"latitude"];
    return theRequest;
}

+ (ASIFormDataRequest *)getShopCommentList:(NSString*)userId withShopId:(NSString*)shopId withStar:(NSString *)star withFilter:(NSString *)filter withPageIndex:(NSString*)pageIndex withPageSize:(NSString *)size
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@shop/findComment",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:star  forKey:@"star"];
    [theRequest setPostValue:filter  forKey:@"filter"];
    [theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
    [theRequest setPostValue:size  forKey:@"pageSize"];
    return theRequest;
}

+ (ASIFormDataRequest *)getQuestionList:(NSString*)userId withShopId:(NSString*)shopId withFilter:(NSString *)filter withPageIndex:pageIndex withPageSize:(NSString *)size
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@shop/findQA",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:filter  forKey:@"filter"];
    [theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
    [theRequest setPostValue:size  forKey:@"pageSize"];
    return theRequest;
}

+ (ASIFormDataRequest *)getCheckCode :(NSString*)telephone//获取验证码
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getCheckCode",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:telephone  forKey:@"telephone"];
    return theRequest;
}

+ (ASIFormDataRequest *)createShop:(AddShopsData *)shopData
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/createShop",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:shopData._userId  forKey:@"userId"];
    [theRequest setPostValue:shopData._name  forKey:@"name"];
    [theRequest setPostValue:shopData._cityName  forKey:@"cityName"];
    [theRequest setPostValue:shopData._district  forKey:@"district"];
//    [theRequest setPostValue:shopData._picType  forKey:@"picType"];
    [theRequest setPostValue:shopData._picId  forKey:@"picId"];
    [theRequest setPostValue:shopData._address  forKey:@"address"];
    [theRequest setPostValue:shopData._longitude  forKey:@"longitude"];
    [theRequest setPostValue:shopData._latitude  forKey:@"latitude"];
    [theRequest setPostValue:shopData._type  forKey:@"type"];
    [theRequest setPostValue:shopData._serviceTagId  forKey:@"serviceTagId"];
    [theRequest setPostValue:shopData._otherServiewTagId  forKey:@"newServiceTagId"];
    [theRequest setPostValue:shopData._scale  forKey:@"scale"];
    [theRequest setPostValue:shopData._cycleStart  forKey:@"cycleStart"];
    [theRequest setPostValue:shopData._cycleEnd  forKey:@"cycleEnd"];
    [theRequest setPostValue:shopData._telephone  forKey:@"telephone"];
    [theRequest setPostValue:shopData._introduce  forKey:@"introduce"];
    [theRequest setPostValue:shopData._notice  forKey:@"notice"];
    return theRequest;
}

+ (ASIFormDataRequest *)userFindCollect:(CollectProperty *)collectProperty
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/findCollect",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:collectProperty._userId  forKey:@"userId"];
	[theRequest setPostValue:collectProperty._pageIndex  forKey:@"pageIndex"];
	[theRequest setPostValue:collectProperty._order  forKey:@"orderBy"];
	[theRequest setPostValue:collectProperty._shopTypeId  forKey:@"shopTypeId"];
	[theRequest setPostValue:collectProperty._cityId  forKey:@"cityId"];
	return theRequest;
}

+ (ASIFormDataRequest *)userAddCollect:(NSString*)userId shopId:(NSString*)shopId
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/addCollect",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
	[theRequest setPostValue:shopId  forKey:@"shopId"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)userDelCollect:(NSString*)userId shopId:(NSString*)shopId
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/delCollect",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
	[theRequest setPostValue:shopId  forKey:@"shopId"];
	
	return theRequest;
}

+ (NSString *) md5:(NSString *)str {
//	const char *cStr = [str UTF8String];
//	unsigned char result[16];
//	CC_MD5( cStr, strlen(cStr), result );
//	return [NSString stringWithFormat:
//			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//			result[0], result[1], result[2], result[3],
//			result[4], result[5], result[6], result[7],
//			result[8], result[9], result[10], result[11],
//			result[12], result[13], result[14], result[15]
//			];
    return str;
}

+ (ASIFormDataRequest *)resetPWDWithTelePhone:(NSString *)telephone password:(NSString*)password checkCode:(NSString*)checkCode//重置密码
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/reset",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:telephone  forKey:@"telephone"];
    [theRequest setPostValue:[self md5:password]  forKey:@"password"];
    [theRequest setPostValue:checkCode  forKey:@"checkCode"];
    return theRequest;
}

+(ASIFormDataRequest *)userInfo:(NSString*)userId //客户信息
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/info",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
	
	
	return theRequest;
}

+ (ASIFormDataRequest *)getUserCommentList:(NSString*)userId PageIndex:(NSString*)pageIndex//获取用户点评列表
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/findComment",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
	[theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)getUserQAList:(NSString*)userId PageIndex:(NSString*)pageIndex//获取用户问答列表
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/findQA",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
	[theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)shopError:(ShopForErrorData *)data
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/shopError",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:data._shopId  forKey:@"shopId"];
	[theRequest setPostValue:data._userId  forKey:@"userId"];
    [theRequest setPostValue:data._name  forKey:@"name"];
	[theRequest setPostValue:data._type  forKey:@"type"];
    [theRequest setPostValue:data._district  forKey:@"district"];
	[theRequest setPostValue:data._address  forKey:@"address"];
    [theRequest setPostValue:data._phone  forKey:@"phone"];
	[theRequest setPostValue:data._email  forKey:@"email"];
    [theRequest setPostValue:data._telephone  forKey:@"telephone"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)shopOtherError:(ShopForErrorData *)data
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/otherError",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:data._shopId  forKey:@"shopId"];
	[theRequest setPostValue:data._userId  forKey:@"userId"];
    [theRequest setPostValue:data._content  forKey:@"content"];
	[theRequest setPostValue:data._email  forKey:@"email"];
    [theRequest setPostValue:data._telephone  forKey:@"telephone"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)shopAddQuestion:(NSString *)shopId withUserId:(NSString *)userId withContent:(NSString *)content
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/question",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:shopId  forKey:@"shopId"];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:content  forKey:@"content"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)shopAddComment:(NSString *)shopId withUserId:(NSString *)userId withContent:(NSString *)content withStar:num
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/addComment",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:shopId  forKey:@"shopId"];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:content  forKey:@"content"];
    [theRequest setPostValue:num  forKey:@"star"];
	
	return theRequest;
}

+ (ASIFormDataRequest *)delMessage:(NSString*)messageId//删除消息
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/delMessage",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:messageId  forKey:@"messageId"];
    return theRequest;
}

+ (ASIFormDataRequest *)findMessage:(NSString*)userId pageIndex:(NSString*)pageIndex//消息列表
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/findMessage",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
    return theRequest;
}

+ (ASIFormDataRequest *)editPassword:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword //修改密码
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/editPassword",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:[self md5:oldPassword]  forKey:@"oldPassword"];
    [theRequest setPostValue:[self md5:newPassword]  forKey:@"newPassword"];
    return theRequest;
}

+ (ASIFormDataRequest *)userSingIn:(NSString*)userId pageIndex:(NSString*)pageIndex//签到
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/signInList",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
    return theRequest;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIImage* newImage = image;
    if (newSize.width > 1200) {
        newSize = CGSizeMake(1200, 1200*newSize.height/newSize.width);
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this newcontext, with the desired
        // new size
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        // Get the new image from the context
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        // End the context
        UIGraphicsEndImageContext();
        // Return the new image.
    }
    if (newImage.size.height > 1600  ) {
        newSize = CGSizeMake(1600 *newImage.size.width/newImage.size.height, 1600);
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this newcontext, with the desired
        // new size
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        // Get the new image from the context
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        // End the context
        UIGraphicsEndImageContext();
        // Return the new image.
    }
    
    return newImage;
}

+ (ASIFormDataRequest *)uploadPicture:(NSArray *)imgArray
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploadPicture",ThreeStagesOtherUrl]]];
    
	[theRequest setPostFormat:ASIMultipartFormDataPostFormat];
    
    NSString *zipPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    zipPath = [zipPath stringByAppendingPathComponent:@"temp"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:zipPath]) {
        [fileManager removeItemAtPath:zipPath error:nil];
    }
     [fileManager createDirectoryAtPath:zipPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    ZipArchive * zip = [[ZipArchive alloc] init];
    [zip CreateZipFile2:  [zipPath stringByAppendingPathComponent:@"temp.zip"] ];

    for (UIImage * image in imgArray) {
        
        float quality = 0.3;
        UIImage * tempImage = image;
        NSData *imageData = UIImageJPEGRepresentation(tempImage, quality);
        
        while (imageData.length >150*1024) {
            imageData = UIImageJPEGRepresentation(tempImage, quality);
            quality = quality-0.1;
            if (quality<0.05) {
                imageData = UIImageJPEGRepresentation(tempImage, 0.001);
                break;
            }
        }
        
        NSString * imageName = [NSString stringWithFormat:@"%d.jpg",[imgArray indexOfObject:image]];
        NSString * imagePath = [zipPath stringByAppendingPathComponent:imageName];
        [imageData writeToFile: imagePath atomically:YES ];
        [zip addFileToZip:imagePath newname: imageName];
    }

    [zip CloseZipFile2];
    [zip release];
    
    [theRequest addFile:[zipPath stringByAppendingPathComponent:@"temp.zip"] withFileName:@"iosPic.zip"  andContentType:@"application/zip" forKey:@"file"];
    
//    NSData * data = [NSData dataWithContentsOfFile:[zipPath stringByAppendingPathComponent:@"temp.zip"] ];
//    [theRequest addData:data withFileName:@"iosPic.zip" andContentType:@"application/zip" forKey:@"file"];
 
    return theRequest;
    
    
//	[theRequest setAllowCompressedResponse:YES]; //允许GIZP格式压缩数据流
    
//    theRequest.shouldCompressRequestBody = YES;
    
//	for (int i = 0; i < 1; i++) {
//		NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"上传照片00.png"]);
//		[theRequest addData:imageData withFileName:[NSString stringWithFormat:@"上传照片%d.png",i] andContentType:@"image/png" forKey:@"file"];
////        NSLog(@"%@",imageData);
//	}
//    return theRequest;
    
    
    
}

+ (ASIFormDataRequest *)shopSingIn:(NSString *)shopId withPageIndex:pageIndex
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@shop/signInList",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:pageIndex forKey:@"pageIndex"];
    return theRequest;
}

+ (ASIFormDataRequest *)setServiceTag:(NSString*)userId serviceTagId:(NSString*)serviceTagId//配置服务标签
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/setServiceTag",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:serviceTagId  forKey:@"serviceTagId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userBinding:(NSString*)userId telephone:(NSString*)telephone  checkCode:(NSString*)checkCode  referee:(NSString*)referee//绑定手机
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/binding",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:telephone  forKey:@"telephone"];
    [theRequest setPostValue:referee  forKey:@"referee"];
    [theRequest setPostValue:checkCode  forKey:@"checkCode"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userDelBinding:(NSString*)userId telephone:(NSString*)telephone  checkCode:(NSString*)checkCode
{
	ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/delBinding",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:telephone  forKey:@"telephone"];
    [theRequest setPostValue:checkCode  forKey:@"checkCode"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)signIn:(NSString*)userId withShopId:(NSString*)shopId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/signIn",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)uploadPicture:(NSString*)userId withShopId:(NSString*)shopId withImageArr:(NSArray *)imgArray
{
    NSString *imgNmae = @"";
    NSString *imgType = @"";
    NSString *imgId = @"";
    for (int i = 0; i < imgArray.count; i++) {
        
        PicModel * picModel = [imgArray objectAtIndex:i];
        
        if (i == 0) {
            imgNmae = picModel._imgName;
            imgType = picModel._imgType;
            imgId = picModel._imgId;
            
        }
        else {
            imgNmae = [imgNmae stringByAppendingFormat:@"&%@", picModel._imgName];
            imgType = [imgType stringByAppendingFormat:@"&%@", picModel._imgType];
            imgId = [imgId stringByAppendingFormat:@"&%@", picModel._imgId];
        }
    }
    
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/uploadPicture",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:imgNmae  forKey:@"name"];
    [theRequest setPostValue:imgType  forKey:@"type"];
    [theRequest setPostValue:imgId  forKey:@"id"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userPhotoList:(NSString*)userId withPageIndex:(NSString *)index;
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/findPicture",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:index  forKey:@"pageIndex"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)shopPhotoList:(NSString*)shopId withType:(NSString *)picType withIndex:(NSString *)pageIndex
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@shop/findPicture",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:picType  forKey:@"pictureType"];
    [theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userLoginOther:(NSString*)account type:(NSString *)type token:(NSString *)token
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/loginOther",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:account  forKey:@"account"];
    [theRequest setPostValue:type  forKey:@"type"];
    [theRequest setPostValue:token  forKey:@"token"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userSetNickname:(NSString*)userId nickname :(NSString *)nickname
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/setNickname",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:nickname  forKey:@"nickname"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userPhotoEdit:(NSString*)picId withUserId:(NSString *)userId withName:(NSString *)photoName withType:(NSString *)photoType
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/editPicture",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:picId  forKey:@"picId"];
    [theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:photoName  forKey:@"name"];
    [theRequest setPostValue:photoType  forKey:@"type"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)userPhotoDelete:(NSString *)userId withId:(NSString *)photoId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/delPicture",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:photoId  forKey:@"picId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)shopError:(NSString *)userId withShopId:(NSString *)shopId withErrorType:(NSString *)errorType
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/error",ThreeStagesOtherUrl]]];
	[theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:errorType  forKey:@"type"];
    
    return theRequest;
}

//+ (ASIFormDataRequest *)submitOrder:(NSString *)userId withOrderId:(NSString *)orderId withId:(NSString *)groupPurId withCount:(NSString *)count withPhone:(NSString *)phoneNum; //提交订单
//{
//    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/submitOrder",ThreeStagesOtherUrl]]];
//    [theRequest setPostValue:userId  forKey:@"userId"];
//    [theRequest setPostValue:orderId  forKey:@"orderId"];
//    [theRequest setPostValue:groupPurId  forKey:@"groupPurId"];
//    [theRequest setPostValue:count  forKey:@"count"];
//    [theRequest setPostValue:phoneNum  forKey:@"telephone"];
//    
//    return theRequest;
//}

+ (ASIFormDataRequest *)submitOrder:(NSString *)userId withOrderId:(NSString *)orderId withId:(NSString *)groupPurId withshopId:(NSString *)shopId withCount:(NSString *)count withToutalPrice:(NSString *)totalPrice withPhone:(NSString *)phoneNum withPayType:(NSString *)payType //提交订单
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/submitVouchersOrder",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:orderId  forKey:@"orderId"];
    [theRequest setPostValue:groupPurId  forKey:@"vouchersId"];
    [theRequest setPostValue:shopId  forKey:@"shopId"];
    [theRequest setPostValue:count  forKey:@"count"];
    [theRequest setPostValue:totalPrice  forKey:@"totalPrice"];
    [theRequest setPostValue:phoneNum  forKey:@"telephone"];
    [theRequest setPostValue:payType  forKey:@"payType"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)groupPurDetail:(NSString *)groupPurId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/detailVouchers",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:groupPurId forKey:@"voucherId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)examineCheckCode:(NSString *)telephone checkCode:(NSString*)checkCode
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@examineCheckCode",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:telephone forKey:@"telephone"];
    [theRequest setPostValue:checkCode forKey:@"checkCode"];
    return theRequest;
}

+(ASIFormDataRequest *)getMessageState:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/pay/getPackets",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:orderId    forKey:@"orderId"];
    [theRequest setPostValue:payType   forKey:@"type"];
    return theRequest;
}

+(ASIFormDataRequest *)getOrdersState:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType withPackets:(NSString *)packets
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/pay/submitResult",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:userId     forKey:@"userId"];
    [theRequest setPostValue:orderId    forKey:@"orderId"];
    [theRequest setPostValue:[NSNumber numberWithInt:[payType intValue]] forKey:@"type"];
    [theRequest setPostValue:packets    forKey:@"packets"];
    return theRequest;
}

+ (ASIFormDataRequest *)findOrder:(NSString *)userId filter:(NSString*)filter pageIndex:(NSString*)pageIndex
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/findVouchersOrder",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:@"000253e303d64313867a1c8916c551c3"  forKey:@"userId"];
    [theRequest setPostValue:filter  forKey:@"status"];
    [theRequest setPostValue:pageIndex  forKey:@"pageIndex"];
    return theRequest;
}

+ (ASIFormDataRequest *)orderDetail:(NSString *)orderId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/orderDetail",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:orderId  forKey:@"orderId"];
    return theRequest;
}

+ (ASIFormDataRequest *)cancelOrder:(NSString *)orderId
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/cancelVouchersOrder",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:orderId  forKey:@"orderId"];
    return theRequest;
}

+ (ASIFormDataRequest *)submitVouchersRefund:(NSString *)orderId withCount:(NSString *)count withPhone:(NSString *)phoneNum//申请退款
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/submitVouchersRefund",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:orderId  forKey:@"orderId"];
    [theRequest setPostValue:count  forKey:@"count"];
    [theRequest setPostValue:phoneNum  forKey:@"telephone"];
    
    return theRequest;

}
+ (ASIFormDataRequest *)getPackets:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType ; //获取报文
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pay/getPackets",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:orderId  forKey:@"orderId"];
    [theRequest setPostValue:payType  forKey:@"type"];
    
    return theRequest;
}
+ (ASIFormDataRequest *)submitResult:(NSString *)userId withOrderId:(NSString *)orderId withPayType:(NSString *)payType withpackets:(NSString *)packets; //通知支付结果
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pay/submitResult",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:userId  forKey:@"userId"];
    [theRequest setPostValue:orderId  forKey:@"orderId"];
    [theRequest setPostValue:payType  forKey:@"type"];
    [theRequest setPostValue:packets  forKey:@"packets"];

    return theRequest;
}
+ (ASIFormDataRequest *)actives_find; //活动列表
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@actives/find",ThreeStagesOtherUrl]]];
    
    return theRequest;
}
+ (ASIFormDataRequest *)actives_findShop:(NSString *)actviesid distance:(NSString *)distance longitude:(NSString *)longitude latitude:(NSString *)latitude; //活动搜索出附近农家乐
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@actives/findShop",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:actviesid  forKey:@"actviesid"];
    [theRequest setPostValue:distance  forKey:@"distance"];
    [theRequest setPostValue:longitude  forKey:@"lon"];
    [theRequest setPostValue:latitude  forKey:@"lat"];
    
    return theRequest;
}
+ (ASIFormDataRequest *)actives_detail:(NSString *)actviesid; //活动详情
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@actives/detail",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:actviesid  forKey:@"activesId"];
    
    return theRequest;
}

+ (ASIFormDataRequest *)recommendShop:(NSString *)actviesid //活动推荐店铺
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@actives/recommendShop",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:actviesid  forKey:@"activesId"];
    
    return theRequest;
}


+ (ASIFormDataRequest *)orderVouchersDetail:(NSString *)orderId //代金券订单详情
{
    ASIFormDataRequest *theRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/orderVouchersDetail",ThreeStagesOtherUrl]]];
    [theRequest setPostValue:orderId forKey:@"orderId"];
    
    return theRequest;
}
@end
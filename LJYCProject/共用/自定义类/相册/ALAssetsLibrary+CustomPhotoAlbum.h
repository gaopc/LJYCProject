//
//  ALAssetsLibrary+CustomPhotoAlbum.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-12-12.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^SaveImageCompletion)(NSError* error);
@interface ALAssetsLibrary(CustomPhotoAlbum)
-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
@end

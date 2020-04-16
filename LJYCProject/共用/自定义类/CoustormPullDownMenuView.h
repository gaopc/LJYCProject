//
//  CoustormPullDownMenuView.h
//  LJYCProject
//
//  Created by 张晓婷 on 13-10-30.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoustormPullDownMenuViewProtocol <NSObject>

-(void) selectedString:(NSString *) str;
-(void) selectedIndex:(NSString *) index;

@end

@interface CoustormPullDownMenuView : UIView
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSArray * array;
@property (nonatomic,retain) NSString * placeStr;
@property (nonatomic,retain) NSString * selectedString;
@property (nonatomic,readonly) int  selectedIndex;
-(void ) closeView;
@end


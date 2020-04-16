//
//  CoustomPickerView.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-1.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerView : UIAlertView <UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *selectPicker;
} 
@property (nonatomic, retain) NSArray *_majorNames;
@property (nonatomic, retain) NSString *_selectedMajor;
@property (nonatomic, retain) NSString *_selectedLine;
@end

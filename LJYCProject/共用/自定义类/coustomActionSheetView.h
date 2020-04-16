//
//  coustomActionSheetView.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-4.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coustomActionSheetView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UISubLabel *titleLabel;
    UIButton *leftButton;
    UIButton *rightButton;
    UIPickerView *locatePicker;
    NSArray *dataArray;
}
@property (nonatomic, retain) NSString *_selectStr;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)array;
- (void)showInView:(UIView *)view;
@end

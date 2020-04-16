//
//  KeyBoardTopBar.h
//  KeyBoardTopBar
//
//  Created by 月 小 on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 调用方法
 -(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
 {
 if (self.keyboardbar == nil) {
 KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view ];
 self.keyboardbar = _keyboardbar;
 [_keyboardbar release];
 }
 [keyboardbar showBar:textField];  //显示工具条 
 return YES;
 }

 */

@interface KeyBoardTopBar : NSObject

@property(nonatomic,retain)UIToolbar *toolBar;   //工具条
@property(nonatomic,retain)NSArray *textFields;
@property(nonatomic,retain)UIView  *currentView;                //当前VIEW
@property(nonatomic,retain)UIView *   currentTextField;           //当前输入框
@property(nonatomic,retain)UIBarButtonItem       *prevButtonItem;             //上一项按钮
@property(nonatomic,retain)UIBarButtonItem       *nextButtonItem;             //下一项按钮
@property(nonatomic,retain)UIBarButtonItem       *hiddenButtonItem;           //隐藏按钮
@property(nonatomic,retain)UIBarButtonItem       *spaceButtonItem;            //空白按钮

-(id)init:(NSArray*)_textFieldsArray view:(UIView *) view ;
//-(void)showPrevious;
//-(void)showNext;
-(void)showBar:(UIView *)_textField;
-(void)HiddenKeyBoard; //崔立东 在乘机人列表使用该方法
//-(void)setTextFieldsArray:(NSArray *)_array;
//- (void)registerForKeyboardNotifications;
@end

//
//  PTTextFieldCell.h
//  PTTextFieldCell
//
//  Created by Phillip Harris on 4/25/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTTextFieldWithMargins;
@protocol PTTextFieldCellDelegate;

extern NSString * const PTTextFieldCellReuseIdentifier;

@interface PTTextFieldCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet PTTextFieldWithMargins *textField;

@property (nonatomic, weak) id <PTTextFieldCellDelegate> delegate;

@end


@protocol PTTextFieldCellDelegate <NSObject>

@optional

- (BOOL)textFieldCellShouldBeginEditing:(PTTextFieldCell *)cell;
- (void)textFieldCellDidBeginEditing:(PTTextFieldCell *)cell;
- (BOOL)textFieldCellShouldEndEditing:(PTTextFieldCell *)cell;
- (void)textFieldCellDidEndEditing:(PTTextFieldCell *)cell;
- (BOOL)textFieldCell:(PTTextFieldCell *)cell shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)textFieldCellShouldClear:(PTTextFieldCell *)cell;
- (BOOL)textFieldCellShouldReturn:(PTTextFieldCell *)cell;
- (BOOL)textFieldCellDidChange:(PTTextFieldCell *)cell;

@end


@interface PTTextFieldWithMargins : UITextField

@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;

@end
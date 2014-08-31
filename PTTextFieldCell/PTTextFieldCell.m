//
//  PTTextFieldCell.m
//  PTTextFieldCell
//
//  Created by Phillip Harris on 4/25/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import "PTTextFieldCell.h"

NSString * const PTTextFieldCellReuseIdentifier = @"PTTextFieldCellReuseIdentifier";

@implementation PTTextFieldCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textField = [[PTTextFieldWithMargins alloc] initWithFrame:self.contentView.bounds];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self formatTextField:_textField];
        
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_textField];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textField);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textField]|" options:0 metrics:0 views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textField]|" options:0 metrics:0 views:viewsDictionary]];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self formatTextField:self.textField];
}

- (void)formatTextField:(PTTextFieldWithMargins *)textField {
    
    textField.leftMargin = 15.0;
    textField.rightMargin = 15.0;
}

//===============================================
#pragma mark -
#pragma mark Editing Changed
//===============================================
- (IBAction)textFieldDidChange:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellDidChange:)]) {
        [self.delegate textFieldCellDidChange:self];
    }
}

//===============================================
#pragma mark -
#pragma mark UITextFieldDelegate
//===============================================

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldBeginEditing:)]) {
        return [self.delegate textFieldCellShouldBeginEditing:self];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellDidBeginEditing:)]) {
        [self.delegate textFieldCellDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldEndEditing:)]) {
        return [self.delegate textFieldCellShouldEndEditing:self];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellDidEndEditing:)]) {
        [self.delegate textFieldCellDidEndEditing:self];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCell:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textFieldCell:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldClear:)]) {
        return [self.delegate textFieldCellShouldClear:self];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellShouldReturn:)]) {
        return [self.delegate textFieldCellShouldReturn:self];
    }
    return YES;
}

@end


@implementation PTTextFieldWithMargins

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGFloat allowanceForClearButton = 0.0;
    if (self.clearButtonMode == UITextFieldViewModeAlways || self.clearButtonMode == UITextFieldViewModeUnlessEditing) {
        allowanceForClearButton = 25.0;
    }
    
    CGRect frm = bounds;
    frm.origin.x += self.leftMargin;
    frm.size.width -= (self.leftMargin + self.rightMargin + allowanceForClearButton);
    
    return frm;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGFloat allowanceForClearButton = 0.0;
    if (self.clearButtonMode == UITextFieldViewModeAlways || self.clearButtonMode == UITextFieldViewModeWhileEditing) {
        allowanceForClearButton = 25.0;
    }
    
    CGRect frm = bounds;
    frm.origin.x += self.leftMargin;
    frm.size.width -= (self.leftMargin + self.rightMargin + allowanceForClearButton);
    
    return frm;
}

@end
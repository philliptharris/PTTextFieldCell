//
//  MyTableViewController.m
//  PTTextFieldCell
//
//  Created by Phillip Harris on 4/25/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import "MyTableViewController.h"

#import "PTTextFieldCell.h"

@interface MyTableViewController () <PTTextFieldCellDelegate>

@end

@implementation MyTableViewController

//===============================================
#pragma mark -
#pragma mark Initialization
//===============================================

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
}

//===============================================
#pragma mark -
#pragma mark View
//===============================================

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[PTTextFieldCell class] forCellReuseIdentifier:PTTextFieldCellReuseIdentifier];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PTTextFieldCell class]) bundle:nil] forCellReuseIdentifier:PTTextFieldCellReuseIdentifier];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}

//===============================================
#pragma mark -
#pragma mark UITableViewDataSource
//===============================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:PTTextFieldCellReuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.separatorInset = UIEdgeInsetsZero;
    
//    cell.textField.userInteractionEnabled = NO;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textField.placeholder = (indexPath.row == 0) ? @"First" : @"Last";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PTTextFieldCell *cell = (PTTextFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
    
//    cell.textField.userInteractionEnabled = YES;
    [cell.textField becomeFirstResponder];
}

//===============================================
#pragma mark -
#pragma mark PTTextFieldCellDelegate
//===============================================

- (BOOL)textFieldCellShouldBeginEditing:(PTTextFieldCell *)cell {
    return YES;
}
- (void)textFieldCellDidBeginEditing:(PTTextFieldCell *)cell {
    
}
- (BOOL)textFieldCellShouldEndEditing:(PTTextFieldCell *)cell {
    return YES;
}
- (void)textFieldCellDidEndEditing:(PTTextFieldCell *)cell {
    
//    cell.textField.userInteractionEnabled = NO;
}
- (BOOL)textFieldCell:(PTTextFieldCell *)cell shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
- (BOOL)textFieldCellShouldClear:(PTTextFieldCell *)cell {
    return YES;
}
- (BOOL)textFieldCellShouldReturn:(PTTextFieldCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (!indexPath) {
        [cell.textField resignFirstResponder];
        return YES;
    }
    
    NSInteger nextRow = indexPath.row + 1;
    
    if ([self tableView:self.tableView numberOfRowsInSection:indexPath.section] > nextRow) {
        
        UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:nextRow inSection:indexPath.section]];
        
        if ([nextCell isKindOfClass:[PTTextFieldCell class]]) {
            
            PTTextFieldCell *textFieldCell = (PTTextFieldCell *)nextCell;
            
//            textFieldCell.textField.userInteractionEnabled = YES;
            [textFieldCell.textField becomeFirstResponder];
            return YES;
        }
    }
    
    [cell.textField resignFirstResponder];
    return YES;
}

@end

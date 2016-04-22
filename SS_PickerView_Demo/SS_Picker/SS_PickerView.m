//
//  SS_PickerView.m
//  TableWithBlock
//
//  Created by Sagar Shirbhate on 22/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "SS_PickerView.h"

@implementation SS_PickerView


#pragma mark +++++++++++++++ INITIALIZE  +++++++++++++++++++++++++

+(SS_PickerView *)pickerInitWithNumberOFRows:(numberOfRowsBlock)rowsBlock andPickerCell:(PickerCellsBlock)cellBlock WithTextField:(UITextField *)TF{
    return [[self alloc]initWithNumberOfRows:rowsBlock andPickerCell:cellBlock WithTextField:TF];
}

-(id)initWithNumberOfRows:(numberOfRowsBlock)rowsBlock andPickerCell:(PickerCellsBlock)cellBlock WithTextField:(UITextField *)TF {
    self = [super init];
    if (self)
    {
        _picker = [UIPickerView new];
        _rows = rowsBlock;
        _cell  = cellBlock;
        _fromTextField=TF;
        _showsSelectionIndicator=YES;
        _backgroundColor=_picker.backgroundColor;
        _tintColor=_picker.tintColor;
        _barColor=[UIColor blackColor];
        _tagForPicker=0;
    }
    return self;
}


-(void)configureSelectionBlock:(pickerSelectionBlock)selBlock andCompletionBlock:(pickerCompletionBlock)comBlock
{
    self.selectionBlock = selBlock;
    self.completionBlock = comBlock;
}

#pragma mark +++++++++++++++ SHOW PICKER  +++++++++++++++++++++++++

-(void)show{
    
    //Set Picker Properties
    _picker.dataSource = self;
    _picker.delegate = self;
    _picker.tintColor=_tintColor;
    _picker.showsSelectionIndicator=_showsSelectionIndicator;
    _picker.backgroundColor=_backgroundColor;
    _picker.tag=_tagForPicker;
    
    
    //For Ipad ios9
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        [_fromTextField resignFirstResponder];
        UIViewController *parent  =(UIViewController *) [self.superview nextResponder];
        UIViewController *destinationViewController =[UIViewController new];
        destinationViewController.modalPresentationStyle = UIModalPresentationPopover;
        destinationViewController.popoverPresentationController.sourceView = _fromTextField;
        [destinationViewController.view addSubview:_picker];
        destinationViewController.popoverPresentationController.sourceRect =_picker.frame;
        destinationViewController.preferredContentSize=CGSizeMake(_picker.frame.size.width, _picker.frame.size.height);
        [parent presentViewController:destinationViewController animated:YES completion:nil];
        
    }else{
        
        // For iPHONE
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                       target:self action:@selector(dismiss)];
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                              CGRectMake(0, self.superview.frame.size.height-
                                         _picker.frame.size.height-50, self.superview.frame.size.width, 50)];
        [toolBar setBarStyle:UIBarStyleBlackOpaque];
        toolBar.backgroundColor=_barColor;
        NSArray *toolbarItems = [NSArray arrayWithObjects:
                                 doneButton, nil];
        [toolBar setItems:toolbarItems];
        _fromTextField.inputView = _picker;
        _fromTextField.inputAccessoryView = toolBar;
        [_fromTextField becomeFirstResponder];
        
    }
}

#pragma mark +++++++++++++++ Dissmiss +++++++++++++++++++++++++++
-(void)dismiss
{
    [self.superview endEditing:YES];
    if (self.completionBlock != nil)
    {
        self.completionBlock();
    }
}


#pragma mark +++++++++++++++ Picker View Data source+++++++++++++++++++++++++++
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return self.rows(component);
}

#pragma mark+++++++++++++++  Picker View Delegate ++++++++++++++++++++++++++++

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    self.selectionBlock(row);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return self.cell(self,row,component);
}



@end

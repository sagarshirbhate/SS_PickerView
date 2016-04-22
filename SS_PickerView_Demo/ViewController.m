//
//  ViewController.m
//  SS_PickerView_Demo
//
//  Created by Sagar Shirbhate on 22/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import "ViewController.h"
#import "SS_PickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self openPicker];// As textfield start editing open picker
}




#pragma mark++++++++ Whole Picker in 1 Method ++++++++++++++++++++++++
-(void)openPicker{
    
    // Your Array
    NSArray * a = @[@"Sagar", @"Chandan", @"Rushi"];
    
    //Initialize Picker and Set the DataSources here
    SS_PickerView * picker =[SS_PickerView pickerInitWithNumberOFRows:^NSInteger(NSInteger count) {
        return a.count;
    } andPickerCell:^NSString *(SS_PickerView *picker, NSInteger row, NSInteger coponent) {
        return [a objectAtIndex:row];
    } WithTextField:_textField];
    
    
    // Need to add View To Handle the actions
     [self.view addSubview:picker];
    [picker show];
    
    
    //Completion and Selection Handelled Here
    [picker configureSelectionBlock:^(NSInteger selectedIndex) {
        [_textField setText:[a objectAtIndex:selectedIndex]];
    } andCompletionBlock:^{
        [picker removeFromSuperview];
    }];

}

@end

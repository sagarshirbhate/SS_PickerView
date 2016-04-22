//
//  SS_PickerView.h
//  TableWithBlock
//
//  Created by Sagar Shirbhate on 22/04/16.
//  Copyright © 2016 Sagar Shirbhate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SS_PickerView;

typedef NSInteger (^numberOfRowsBlock)(NSInteger count);
typedef NSString* (^PickerCellsBlock)(SS_PickerView *alert, NSInteger row ,NSInteger coponent);
typedef void (^pickerSelectionBlock)(NSInteger selectedIndex);
typedef void (^pickerCompletionBlock)(void);


@interface SS_PickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, strong) pickerCompletionBlock completionBlock;
@property (nonatomic, strong) pickerSelectionBlock selectionBlock;
@property (nonatomic, strong) numberOfRowsBlock rows;
@property (nonatomic, strong) PickerCellsBlock cell;

@property(nonatomic,strong)  UITextField * fromTextField;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, assign) BOOL showsSelectionIndicator;
@property(nonatomic,strong) UIColor * backgroundColor;
@property(nonatomic,strong) UIColor * barColor;
@property(nonatomic,strong) UIColor * tintColor;
@property(nonatomic,assign) int tagForPicker ;


+(SS_PickerView *)pickerInitWithNumberOFRows:(numberOfRowsBlock)rowsBlock andPickerCell:(PickerCellsBlock)cellBlock WithTextField:(UITextField *)TF;


-(id)initWithNumberOfRows:(numberOfRowsBlock)rowsBlock andPickerCell:(PickerCellsBlock)cellBlock WithTextField:(UITextField *)TF ;


-(void)configureSelectionBlock:(pickerSelectionBlock)selBlock andCompletionBlock:(pickerCompletionBlock)comBlock;

-(void)show;

-(void)dismiss;

@end


# SS_PickerView
* Simple solution for UIPickerview
* No Delegate,Datasource Required to write
* All handelled in single method

<sub>Add Following Files to your project</sub>
-
 - ```SS_PickerView.h```
 - ```SS_PickerView.m```
 


<sub>Import where you want to use</sub>
-
```javascript
#import "SS_PickerView.h"
```
<sub>Call this method for opening picker</sub>
-
```javascript
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
```
<sub>Output will come like this</sub>
-
| iPhone    | iPad|
| ------------- |:-------------:|
| ![ScreenShot](http://i.giphy.com/GAdk40Htui3iE.gif)|![ScreenShot](http://i.giphy.com/pKw3Mq6Q4TFQY.gif)|


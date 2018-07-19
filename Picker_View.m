//
//  Picker_View.m
//  FlightPass
//
//  Created by Vemanatha on 5/12/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import "Picker_View.h"

#define PICKER_HEIGHT 200
#define TOOLBAR_HEIGHT 44
#define ZERO_VALUE 0

@implementation Picker_View

- (void)drawRect:(CGRect)rect
{
    
    
    pickerBcVc  = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height-64)];
    pickerBcVc.backgroundColor = [UIColor blackColor];
    pickerBcVc.alpha = 0.0;
    myPicker.alpha = 0.0;
    toolBar.alpha = 0.0;
    [self addSubview:pickerBcVc];
    [self showPicker];
    
    [UIView animateWithDuration:0.2f  delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         pickerBcVc.alpha = 0.7;
                         myPicker.alpha = 1.0;
                         toolBar.alpha = 1.0;
                         
                     }completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.0f delay:0.0f options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              
                                          } completion:nil];
                     }];
    
}

-(void)showPicker
{
    
    DLog(@"selectedIndex--%ld",(long)_selectedIndex);
    myPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(ZERO_VALUE, self.frame.size.height-PICKER_HEIGHT, self.frame.size.width, PICKER_HEIGHT)];
    [myPicker setDataSource: self];
    [myPicker setDelegate: self];
    myPicker.showsSelectionIndicator = YES;
    myPicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:myPicker];
    
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(ZERO_VALUE,myPicker.frame.origin.y-TOOLBAR_HEIGHT,self.frame.size.width,TOOLBAR_HEIGHT)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    NSString *doneStr = [[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_Selection_Done_Label"];
    NSString *cancelStr = [[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_Cancel_Label"];
    
    UIBarButtonItem *barButtonCancel = [[UIBarButtonItem alloc] initWithTitle:cancelStr  style:UIBarButtonItemStylePlain target:self action:@selector(datepickerCancelAction)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    [button setTitle:doneStr forState:UIControlStateNormal & UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.tag = self.tag;
    [button addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=16;
    button.layer.borderWidth=2.0;
    button.layer.borderColor=[[UIColor colorWithRed:197.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1] CGColor];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonCancel,flexSpace,barButtonDone,nil];
    toolBar.alpha = 0.0;
    [self addSubview:toolBar];
    
 
    
    [myPicker selectRow:_selectedIndex inComponent:0 animated:YES];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [_picker_PrefixData count];
}

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_picker_PrefixData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    row = [pickerView selectedRowInComponent:0];
    _selectedIndex = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView  viewForRow:(NSInteger)row  forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    
    DLog(@"_picker_PrefixData----%@",_picker_PrefixData);
    if (self.tag == 111)
    {
        channelLabel.text = [NSString stringWithFormat:@"%@",[[_picker_PrefixData objectAtIndex:row] objectForKey:@"passLabel"]];
    }
    if (self.tag == 222)
    {
        if ([[_picker_PrefixData objectAtIndex:row] objectForKey:@"Select"])
        {
            channelLabel.text = [NSString stringWithFormat:@"Select"];
        }
        else
        {
            channelLabel.text = [NSString stringWithFormat:@"%@",[[_picker_PrefixData objectAtIndex:row] objectForKey:@"Flight_PNR_Label"]];
        }
    }
    if (self.tag == 1000)
    {
            channelLabel.text = [NSString stringWithFormat:@"%@",[[_picker_PrefixData objectAtIndex:row] objectForKey:@"Extension"]];
    }
    else if (self.tag == 2000)
    {
            channelLabel.text = [NSString stringWithFormat:@"%@",[[_picker_PrefixData objectAtIndex:row] objectForKey:@"PrefixLabel"]];
    }
    channelLabel.textAlignment = NSTextAlignmentCenter;
    channelLabel.backgroundColor = [UIColor whiteColor];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, 30)];
    tmpView.backgroundColor = [UIColor whiteColor];
    [tmpView insertSubview:channelLabel atIndex:0];
    
    return tmpView;
}

-(void)doneButtonAction:(id)sender
{
    NSDictionary *theInfo;
    if (self.tag == 111)
    {
        DLog(@"country code obj---%@",[_picker_PrefixData objectAtIndex:_selectedIndex]);
        NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_selectedIndex],@"SelectedIndex", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeflightPickerSeelct_Noti"  object:self  userInfo:theInfo];
    }
    else if ([sender tag] == 222)
    {
        DLog(@"second page country code obj---%@",[_picker_PrefixData objectAtIndex:_selectedIndex]);
        NSDictionary *theInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_selectedIndex],@"SelectedIndex", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"second_page_seclectd_Noti"  object:self  userInfo:theInfo];
    }
    else if ([sender tag] == 1000)
    {
        DLog(@"country code obj---%@",[_picker_PrefixData objectAtIndex:_selectedIndex]);
    }
    else if ([sender tag] == 2000)
    {
        DLog(@"prefix obj---%@",[_picker_PrefixData objectAtIndex:_selectedIndex]);
    }
    
    if (myPicker)
    {
        [self removeFromSuperview];
        [myPicker removeFromSuperview];
        [toolBar removeFromSuperview];
        
    }
    
    theInfo = [NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%ld",(long)[sender tag]],@"sender",
                                                          [_picker_PrefixData objectAtIndex:_selectedIndex],@"selectedObj",
                                                          [NSString stringWithFormat:@"%ld",(long)_selectedIndex],@"selectedInd", nil];

    //[[NSNotificationCenter defaultCenter] postNotificationName:@"Picker_Obj_NOTI" object:self userInfo:theInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Reg_Picker_Obj_NOTI" object:self userInfo:theInfo];

}

-( void)datepickerCancelAction
{
    if ([myPicker superview])
    {
        [self removeFromSuperview];
        [myPicker removeFromSuperview];
        [toolBar removeFromSuperview];
    }
}

@end

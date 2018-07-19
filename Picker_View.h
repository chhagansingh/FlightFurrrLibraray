//
//  Picker_View.h
//  FlightPass
//
//  Created by Vemanatha on 5/12/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Picker_View : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *pickerBcVc;
    UIPickerView *myPicker;
    UIToolbar * toolBar,*toolBar2;
    NSMutableArray *pickerData;
    NSMutableDictionary *selectedCountryData;

}
@property(nonatomic,strong) NSMutableArray * picker_PrefixData;
@property(nonatomic,strong) NSMutableArray * imageList;
@property(nonatomic,strong) NSMutableArray * languageList;
@property(assign)     NSInteger selectedIndex;

@end

//
//  MyBookingVC.h
//  FlightPass
//
//  Created by NitiN Kanojia on 7/14/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBookingCell.h"

@interface MyBookingVC : UIViewController<UIGestureRecognizerDelegate>
{
    NSMutableArray      *arrayForBool;
    UITapGestureRecognizer *selectedGesture;
}
@end

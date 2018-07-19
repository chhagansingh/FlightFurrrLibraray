//
//  ChangeFlights_select.h
//  FlightPass
//
//  Created by NitiN Kanojia on 7/16/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectChangeFlightVC.h"

@interface ChangeFlights_select : UIViewController

@property(nonatomic,strong)NSMutableArray *responseALLDicttDATA;
@property(nonatomic,strong)NSMutableArray *responseDictt;
@property(assign)NSInteger selectedIndex;
@property(nonatomic,strong)NSString *kmStr;

@end

//
//  MyBookingCell.h
//  FlightPass
//
//  Created by NitiN Kanojia on 7/14/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBookingCell : UITableViewCell
{

}
@property (strong, nonatomic) UIButton *btn_ReadMore;
@property (strong, nonatomic) UIButton *btn_Faqs;

-(void)setBookingData:(NSMutableDictionary*)dict hasNoData:(BOOL)hasData;
@end

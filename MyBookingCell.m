//
//  MyBookingCell.m
//  FlightPass
//
//  Created by NitiN Kanojia on 7/14/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import "MyBookingCell.h"
#import <Foundation/Foundation.h>

@implementation MyBookingCell

NSMutableDictionary *datadict;

-(void)setBookingData:(NSMutableDictionary*)dict hasNoData:(BOOL)hasData
{
    DLog(@"dict---%@",dict);
    
    datadict = [NSMutableDictionary new];
    datadict = dict;
    
    if (!hasData)
    {
        NSDictionary *dictValues=  [[Utilities getValue:@"Redeem_My_Booking"] valueForKey:@"labels"];
        UILabel *rout_lbl = [Utilities createLabel:CGRectMake(0, 0, [Utilities getScreenWidth], 150) title:nil size:12];
        rout_lbl.text = [NSString stringWithFormat:@"%@",[dictValues objectForKey:@"LABL_No_Bookings_Desc_Label"]];
        rout_lbl.textAlignment=NSTextAlignmentCenter;
        [rout_lbl setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self addSubview:rout_lbl];
        
        return;
    }
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    
//    NSFont *fontwala = [NSFont fontWithName:font.fontName size:12.0];
    
    float widthOfBtn = [self widthOfString:[NSString stringWithFormat:@"%@",[[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_View_Detail_Label"]] withFont:font];

    
    NSString *strMainDeparture = [NSString stringWithFormat:@"%@",[dict objectForKey:@"flight_date_arrival"]];
    NSArray *arrDept=[strMainDeparture componentsSeparatedByString:@","];

    
    NSMutableArray *arrItinerarry = [NSMutableArray new];
    arrItinerarry = [[[[[dict objectForKey:@"Itinerarry"] objectAtIndex:0] objectForKey:@"Segments"] objectAtIndex:0] objectForKey:@"legList"];

    
    NSString *strDepartureTime=[NSString stringWithFormat:@"%@, %@",[arrDept objectAtIndex:0],[[[arrItinerarry objectAtIndex:0] objectForKey:@"Flight_Full_View"] valueForKey:@"Dept_FormattedTime"]];
    
    
    
    UILabel *rout_lbl = [Utilities createLabel:CGRectMake(18, 15, [Utilities getScreenWidth]/2+60, 20) title:nil size:12];
    rout_lbl.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"LABL_SELECTED_ZONE"]];
    [rout_lbl setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self addSubview:rout_lbl];

    UILabel *confirm_lbl = [Utilities createLabel:CGRectMake(0, 15, [Utilities getScreenWidth] - 25, 15) title:nil size:12];
    confirm_lbl.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Confirmed_Booking_Label"]];
    confirm_lbl.textColor = [UIColor colorWithRed:50.0/255.0 green:119.0/255.0 blue:15.0/255.0 alpha:1.0];
    confirm_lbl.textAlignment = NSTextAlignmentRight;
    [confirm_lbl setFont:[UIFont boldSystemFontOfSize: 16.0f]];
    [self addSubview:confirm_lbl];
    
    
    UILabel *date_lbl = [Utilities createLabel:CGRectMake(rout_lbl.frame.origin.x,rout_lbl.frame.origin.y +20, self.frame.size.width-20, 20) title:nil size:12];
    date_lbl.text = strDepartureTime;//[NSString stringWithFormat:@"%@",[dict objectForKey:@"flight_date_arrival"]];
    [date_lbl setFont:[Utilities GetFont: 14.0f]];
    [self addSubview:date_lbl];

   
    UILabel *ocn_lbl = [Utilities createLabel:CGRectMake(date_lbl.frame.origin.x,date_lbl.frame.origin.y +25, self.frame.size.width/2, 20) title:nil size:12];
    ocn_lbl.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"LABL_OCN_Short_Label"]];
    [ocn_lbl setFont:[Utilities GetFont: 14.0f]];
    [self addSubview:ocn_lbl];
    
    UILabel *ocn_Value_lbl = [Utilities createLabel:CGRectMake(self.frame.size.width/2-20, ocn_lbl.frame.origin.y, self.frame.size.width/2, 20) title:nil size:12];
    ocn_Value_lbl.text = [NSString stringWithFormat:@": %@",[dict objectForKey:@"tgp_pax_booking_confirmation_number"]];
    [ocn_Value_lbl setFont:[Utilities GetFont:14.0f]];
    [self addSubview:ocn_Value_lbl];

    
    UILabel *airLine_lbl = [Utilities createLabel:CGRectMake(ocn_lbl.frame.origin.x,ocn_lbl.frame.origin.y +20, self.frame.size.width/2, 20) title:nil size:12];
    airLine_lbl.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Airline_Label"]];
    [airLine_lbl setFont:[Utilities GetFont: 14.0f]];
    [self addSubview:airLine_lbl];

    UILabel *airLine_Value_lbl = [Utilities createLabel:CGRectMake(self.frame.size.width/2-20, airLine_lbl.frame.origin.y, self.frame.size.width/2, 20) title:nil size:12];
    airLine_Value_lbl.text = [NSString stringWithFormat:@": %@",[dict objectForKey:@"airlineName"]];
    [airLine_Value_lbl setFont:[Utilities GetFont:14.0f]];
    [self addSubview:airLine_Value_lbl];

    
    UILabel *pnr_Lbl = [Utilities createLabel:CGRectMake(airLine_lbl.frame.origin.x,airLine_lbl.frame.origin.y +20, self.frame.size.width/2, 40) title:nil size:12];
    pnr_Lbl.text = [NSString stringWithFormat:@"%@\n%@",[dict objectForKey:@"airlineName"],[dict objectForKey:@"LABL_PNR_Label"]];
    pnr_Lbl.numberOfLines=0;
    [pnr_Lbl setFont:[Utilities GetFont: 14.0f]];
    [self addSubview:pnr_Lbl];

    UILabel *pnr_Value_lbl = [Utilities createLabel:CGRectMake(self.frame.size.width/2-20, pnr_Lbl.frame.origin.y, self.frame.size.width/2, 20) title:nil size:12];
    pnr_Value_lbl.text = [NSString stringWithFormat:@": %@",[dict objectForKey:@"Booking_Pnr_number"]];
    [pnr_Value_lbl setFont:[Utilities GetFont:14.0f]];
    [self addSubview:pnr_Value_lbl];
   
    
////
    _btn_ReadMore = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn_ReadMore.frame = CGRectMake(pnr_Value_lbl.frame.origin.x + pnr_Value_lbl.frame.size.width-widthOfBtn, pnr_Value_lbl.frame.origin.y+10, widthOfBtn, 30);
    [self addSubview:_btn_ReadMore];
    _btn_ReadMore.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    
    
    NSArray * keys = [[NSArray alloc] initWithObjects:NSForegroundColorAttributeName, NSUnderlineStyleAttributeName, nil];
    NSArray * objects = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:47.0/255.0 green:87.0/255.0 blue:157.0/255.0 alpha:1.0],
                         [NSNumber numberWithInt:NSUnderlineStyleSingle], nil];
    NSDictionary * linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_View_Detail_Label"]]    attributes:linkAttributes]];
    [_btn_ReadMore setAttributedTitle:attString forState:UIControlStateNormal];
    
/////
    
    _btn_Faqs = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn_Faqs.frame = CGRectMake(_btn_ReadMore.frame.origin.x + _btn_ReadMore.frame.size.width, pnr_Value_lbl.frame.origin.y+10, 80, 30);
    [self addSubview:_btn_Faqs];
    _btn_Faqs.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    
    
    NSArray * keys1 = [[NSArray alloc] initWithObjects:NSForegroundColorAttributeName, NSUnderlineStyleAttributeName, nil];
    NSArray * objects1 = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:47.0/255.0 green:87.0/255.0 blue:157.0/255.0 alpha:1.0],
                         [NSNumber numberWithInt:NSUnderlineStyleSingle], nil];
    NSDictionary * linkAttributes1 = [[NSDictionary alloc] initWithObjects:objects1 forKeys:keys1];
    
    NSMutableAttributedString *attString1 = [[NSMutableAttributedString alloc] init];
    [attString1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"|FAQs"    attributes:linkAttributes1]];
    [_btn_Faqs setAttributedTitle:attString1 forState:UIControlStateNormal];

    
    
    
//    UILabel *date_lbl = [[UILabel alloc] initWithFrame:CGRectMake(rout_lbl.frame.origin.x,rout_lbl.frame.origin.y +20, self.frame.size.width - 20, self.frame.size.height)];
//    // subtitle_lbl.numberOfLines = 0;
//    date_lbl.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"flight_date_arrival"]];
//    date_lbl.backgroundColor = [UIColor clearColor];
//    date_lbl.font = [UIFont boldSystemFontOfSize:15.0f];
//    date_lbl.textAlignment = NSTextAlignmentJustified;
//    date_lbl.textColor = [UIColor blackColor];
//    [self addSubview:date_lbl];

    

}


- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end

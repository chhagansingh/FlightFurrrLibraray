//
//  RulesCustomCell.m
//  FlightPass
//
//  Created by Vemanatha on 7/31/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import "RulesCustomCell.h"

@implementation RulesCustomCell

-(void)rulesData:(NSMutableDictionary*)dict
{
    DLog(@"dict---%@",[dict objectForKey:@"Rules"]);
    
    NSArray *rulesArr = [dict objectForKey:@"Rules"];
    
    float prev_y = 10.0;
    for (int nnn = 0; nnn < [rulesArr count]; nnn++)
    {

        if (nnn == 0)
        {
            UILabel *maintitle_lbl = [[UILabel alloc] init];
            maintitle_lbl.numberOfLines = 0;
            maintitle_lbl.backgroundColor = [UIColor clearColor];
            maintitle_lbl.textAlignment = NSTextAlignmentJustified;
            maintitle_lbl.textColor = [UIColor blackColor];
            [self addSubview:maintitle_lbl];

            maintitle_lbl.font = [UIFont boldSystemFontOfSize:14.0f];
            maintitle_lbl.text = [NSString stringWithFormat:@"%@",[[rulesArr objectAtIndex:nnn] valueForKey:@"Title"]];
            CGRect titleTxt_rect = [Utilities getTextRect:maintitle_lbl.text rect:CGSizeMake([Utilities getScreenWidth] - 20, FLT_MAX) :maintitle_lbl];
            maintitle_lbl.frame = CGRectMake(10, prev_y, [Utilities getScreenWidth] - 20, titleTxt_rect.size.height);
            prev_y = prev_y+5;
            prev_y = prev_y +maintitle_lbl.frame.size.height+10;

        }
        else
        {
            
            NSArray *innerListArr = [[[rulesArr objectAtIndex:nnn] valueForKey:@"Rule"] componentsSeparatedByString:@"##"];
            
                for (int vvv =0; vvv < [innerListArr count]; vvv++)
                {
                    
                    if (vvv == 0)
                    {
                        UILabel *maintitle_lbl = [[UILabel alloc] init];
                        maintitle_lbl.numberOfLines = 0;
                        maintitle_lbl.backgroundColor = [UIColor clearColor];
                        maintitle_lbl.textAlignment = NSTextAlignmentJustified;
                        maintitle_lbl.textColor = [UIColor blackColor];
                        [self addSubview:maintitle_lbl];

                        maintitle_lbl.font = [UIFont systemFontOfSize:14.0f];
                        maintitle_lbl.text = [NSString stringWithFormat:@"%d. %@",nnn,[innerListArr objectAtIndex:vvv]];
                        CGRect titleTxt_rect = [Utilities getTextRect:maintitle_lbl.text rect:CGSizeMake([Utilities getScreenWidth] - 40, FLT_MAX) :maintitle_lbl];
                        maintitle_lbl.frame = CGRectMake(10, prev_y, [Utilities getScreenWidth] - 40, titleTxt_rect.size.height);

                        prev_y = prev_y +maintitle_lbl.frame.size.height+5;

                    }
                    else{
                        UILabel *maintitle_lbl = [[UILabel alloc] init];
                        maintitle_lbl.numberOfLines = 0;
                        maintitle_lbl.backgroundColor = [UIColor clearColor];
                        maintitle_lbl.textAlignment = NSTextAlignmentJustified;
                        maintitle_lbl.textColor = [UIColor blackColor];
                        [self addSubview:maintitle_lbl];

                        maintitle_lbl.font = [UIFont systemFontOfSize:14.0f];
                        maintitle_lbl.text = [NSString stringWithFormat:@"%@",[innerListArr objectAtIndex:vvv]];
                        
                        CGRect titleTxt_rect = [Utilities getTextRect:maintitle_lbl.text rect:CGSizeMake([Utilities getScreenWidth] - 50, FLT_MAX) :maintitle_lbl];
                        
                        maintitle_lbl.frame = CGRectMake(15, prev_y, [Utilities getScreenWidth] - 50, titleTxt_rect.size.height);

                        prev_y = prev_y +maintitle_lbl.frame.size.height+5;

                    }
                    
                }
                
            }
    }
    
    [Utilities save:[NSNumber numberWithFloat:prev_y] :@"Rules_Cell_height"];

    float totalH = [[NSUserDefaults standardUserDefaults] floatForKey:@"Rules_Cell_height"];
    
    DLog(@"totalH--%f",totalH);
    self.clipsToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius=5;
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundView = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

   // NSArray *howDoesItWorkItems = [[titleArr objectAtIndex:1] componentsSeparatedByString:@"##"];

}
@end

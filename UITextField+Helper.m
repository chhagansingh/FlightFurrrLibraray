//
//  UITextField+Helper.m
//  OptionPass
//
//  Created by Prashant Sharma on 10/22/15.
//  Copyright © 2015 Option Town. All rights reserved.
//

#import "UITextField+Helper.h"
@implementation UITextField (Helper)


- (BOOL)isValidEmail{
    
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [self isValid] && [emailTest evaluateWithObject:self.text];
}
-(void)isValidPhoneNumber:(NSString*)strNumber
{
    NSString *phoneRegex2 = @"^(\\([0-9]{3})\\) [0-9]{3}-[0-9]{4}$";
    NSPredicate *phoneTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
    BOOL isValid =[phoneTest2 evaluateWithObject:strNumber];
}


-(BOOL)isValid{
    return self.text.length;
}

@end

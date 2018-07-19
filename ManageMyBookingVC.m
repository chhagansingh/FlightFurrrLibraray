//
//  ManageMyBookingVC.m
//  FlightPass
//
//  Created by NitiN Kanojia on 7/15/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import "ManageMyBookingVC.h"
#import "ChangeFlightVC.h"

@interface ManageMyBookingVC ()
{
    UIButton *btn;
    NSMutableDictionary *responseDict;
}
@property(nonatomic,strong)DashBoardModel *model;
@end

@implementation ManageMyBookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utilities showHUD];

    [self CofigurreUI];

}
-(DashBoardModel *)model
{
    if (!_model) {
        _model=[[DashBoardModel alloc]initWithDelegate:self];
    }
    return _model;
}

-(void)CofigurreUI
{

    DLog(@"Redeem_Main_Response--%@",[[Utilities getValue:@"Redeem_Main_Response"] valueForKey:@"listOfPasses"]);
    
    NSMutableDictionary *sendDict = [[NSMutableDictionary alloc]init];
    NSString *str = @"0";
    [sendDict setValue:str forKey:@"selectedpassid"];

    [self.model fetchMybookingfirstPageData:sendDict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         DLog(@"responseObject----%@",responseObject);
         [Utilities hideHUD];
         
         responseDict = [[NSMutableDictionary alloc] init];
         responseDict = responseObject;
         
         btn = [Utilities createButton:CGRectMake(5, 80, [Utilities getScreenWidth]-10, 80)
                                 title:[responseObject valueForKey:@"Change_Flight_Subheading_Label"]
                         backgroundImg:[UIImage imageNamed:@"boxxx.png"] size:14];
         btn.titleEdgeInsets = UIEdgeInsetsMake(40, 20, 0, 30);
         [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         //airlineBtn.tag = indexPath;
         [self.view addSubview:btn];
         [btn addTarget:self action:@selector(airlineBtnAction) forControlEvents:UIControlEventTouchUpInside];
         
         
         UILabel *blue_lbl = [Utilities createLabel:CGRectMake(20, 15, 200, 25) title:nil size:16];
         blue_lbl.text = [responseObject valueForKey:@"Change_Flight_Heading_Label"];
         blue_lbl.font = [UIFont boldSystemFontOfSize:16];
         blue_lbl.textColor = Blue_Color_OT;
         [btn addSubview:blue_lbl];

         [[AppDelegate instance] setTitleValue:[responseObject valueForKey:@"Manage_My_Booking_Heading_Label"] Hide:NO];
       //  currentTitle=[responseObject valueForKey:@"Manage_My_Booking_Heading_Label"];
         [self setNavigationBar];
         

     }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utilities hideHUD];
         [self showInfo:@"Error Retrieving data"];
     }];

    


}
-(void)airlineBtnAction
{
    ChangeFlightVC *vc = [[ChangeFlightVC alloc]init];
    vc.responseDictt = responseDict;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;

    
    
   // [[AppDelegate instance] setTitleValue:@"Manage My Booking" Hide:NO];

}

-(void)setNavigationBar
{
    self.navigationController.navigationBarHidden=YES;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:254.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15.0f;
    
    //Bar Button 1
    
    
    UIImage *sideImage = [UIImage imageNamed:@"OTiCOn.png"];
    
    UIButton *btnSideMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSideMenu setImage:sideImage forState:UIControlStateNormal];
    [btnSideMenu setImage:sideImage forState:UIControlStateHighlighted];
    [btnSideMenu setFrame:CGRectMake(0, 0, sideImage.size.width, sideImage.size.height)];
    [btnSideMenu addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sideMenuItem = [[UIBarButtonItem alloc] initWithCustomView:btnSideMenu];
    
    //Left BarButton
    UIImage *sideImage1 = [UIImage imageNamed:@"back.png"];
    UIButton *btnSideMenu1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSideMenu1 setImage:sideImage1 forState:UIControlStateNormal];
    [btnSideMenu1 setImage:sideImage1 forState:UIControlStateHighlighted];
    [btnSideMenu1 setFrame:CGRectMake(0, 0, sideImage1.size.width, sideImage1.size.height)];
    [btnSideMenu1 addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sideMenuItem1 = [[UIBarButtonItem alloc] initWithCustomView:btnSideMenu1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,210,30)];
    label.backgroundColor = [UIColor clearColor];
    label.text=currentTitle;
//    label.text=[NSString stringWithFormat:@"%@",[[responseRedeemDic valueForKey:@"PassSmallView"]valueForKey:@"Travel_Zone_Title"]];
    label.font = [UIFont fontWithName:@"GoodMobiPro-CondBold" size:24];
    
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:label] ;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:sideMenuItem1, negativeSpacer, sideMenuItem,backButton, nil];
    
    
//    ///Right BarButton
//    UIButton *routMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //[routMapBtn setImage:sideImage forState:UIControlStateNormal];
//    //[routMapBtn setImage:sideImage forState:UIControlStateHighlighted];
//    [routMapBtn setFrame:CGRectMake(0, 0, 100 , 40)];
//    [routMapBtn addTarget:self action:@selector(routMapBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    [routMapBtn setTitle:@"Route Map" forState:UIControlStateNormal];
//    [routMapBtn setTitleColor:Blue_Color_OT forState:UIControlStateNormal];
//    routMapBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
//    
//    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc]initWithCustomView:routMapBtn];
//    rightBarButton.tintColor=[UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
}

-(void)btnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

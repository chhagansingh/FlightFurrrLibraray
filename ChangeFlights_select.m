//
//  ChangeFlights_select.m
//  FlightPass
//
//  Created by NitiN Kanojia on 7/16/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import "ChangeFlights_select.h"
#import "Picker_View.h"

@interface ChangeFlights_select ()
{
    UIButton *btn,*kmBtn;
    NSInteger  selectedIndex;
    NSString *str2;
    

}

@property(nonatomic,strong)DashBoardModel *model;


@end

@implementation ChangeFlights_select

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;

    [[AppDelegate instance] setTitleValue:[self.responseALLDicttDATA valueForKey:@"Change_Flight_Heading_Label"] Hide:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    DLog(@"ffff----%@",_responseALLDicttDATA);
    [[AppDelegate instance] setTitleValue:[self.responseALLDicttDATA valueForKey:@"Change_Flight_Heading_Label"] Hide:NO];
    kmBtn = [Utilities createButton:CGRectMake(15, 20, [Utilities getScreenWidth] - 30, 25)  title:_kmStr backgroundImg:nil size:14];
   
    kmBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
    [kmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    kmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:kmBtn];
    [kmBtn addTarget:self action:@selector(kmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *btnEditImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"editPencil"]];
    btnEditImage.frame= CGRectMake(kmBtn.frame.origin.x+kmBtn.frame.size.width-30, kmBtn.frame.origin.y-5, btnEditImage.frame.size.width, btnEditImage.frame.size.height);
    [self.view addSubview:btnEditImage];
    
    
    

    UILabel *km_lbl = [Utilities createLabel:CGRectMake(15, 60, [Utilities getScreenWidth]-30, 25) title:nil size:16];
    km_lbl.text = [NSString stringWithFormat:@"%@",[self.responseALLDicttDATA valueForKey:@"Change_Flight_Subheading_Label"]];
    [self.view addSubview:km_lbl];
//
    NSString *strTitle = [NSString stringWithFormat:@"%@",[[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_Select_Your_Pass_Label"]];
    btn = [Utilities createButton:CGRectMake(15, 90, [Utilities getScreenWidth] - 30, 40) title:strTitle  backgroundImg:[UIImage imageNamed:@"new_dropDown"] size:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //airlineBtn.tag = indexPath;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor=[[UIColor grayColor]CGColor];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds=YES;

    DLog(@"fcuk---%@",_responseDictt);
    
    if (_responseDictt.count>0)
    {
        
        
        
    NSString *strTitle = [NSString stringWithFormat:@"%@",[[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_Select_Your_Pass_Label"]];
        
        NSMutableDictionary *dictnew=[NSMutableDictionary new];
        [dictnew setObject:strTitle forKey:@"Flight_PNR_Label"];
        
        [_responseDictt replaceObjectAtIndex:0 withObject:dictnew];

    }
    
    
    
    
     NSString *strTitleBtnContinue = [NSString stringWithFormat:@"%@",[_responseALLDicttDATA valueForKey:@"Continue_Button_Label"]];
    UIButton *continueBtn = [Utilities createButton:CGRectMake(15, 70+100, [Utilities getScreenWidth] - 30, 40) title:strTitleBtnContinue backgroundImg:nil size:14];
    continueBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueBtn.backgroundColor = RED_COLOR_OT;
    continueBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:continueBtn];
    [continueBtn addTarget:self action:@selector(ContinueAction) forControlEvents:UIControlEventTouchUpInside];
    continueBtn.layer.borderWidth = 1;
    continueBtn.layer.borderColor= RED_COLOR_OT.CGColor;
    continueBtn.layer.cornerRadius = 5;
    continueBtn.layer.masksToBounds=YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeflightPickerAction:) name:@"second_page_seclectd_Noti" object:nil];

}

-(void)changeflightPickerAction :(NSNotification *)notification
{
    //   [Utilities showHUD];
    
    selectedIndex = [[[notification userInfo] objectForKey:@"SelectedIndex"] integerValue];
    DLog(@"index---%@", [_responseDictt objectAtIndex:selectedIndex]);
    NSString *str = [NSString stringWithFormat:@"%@",[[_responseDictt objectAtIndex:selectedIndex] valueForKey:@"Flight_PNR_Label"]];
    [btn setTitle:str forState:UIControlStateNormal];
    
    NSString *strTitle = [NSString stringWithFormat:@"%@",[[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_Select_Your_Pass_Label"]];
    if (selectedIndex == 0) {
        [btn setTitle:strTitle forState:UIControlStateNormal];
    }
    str2 = [NSString stringWithFormat:@"%@",[[_responseDictt objectAtIndex:selectedIndex] valueForKey:@"Booking_Ref_Num"]];
    
}


-(void)selectBtnAction
{
    
    Picker_View *view = [[Picker_View alloc] initWithFrame:CGRectMake(0, 0, [self getScreenWidth], [self getScreenHight])];
    view.tag = 222;
    view.picker_PrefixData = _responseDictt;
    //        view.selectedIndex = sel_IndCountry;
    view.backgroundColor = [UIColor clearColor];
    [[AppDelegate instance].navigationControler.view addSubview:view];

}

-(void)ContinueAction
{
    if(selectedIndex == 0){
        
        [self showInfo:@"No Reference selected"];

//        [Utilities showHUDwithTitle:@"Change flight" andSubTitle:@"No Reference selected" ];
    }
    else{
        DLog(@"str2---%@",str2);
//        {"Pnr": "NYAQGE"}
        
        NSMutableDictionary *sendDict = [[NSMutableDictionary alloc]init];
        NSString *str = [NSString stringWithFormat:@"%@",str2];
        [sendDict setValue:str forKey:@"Pnr"];
        [Utilities showHUD];

        
        [self.model fetchDetailsForPNR:sendDict success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             DLog(@"Details for PNR----%@",responseObject);

             SelectChangeFlightVC *vc = [[SelectChangeFlightVC alloc]initWithNibName:@"SelectChangeFlightVC" bundle:nil];
             vc.responseDictt = responseObject;
             vc.kmStr = _kmStr;
             vc.strTitle = [self.responseALLDicttDATA valueForKey:@"Change_Flight_Heading_Label"];
             [self.navigationController pushViewController:vc animated:YES];

             
             [Utilities hideHUD];
             
         }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [Utilities hideHUD];
             [self showInfo:@"Error Retrieving data"];
         }];
        
     //   https://192.168.64.10/getSellerList.do?mobileAction=ChangeFlightSelect
    }
}
-(DashBoardModel *)model
{
    if (!_model) {
        _model=[[DashBoardModel alloc]initWithDelegate:self];
    }
    return _model;
}

- (IBAction)kmBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

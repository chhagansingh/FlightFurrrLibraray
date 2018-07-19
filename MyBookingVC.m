//
//  MyBookingVC.m
//  FlightPass
//
//  Created by NitiN Kanojia on 7/14/17.
//  Copyright © 2017 optiontown. All rights reserved.
//

#import "MyBookingVC.h"
#import "PassDetailsVC.h"
#import "PendingBookingCell.h"
#import "PendingPDetailsVC.h"
@interface MyBookingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tblView;
    NSDictionary *bookingData;
    
    bool isPlus_ConfirmBooking;
    bool isPlus_PendingBooking;
}

@property(nonatomic,strong)DashBoardModel *model;
@end

@implementation MyBookingVC

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    

    [[AppDelegate instance] setTitleValue:[NSString stringWithFormat:@"%@",[[Utilities getValue:FPO_LABEL_KEY] valueForKey:@"LABL_My_Bookings"]] Hide:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    DLog(@"cll API");
    [self fetchBookingData];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark- tableview delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {

    static NSString *CellIdentifier = @"MyBookingCell";
    
    MyBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    for (UIView *subview in [cell.contentView subviews])
    {
        if ([subview isKindOfClass:[UILabel class]])
        {
            [subview removeFromSuperview];
        }
        if ([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
        if ([subview isKindOfClass:[UIImage class]])
        {
            [subview removeFromSuperview];
        }
    }

    cell = [[MyBookingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    av.backgroundColor = [UIColor clearColor];
    av.opaque = NO;
    av.image = [UIImage imageNamed:@"boxxx.png"];
    cell.backgroundView = av;
    
        int rows=(int)[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"]  count];
        if (rows==0)
        {
            [cell setBookingData:nil hasNoData:NO];
        }
        else
        {
            [cell setBookingData:[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:indexPath.row] hasNoData:YES];
            
            cell.btn_ReadMore.tag = indexPath.row;
            [cell.btn_ReadMore addTarget:self action:@selector(viewMoreAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn_Faqs.tag = indexPath.row+100;
            [cell.btn_Faqs addTarget:self action:@selector(faqsAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        


        return cell;

    }
    else
    {
        
                static NSString *CellIdentifier = @"PendingBookingCelllll";
        PendingBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        av.backgroundColor = [UIColor clearColor];
        av.opaque = NO;
        av.image = [UIImage imageNamed:@"boxxx.png"];
        cell.backgroundView = av;
        NSDictionary *dictValues=  [[Utilities getValue:@"Redeem_My_Booking"] valueForKey:@"labels"];
        int rows=(int)[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"pendingBookings"]  count];
        if (rows==0)
        {
            cell.lblCondition.hidden=NO;
            cell.lblCondition.text=[dictValues valueForKey:@"LABL_No_Bookings_Desc_Label"];
            
            return cell;
        }
        
        
        
        NSObject *obj = [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"pendingBookings"] objectAtIndex:indexPath.row];
        NSObject *obj2 = [[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"labels"];
        


        cell.kmLbl.text = [obj valueForKey:@"LABL_SELECTED_ZONE"];
        cell.pendingLbl.text = [obj valueForKey:@"Confirmed_Booking_Label"];
        cell.dateLbl.text = [obj valueForKey:@"flight_date_departure"];
        cell.airlineLbl.text = [obj valueForKey:@"Airline_Label"];
        cell.vAirline.text = [obj valueForKey:@"airlineName"];


        [cell.viewDetailsBtn setTitle:[NSString stringWithFormat:@"%@",[obj2 valueForKey:@"ViewDetail_label"]] forState:UIControlStateNormal];
        [cell.faqBtn setTitle:[NSString stringWithFormat:@"%@",[obj2 valueForKey:@"Faq_Label"]] forState:UIControlStateNormal];
        [cell.viewDetailsBtn addTarget:self action:@selector(viewDetailsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.viewDetailsBtn.tag = indexPath.row;
        return cell;

    }
    
    return nil;
}

-(void)faqsAction:(id)sender
{
//    [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:(long)[sender tag]];
//    DLog(@"dict----%ld",(long)[sender tag]);
//    DLog(@"dict----%@",[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:(long)[sender tag]]);
    
    
//    PassDetailsVC *vc = [[PassDetailsVC alloc] initWithNibName:@"PassDetailsVC" bundle:nil];
//    vc.selectedDict = [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:(long)[sender tag]];
//    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)viewDetailsBtnAction:(id)sender
{
    NSDictionary *detailDict = [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"pendingBookings"] objectAtIndex:[sender tag]];
    NSDictionary *lblDict = [[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"labels"];

    PendingPDetailsVC *vc = [[PendingPDetailsVC alloc] initWithNibName:@"PendingPDetailsVC" bundle:nil];
    vc.detailDict = detailDict;
    vc.lblDict = lblDict;
    [self.navigationController pushViewController:vc animated:NO];

}
-(void)viewMoreAction:(id)sender
{
    [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:(long)[sender tag]];
    DLog(@"dict----%ld",(long)[sender tag]);
    DLog(@"dict----%@",[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:(long)[sender tag]]);
     
    
    PassDetailsVC *vc = [[PassDetailsVC alloc] initWithNibName:@"PassDetailsVC" bundle:nil];
    vc.selectedDict = [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] objectAtIndex:(long)[sender tag]];
    [self.navigationController pushViewController:vc animated:NO];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 50)];
    headerView.tag                  = section;
    
    BOOL manyCells                  = [[arrayForBool objectAtIndex:section] boolValue];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    //up or down arrow depending on the bool
    UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ?
                                       [UIImage imageNamed:@"minus_icon.png"] : [UIImage imageNamed:@"plus_icon.png"]];
    upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
    upDownArrow.frame               = CGRectMake(self.view.frame.size.width-55, 16, 39/2, 39/2);
    
    UILabel *headerString = [Utilities createLabel:CGRectMake(25, 0, tableView.frame.size.width-72, 50) title:@"Confirm Bookings" size:15];
    headerString.textColor=[UIColor colorWithRed:0.0/255.0 green:35.0/255.0 blue:155.0/255.0 alpha:1.0];
    headerString.numberOfLines = 0;
    [headerView addSubview:headerString];
    [headerString setFont:[Utilities GetFontLight:13]];
    [headerView addSubview:upDownArrow];
    
    headerView.layer.borderColor = [UIColor grayColor].CGColor;
    headerView.backgroundColor      = [UIColor whiteColor];
    headerView.layer.borderWidth = 0.5f;
    headerView.layer.cornerRadius=5;
    headerView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 20);
    
    
    if (section == 0)
    {
        headerString.text = @"Confirm Bookings";
        if (isPlus_ConfirmBooking)  upDownArrow.image = [UIImage imageNamed:@"minus_icon.png"];
                             else   upDownArrow.image = [UIImage imageNamed:@"plus_icon.png"];
        
    }
    else
    {
        if (isPlus_PendingBooking) upDownArrow.image = [UIImage imageNamed:@"minus_icon.png"];
                             else  upDownArrow.image = [UIImage imageNamed:@"plus_icon.png"];
        headerString.text = @"Pending Bookings";
    }

    
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [[UITableViewHeaderFooterView alloc] initWithFrame:(CGRect){0, 0, self.view.frame.size.width, 1}];
    footerView.contentView.backgroundColor = [UIColor whiteColor];
    
    return footerView;
}

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    selectedGesture  =  gestureRecognizer;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0)
    {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        arrayForBool = [[NSMutableArray alloc] init];
        
        DLog(@"%lu",[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] count]);
        
        for(int i = 0; i< 2; i++)
       // for(int i = 0; i< [[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"] count]; i++)
    
        {
            [arrayForBool addObject:[NSNumber numberWithBool:NO]];
        }
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        [tblView reloadData];
    }
    
    if (indexPath.section == 0)
    {
        if (isPlus_ConfirmBooking)
            isPlus_ConfirmBooking = NO;
        else
             isPlus_ConfirmBooking = YES;
    }
    else
    {
        if (isPlus_PendingBooking)
            isPlus_PendingBooking = NO;
        else
            isPlus_PendingBooking = YES;
    }
    
    [tblView reloadData];
    
    //DLog(@"tapped section---%ld",(long)indexPath.section);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0){
        
        if (isPlus_ConfirmBooking)
        {
            int rows=(int)[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"]  count];
            if (rows==0)
            {
                return 1;
            }
            return rows;
        }
       else
       {
           return 0;
       }
        
    }
    else{
        
        if (isPlus_PendingBooking)
        {
            int rows=(int)[[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"pendingBookings"]  count];
            if (rows==0)
            {
                return 1;
            }
            return rows;
        }
        else
        {
            return 0;
        }

    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark- webservice called
-(DashBoardModel *)model
{
    if (!_model) {
        _model=[[DashBoardModel alloc]initWithDelegate:self];
    }
    return _model;
}

-(void)fetchBookingData
{
    [Utilities showHUD];
    
    [self.model fetchMyBookingData:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         DLog(@"responseObject----%@",responseObject);
         [Utilities save:responseObject :@"Redeem_My_Booking"];
         //    DLog(@"data---%@",[[Utilities getValue:@"Redeem_My_Booking"] objectForKey:@"confirmedBooking"]);
         
         tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, [Utilities getScreenWidth], [Utilities getScreenHight]-70) style:UITableViewStylePlain];
         UINib *cellNib = [UINib nibWithNibName:@"PendingBookingCell" bundle:nil];
         [tblView registerNib:cellNib forCellReuseIdentifier:@"PendingBookingCelllll"];
         
         tblView.dataSource = self;
         tblView.delegate = self;
         tblView.backgroundView=nil;
         tblView.backgroundColor = [UIColor whiteColor];
         tblView.separatorStyle=UITableViewCellSeparatorStyleNone;
         [tblView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
         [self.view addSubview:tblView];
         
         [Utilities hideHUD];
     }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Utilities hideHUD];
         [self showInfo:@"Error Retrieving data"];
     }];
    
}


@end

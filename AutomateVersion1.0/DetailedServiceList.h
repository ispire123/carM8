//
//  DetailedServiceList.h
//  AutomateVersion1.0
//
//  Created by admin on 9/05/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BraintreeCore.h"
#import "BraintreeUI.h"

@interface DetailedServiceList : UIViewController <BTDropInViewControllerDelegate>

@property (retain, nonatomic) NSString *ser_CarRego;
@property (retain, nonatomic) NSString *ser_Date;
@property (retain, nonatomic) NSString *ser_Time;
@property (retain, nonatomic) NSString *ser_Location;
@property (retain, nonatomic) NSString *ser_Product;
@property (retain, nonatomic) NSString *ser_Status;
@property (retain, nonatomic) NSString *ser_ObjectId;
@property (weak, nonatomic) IBOutlet UILabel *ser_Detail_carRego;
@property (weak, nonatomic) IBOutlet UILabel *ser_Detail_date;
@property (weak, nonatomic) IBOutlet UILabel *ser_Detail_time;
@property (weak, nonatomic) IBOutlet UILabel *ser_Detail_product;
@property (weak, nonatomic) IBOutlet UILabel *ser_Detail_total;
@property (weak, nonatomic) IBOutlet UITextView *ser_Detail_location;

@property (weak, nonatomic) IBOutlet UIProgressView *statusBar;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *makePayment;
@property (weak, nonatomic) IBOutlet UILabel *cancelstatus;
@property (weak, nonatomic) IBOutlet UILabel *st1;
@property (weak, nonatomic) IBOutlet UILabel *st2;
@property (weak, nonatomic) IBOutlet UILabel *st3;

@property (nonatomic, strong) BTAPIClient *braintreeClient;

- (IBAction)cancelService:(id)sender;

@end

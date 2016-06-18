//
//  DetailDisplay.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 17/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "DetailDisplay.h"
#import <Parse/Parse.h>

@interface DetailDisplay ()

@end

@implementation DetailDisplay
@synthesize cSelected;
@synthesize cTime;
@synthesize cDate;
@synthesize cLocation;
@synthesize cSel;
@synthesize productPrice;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    NSLog(@"%@", cSelected);
    NSLog(@"%@", cTime);
    NSLog(@"%@", cDate);
    NSLog(@"%@", cLocation);
    _cleanDate.text = cDate;
    _cleanTime.text = cTime;
    _locationClean.text = cLocation;
    _carForClean.text = cSel;
    _productConLabel.text = cSelected;
    _amountLabel.text = productPrice;
    if ([_paymentMethod isEqualToString:@"Cash Payment"]) {
        _paymentInfoLabel.text = @"Please pay the invoice amount to the cleaner post service.";
    }
    else if([_paymentMethod isEqualToString:@"Online Payment"]){
        _paymentInfoLabel.text = @"We will send you invoice post service.";
    }
}

- (void)viewDidAppear:(BOOL)animated{
    UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Your Request is being logged" message:@"Thanks for using CarM8, Your service request has been successfully raised. Our Expert G2C2 partner will deliver the requested service." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [fieldAreEmpty dismissViewControllerAnimated:YES completion:nil];
                             NSLog(@"stored car details successfully");
                         }];
    [fieldAreEmpty addAction:ok];
    [self presentViewController:fieldAreEmpty animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *tabView = [dashboard instantiateViewControllerWithIdentifier:@"checkstatus"];
    [self presentViewController:tabView animated:YES completion:nil];

}
@end

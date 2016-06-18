//
//  CleaningDetails.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 15/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CleaningDetails : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UIDatePicker *date;
    UIDatePicker *time;
    UIPickerView *car;
    NSMutableArray *carArray;
    NSURLConnection *postConnection;
}
@property (retain, nonatomic) NSString *carSelected;
@property (retain, nonatomic) NSString *lSelected;
@property (retain, nonatomic) NSString *productSelected;
@property (retain, nonatomic) NSString *productPrice;


@property (strong, nonatomic) IBOutlet UISwitch *termNconditions;
@property (strong, nonatomic) IBOutlet UISwitch *protectionPolicy;
- (IBAction)termsWebView:(id)sender;
- (IBAction)backgroundTouch:(id)sender;

- (IBAction)tcValueChanged:(id)sender;



@property (strong, nonatomic) IBOutlet UITextField *cleanDate;
@property (strong, nonatomic) IBOutlet UITextField *cleanTime;
@property (strong, nonatomic) IBOutlet UITextView *cleanDescription;
@property (strong, nonatomic) IBOutlet UILabel *productLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationMap;
- (IBAction)submit:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *buttonS;
- (IBAction)choosePayment:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonPayment;
@property (strong, nonatomic) IBOutlet UILabel *paymentText;

- (IBAction)paymentValue:(id)sender;

- (IBAction)pay:(id)sender;


@end


typedef NS_ENUM(NSInteger, STPBackendChargeResult) {
    STPBackendChargeResultSuccess,
    STPBackendChargeResultFailure,
};

typedef void (^STPTokenSubmissionHandler)(STPBackendChargeResult status, NSError *error);

@protocol STPBackendCharging <NSObject>



@end
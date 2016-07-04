//
//  DetailDisplay.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 17/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailDisplay : UIViewController 
{
    //NSArray *productPrice;
}
@property (retain, nonatomic) NSString *cSelected;
@property (retain, nonatomic) NSString *cTime;
@property (retain, nonatomic) NSString *cDate;
@property (retain, nonatomic) NSString *cLocation;
@property (retain, nonatomic) NSString *cSel;
@property (retain, nonatomic) NSString *productPrice;
@property (retain, nonatomic) NSString *paymentMethod;
@property (strong, nonatomic) IBOutlet UILabel *carForClean;
@property (strong, nonatomic) IBOutlet UILabel *cleanDate;
@property (strong, nonatomic) IBOutlet UILabel *cleanTime;
@property (strong, nonatomic) IBOutlet UITextView *locationClean;
@property (strong, nonatomic) IBOutlet UILabel *productConLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
- (IBAction)done:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *paymentInfoLabel;



@end

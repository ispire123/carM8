//
//  customerCars.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerCars : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableArray *availableMakes;
    NSMutableArray *availableModels;
    UIPickerView *pickerview;
    UIPickerView *pickerviewmodel;
    UIPickerView *carYearPick;
    UIPickerView *carBodyTypePick;
    NSMutableArray *carYearPicker;
    NSMutableArray *bodyTypeArray;
    int i2;
}
@property (weak, nonatomic) IBOutlet UITextField *carMake;
@property (weak, nonatomic) IBOutlet UITextField *carModel;
@property (weak, nonatomic) IBOutlet UITextField *carYear;
@property (weak, nonatomic) IBOutlet UITextField *carRego;
@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) IBOutlet UITextField *bodyType;

- (IBAction)addCar:(id)sender;


@end

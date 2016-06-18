//
//  customerCars.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "customerCars.h"
#import <Parse/Parse.h>

@interface customerCars ()

@end

@implementation customerCars

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"Add Cars";
   [self showNormalNavigationBar];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    i2  = [[formatter stringFromDate:[NSDate date]] intValue];
    
    
    //Create Years Array from 1960 to This year
    carYearPicker = [[NSMutableArray alloc] init];
    for (int i=1990; i<=i2; i++) {
        [carYearPicker addObject:[NSString stringWithFormat:@"%d",i]];
    
        bodyTypeArray = [[NSMutableArray alloc]init];
        NSArray *temp = [[NSArray alloc]initWithObjects:@"Sedan", @"Hatchback", @"SUV", @"Others", nil];
        [bodyTypeArray addObjectsFromArray:temp];
    
    // Do any additional setup after loading the view.
        PFQuery *query = [PFQuery queryWithClassName:@"carMake"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *carMakeParse, NSError *error) {
        if (carMakeParse) {
            //availableMakes = [[NSMutableArray alloc]initWithArray:carMakeParse];
            availableMakes =[carMakeParse valueForKey:@"makeName"];
        }
    }];
   // availableMakes = @[@"Indian Rupee", @"US Dollar", @"European Union Euro", @"Canadian Dollar", @"Australian Dollar", @"Singapore Dollar", @"British Pound", @"Japanese Yen"];
    // Do any additional setup after loading the view.
    [self pickerview:self];
    [self carYearPickerView:self];
    [self carBodyPickerView:self];
    }}


-(void)showNormalNavigationBar
{
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem.backBarButtonItem setAction:@selector(goBack)];
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)addNewCar{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    customerCars *CC = [storyboard instantiateViewControllerWithIdentifier:@"addCars"];
    [self presentViewController:CC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addCar:(id)sender {
    PFObject *customerCar = [PFObject objectWithClassName:@"customerCars"];
    customerCar[@"make"] = _carMake.text;
    customerCar[@"model"] = _carModel.text;
    customerCar[@"year"] = _carYear.text;
    customerCar[@"rego"] = _carRego.text;
    NSString *cEmail = [[PFUser currentUser] objectForKey:@"email"];
    customerCar[@"cEmail"] = cEmail;
    [customerCar saveInBackground];
    UIAlertController *registrationError = [UIAlertController alertControllerWithTitle:@"Success" message:@"Your Car is Successfully added" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ADD MORE" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [registrationError dismissViewControllerAnimated:YES completion:nil];
    }];
    [registrationError addAction:ok];
        UIAlertAction *bookService = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *book){
           UIStoryboard *dashboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; 
           UIViewController *change = [dashboard instantiateViewControllerWithIdentifier:@"customerDashboard"];
            [self presentViewController:change animated:YES completion:nil];
        }];
        [registrationError addAction:bookService];
        [self presentViewController:registrationError animated:YES completion:nil];
    }

-(void)pickerview:(id)sender{
    pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerview.showsSelectionIndicator = YES;
    pickerview.dataSource = self;
    pickerview.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.carMake.inputView = pickerview;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.carMake.inputAccessoryView = toolBar;
}
#pragma mark - doneTouched
- (void)cancelTouched:(UIBarButtonItem *)sender{
    // hide the picker view
    [self.carMake resignFirstResponder];
}
#pragma mark - doneTouched
- (void)doneTouched:(UIBarButtonItem *)sender{
    // hide the picker view
    [self.carMake resignFirstResponder];
    [self pickerviewmodel:self];
    // perform some action
}

//car yeasr selection picker view

-(void)carYearPickerView:(id)sender{
    carYearPick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    carYearPick.showsSelectionIndicator = YES;
    carYearPick.dataSource = self;
    carYearPick.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.carYear.inputView = carYearPick;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.carYear.inputAccessoryView = toolBar;
}


//car bodypicker code
-(void)carBodyPickerView:(id)sender{
    carBodyTypePick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    carBodyTypePick.showsSelectionIndicator = YES;
    carBodyTypePick.dataSource = self;
    carBodyTypePick.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.bodyType.inputView = carBodyTypePick;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.bodyType.inputAccessoryView = toolBar;
}



#pragma mark - The Picker Challenge
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if([pickerView isEqual: pickerview]){
        // return the appropriate number of components, for instance
        return 1;
    }
    
    else if([pickerView isEqual: pickerviewmodel]){
        // return the appropriate number of components, for instance
        return 1;
    }
    else if([pickerView isEqual:carYearPick])
    {
        return 1;
    }
    else if ([pickerView isEqual:carBodyTypePick])
    {
        return 1;
    }
    return 0;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:pickerview]) {
        return [availableMakes count];
    }
    else if ([pickerView isEqual:pickerviewmodel]) {
        return [availableModels count];
    }
    else if ([pickerView isEqual:carYearPick]) {
        return [carYearPicker count];
    }
    else if ([pickerView isEqual:carBodyTypePick]){
        return [bodyTypeArray count];
    }
    return 0;
}



- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView isEqual:pickerview]) {
        return availableMakes[row];
    }
    if ([pickerView isEqual:pickerviewmodel]) {
        return availableModels[row];
    }
    else if ([pickerView isEqual:carYearPick])
    {
    return carYearPicker[row];
    }
    else if ([pickerView isEqual:carBodyTypePick])
    {
        return bodyTypeArray[row];
    }
    return NULL;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:pickerview]) {
        self.carMake.text = availableMakes[row];
        PFQuery *query1 = [PFQuery queryWithClassName:@"carModel"];
        [query1 whereKey:@"make" containsString:self.carMake.text];
        [query1 findObjectsInBackgroundWithBlock:^(NSArray *carModelsParse, NSError *error) {
            if (carModelsParse) {
                NSLog(@"%@", carModelsParse);
                availableModels = [carModelsParse valueForKey:@"model"];
                
            }
        }];
    }
    if ([pickerView isEqual:pickerviewmodel]) {
        self.carModel.text = availableModels[row];
    }
    if ([pickerView isEqual:carYearPick])
    {
        self.carYear.text = carYearPicker[row];
    }
    if ([pickerView isEqual:carBodyTypePick]) {
        self.bodyType.text = bodyTypeArray[row];
    }
}


-(void)pickerviewmodel:(id)sender{
    pickerviewmodel = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerviewmodel.showsSelectionIndicator = YES;
    pickerviewmodel.dataSource = self;
    pickerviewmodel.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.carModel.inputView = pickerviewmodel;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.carModel.inputAccessoryView = toolBar;
}

#pragma mark - doneTouched
- (void)cancelTouched1:(UIBarButtonItem *)sender{
    // hide the picker view
    [self.carModel resignFirstResponder];
}
#pragma mark - doneTouched
- (void)doneTouched1:(UIBarButtonItem *)sender{
    // hide the picker view
    [self.carModel resignFirstResponder];
    // perform some action
}



@end

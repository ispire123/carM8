//
//  CleaningDetails.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 15/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "CleaningDetails.h"
#import "DetailDisplay.h"
#import <Parse/Parse.h>
#import "TextFieldValidator.h"
#import "DetailDisplay.h"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define kPostURL @"http://automateoz.com/mail.php"
#define KEmailCustomerURL @"http://automateoz.com/userMail.php"
#define KName @"name"
#define KMessage @"message"
#define KPhone @"phone"
#define KEmail @"email"
#define KFirstName @"firstname"
#define KAddress @"address"
#define KCar @"car"

@interface CleaningDetails ()<UITextFieldDelegate, UITextViewDelegate>
{
    
    IBOutlet TextFieldValidator *cleaningCar;
    IBOutlet TextFieldValidator *cleanDate;
    IBOutlet TextFieldValidator *cleanTime;
    NSString *serviceTime;
    NSString *serviceDate;
    NSString *cEmail;
    NSDate *serviceDateLimit;
}

@end

@implementation CleaningDetails 
@synthesize carSelected;
@synthesize lSelected;
@synthesize productSelected;
@synthesize productPrice;
- (void)viewDidLoad {
    [super viewDidLoad];

    //Strip Screen
    
    
    
    
    _paymentText.text = @"Cash Payment";
    _buttonS.enabled = false;
    NSLog(@" from cleaning Details %@", productSelected);
    cEmail = [[PFUser currentUser ] objectForKey:@"email"];
    PFQuery *query = [PFQuery queryWithClassName:@"customerCars"];
    [query whereKey:@"cEmail" containsString:cEmail];
    [query findObjectsInBackgroundWithBlock:^(NSArray *carFromParse, NSError *error) {
        if (carFromParse) {
            NSLog(@"%@", carFromParse);
            //availableMakes = [[NSMutableArray alloc]initWithArray:carMakeParse];
            carArray =[carFromParse valueForKey:@"rego"];
        }
        else{
            carArray = [[NSMutableArray alloc]initWithObjects:@"no cars found", nil];
        }
    }];

    
    // Do any additional setup after loading the view.
    
    _productLabel.text = productSelected;
    _locationMap.text = lSelected;
    date = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    date.datePickerMode = UIDatePickerModeDate;
    date.minimumDate = [NSDate date];
    date.maximumDate = [NSDate dateWithTimeIntervalSinceNow:2592000];
    [self.cleanDate setInputView : date];
    UIToolbar *toolBarDate = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBarDate.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButtonDate = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showSelectedDate)];
    UIBarButtonItem *cancelButtonDate = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouchedDate:)];
    [toolBarDate setItems:[NSArray arrayWithObjects:cancelButtonDate, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButtonDate, nil]];
    [self.cleanDate setInputAccessoryView:toolBarDate];
    
    //new timer
    time = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    time.datePickerMode = UIDatePickerModeTime;
    time.minuteInterval = 30;
   // NSDate *minDate = [NSDate new];
    // One hour from now
    //NSDate *maxDate = [[NSDate alloc] initWithTimeIntervalSinceNow:60*60];
    //NSDate *Today;
    NSDate *minDate = [self beginningOfDay:[NSDate new]];
    NSDate *maxDate = [self endOfDay:[NSDate new]];
    
   [time setMinimumDate:minDate];
   [time setMaximumDate:maxDate];
    
    [self.cleanTime setInputView:time];
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar1.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showSelectedTime)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar1 setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    [self.cleanTime setInputAccessoryView:toolBar1];

   // [self setupAlerts];
    
}



-(NSString *)setPrice:(NSString *)product{
    if ([product isEqualToString:@"$35"]) {
        product = @"35";
    }
    else if ([product isEqualToString:@"$30"])
    {
        product = @"30";
    }
    else if ([product isEqualToString:@"$25"])
    {
        product = @"25";
    }
    return product;
}


-(NSDate *)beginningOfDay:(NSDate *)date1
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:date1];
    
    [components setHour:9];
    [components setMinute:0];
    [components setSecond:0];
    
    return [cal dateFromComponents:components];
    
}

-(NSDate *)endOfDay:(NSDate *)date2
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond )fromDate:date2];
    
    [components setHour:17];
    [components setMinute:0];
    [components setSecond:0];
    
    return [cal dateFromComponents:components];
    
}




-(void)setupAlerts{
    
    cleaningCar.isMandatory = YES;
    cleanDate.isMandatory = YES;
    cleanTime.isMandatory = YES;
}

-(void)showSelectedTime{
    NSDateFormatter *serviceTimeFormatter = [[NSDateFormatter alloc]init];
    [serviceTimeFormatter setDateFormat:@"h:mm a"];
    
    serviceTime = [serviceTimeFormatter stringFromDate:time.date];
    self.cleanTime.text = serviceTime;
    [_cleanTime resignFirstResponder];
}

-(void)showSelectedDate{
    NSDateFormatter *serviceDateFormatter = [[NSDateFormatter alloc] init];
    
    [serviceDateFormatter setDateFormat:@"dd / MM / YYYY"];
    
   // serviceDateLimit = date.date;
    
    //serviceDateLimit = [self utcToLocale:serviceDateLimit];
    
    NSLog(@"%@", serviceDateLimit);
    NSDate *time1 = [NSDate new];
    NSLog(@"%@", time1);
    serviceDate = [serviceDateFormatter stringFromDate:date.date];
    self.cleanDate.text = serviceDate;
    serviceDateLimit = [self utcToLocale:date.date];
    NSLog(@"%@", serviceDateLimit);
    [_cleanDate resignFirstResponder];
}

-(NSDate *)utcToLocale:(NSDate *)localeDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    NSTimeZone *melb = [NSTimeZone timeZoneWithName:@"Australia/Melbourne"];
    
    

    [formatter setTimeZone:melb];
    
    //NSDate *melbourneTime;
   // melbourneTime = [formatter setDate]
  
    return localeDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    
        return 1;
    }
    

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
        return [carArray count];
    
}



- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    
        return carArray[row];
   
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
        cleaningCar.text = carArray[row];
                
    
}

//will be used in verson 1.1
/*-(void)pickerview:(id)sender{
    car = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    car.showsSelectionIndicator = YES;
    car.dataSource = self;
    car.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.cleaningCar.inputView = car;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.cleaningCar.inputAccessoryView = toolBar;
}
 */
#pragma mark - doneTouched
- (void)cancelTouched:(UIBarButtonItem *)sender{
    // hide the picker view
    [self.cleanTime resignFirstResponder];
}
#pragma mark - doneTouched
- (void)cancelTouchedDate:(UIBarButtonItem *)sender{
    // hide the picker view
    [self.cleanDate resignFirstResponder];
    // perform some action
}






- (IBAction)termsWebView:(id)sender {
    
}

- (IBAction)backgroundTouch:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)tcValueChanged:(id)sender {
    if (!(_termNconditions.on)) {
        //This switch has to on the customer has to accept T&C
        //generate message to a view
         _buttonS.enabled = false;
        
    }
    else if (_termNconditions.on){
         _buttonS.enabled = true;
        
        _buttonPayment.enabled = true;
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        if ([segue.identifier isEqualToString:@"reciept"]) {
        DetailDisplay *nextView = segue.destinationViewController;
        
        nextView.cSel = cleaningCar.text;
        nextView.cDate = _cleanDate.text;
        nextView.cTime = _cleanTime.text;
        nextView.cLocation = _locationMap.text;
        nextView.cSelected = _productLabel.text;
        nextView.productPrice = productPrice;
            nextView.paymentMethod = _paymentText.text;
        
        }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([cleaningCar.text isEqualToString:@""] || [_cleanDate.text isEqualToString:@""] || [_cleanTime.text isEqualToString:@""] == true){
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Missing" message:@"Complete all fields!" preferredStyle:UIAlertControllerStyleAlert];
        
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
    NSLog(@"Prepare for segue NO");
    return NO;
        
    }
    else{
        NSLog(@"prepare for segue YES");
    return YES;
    }
}

- (IBAction)submit:(id)sender {
    
    if ([cleaningCar.text isEqualToString:@""] || [_cleanDate.text isEqualToString:@""] || [_cleanTime.text isEqualToString:@""] == true) {
        NSLog(@"it is in parse if block");
    

    }else {
        NSLog(@"parse else block");
        PFObject *serviceStore = [PFObject objectWithClassName:@"cleaningService"];
        serviceStore[@"car"] = cleaningCar.text;
        serviceStore[@"customer"] = [PFUser currentUser].objectId;
        serviceStore[@"date"] = _cleanDate.text;
        serviceStore[@"time"] = _cleanTime.text;
        serviceStore[@"location"] = _locationMap.text;
        serviceStore[@"product"] = _productLabel.text;
        serviceStore[@"desc"] = _cleanDescription.text;
        serviceStore[@"status"] = @"requested";
        serviceStore[@"paymentMethod"] = _paymentText.text;
        [serviceStore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                NSString *FirstName = [[PFUser currentUser]objectForKey:@"firstName"];
                NSString *email = [[PFUser currentUser]objectForKey:@"email"];
                NSString *phone = [[PFUser currentUser]objectForKey:@"phone"];
                [self postMail:email withName:FirstName];
                [self postMessage:phone withName:FirstName withAddress:_locationMap.text withCar:cleaningCar.text];
                
            }
        }];
    }

}

-(void)postMail:(NSString *)email withName:(NSString *)firstname{
    NSMutableString *postString = [NSMutableString stringWithString:KEmailCustomerURL];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", KEmail, email]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", KFirstName, firstname]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}


-(void)postMessage:(NSString *)phone withName:(NSString *)name withAddress:(NSString *)address withCar:(NSString *)car1{
    NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", KName, name]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", KPhone, phone]];
    [postString appendString:[NSString stringWithFormat:@"&&%@=%@", KAddress, address]];
    [postString appendString:[NSString stringWithFormat:@"&&&%@=%@", KCar, car1]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}


-(void) textViewDidBeginEditing:(UITextView *)textView{
    [textView setText:@""];
}

- (IBAction)choosePayment:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Payment Method"
                                 message:@"Choose your payment method"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Cash"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             _paymentText.text = @"Cash Payment";
                             
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Online"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _paymentText.text = @"Online Payment";
                                 
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:ok];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == cleaningCar){
        [cleaningCar resignFirstResponder];
        [cleanDate becomeFirstResponder];
    }
    else if (textField == cleanDate)
    {
        [cleanDate resignFirstResponder];
        [cleanTime becomeFirstResponder];
    }
    else if(textField == cleanTime){
        [cleanTime resignFirstResponder];
    }
 
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
  return YES;
}


- (IBAction)paymentValue:(UISegmentedControl *)sender {
    switch(sender.selectedSegmentIndex){
            case 0:
            _paymentText.text = @"Cash Payment";
            break;
            case 1:
            _paymentText.text = @"Online Payment";
            default:
            break;
    }
}



- (void)presentError:(NSError *)error {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)paymentSucceeded {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Success" message:@"Payment successfully created!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)checkForPaymentEmpty{
    if ([_paymentText.text isEqualToString:@""] == true) {
        UIAlertController *fieldAreEmpty = [UIAlertController alertControllerWithTitle:@"Payment Method" message:@"Please Choose your prefered payment method" preferredStyle:UIAlertControllerStyleAlert];
        
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
    else{
        //call store funtion
    }
    
}


// This passes the token off to our payment backend, which will then actually complete charging the card using your Stripe account's secret key


@end

//
//  SearchViewController.m
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 2/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import "SearchViewController.h"
#import <Parse/Parse.h>
#import "ProductSelection.h"
#import "SWRevealViewController.h"
#import "MLPAutoCompleteTextFieldDataSource.h"
#import "MLPAutoCompleteTextField.h"

#define SPAN_VALUE 1.0f
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface SearchViewController () <MKMapViewDelegate,CLLocationManagerDelegate>{

    NSArray *locationsFound;
    NSString *postalCodeIdentity;
    
    IBOutlet MLPAutoCompleteTextField *ADDRESS;
}

@end

@implementation SearchViewController
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *location;
}
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
        _requestButton.enabled = false;
    [self.currentAddress setDelegate:self];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    // Do any additional setup after loading the view.
    mapView.delegate = self;
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc]init];
    locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
#endif
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
 [locationManager startUpdatingLocation];
   // mapView.showsUserLocation = YES;
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField
{
    [textField resignFirstResponder];
    //[self requestForwardGeoCoding:_currentAddress.text];
    [self requestForwardGeoCoding:_currentAddress.text];
   
    return YES;
}

- (void)requestForwardGeoCoding:(NSString *)address
{
    [geocoder geocodeAddressString:address
                   completionHandler:^(NSArray* placemarks, NSError* error) {
                       // check that there is no error
                       if (placemarks && placemarks.count > 0) {
                           
                           [locationsFound initWithArray:placemarks];
                          CLPlacemark *topResult = [placemarks objectAtIndex:0];
                           placemark = [placemarks lastObject];
                           MKPlacemark *placemarkc = [[MKPlacemark alloc] initWithPlacemark:topResult];
                           MKCoordinateRegion region;
                           region.center.latitude = topResult.location.coordinate.latitude;
                           region.center.longitude = topResult.location.coordinate.longitude;
                           region.span.latitudeDelta = SPAN_VALUE;
                           region.span.longitudeDelta = SPAN_VALUE;
                           NSArray *annotations = [mapView annotations];
                           for (id annotation in annotations) {
                               if ([annotation isKindOfClass:[MKUserLocation class]]) {
                                   continue;
                               }
                               [mapView removeAnnotation:annotation];
                           }
                           [self.mapView setRegion:region animated:YES];
                           
                           _currentAddress.text = [NSString stringWithFormat:@"%@ %@ %@",
                            
                            placemark.name,placemark.subLocality, placemark.postalCode];
                           NSLog(@"%@", _currentAddress.text);
                           
                           postalCodeIdentity = [NSString stringWithFormat:@"%@", placemark.postalCode];
                           
                           if (!([postalCodeIdentity isEqualToString:@"3000"] || [postalCodeIdentity isEqualToString:@"3006"] || [postalCodeIdentity isEqualToString:@"3008"])) {
                               
                               UIAlertController * view=   [UIAlertController
                                                            alertControllerWithTitle:@"Sorry"
                                                            message:@"We Operate within Melbourne City and inner Suburbs, We are expanding soon."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
                               
                               UIAlertAction* ok = [UIAlertAction
                                                    actionWithTitle:@"ok"
                                                    style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action)
                                                    {
                                                    [view dismissViewControllerAnimated:YES completion:nil];
                                                        
                                                    }];
                               [view addAction:ok];
                               
                               [self presentViewController:view animated:YES completion:nil];
                               _currentAddress.text = @"";
                               _requestButton.enabled = NO;
                               
                           }
                           else{
                              [self.mapView addAnnotation:placemarkc];
                                _requestButton.enabled = true;
                           }
                           
                           
                       } else {
                           [error localizedDescription];
                       }
                   }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
  [self.mapView addAnnotation:point];
  [locationManager stopUpdatingLocation];
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didfailwitherror: %@", error);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentlocation = newLocation;
    [geocoder reverseGeocodeLocation:currentlocation completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            location = [NSString stringWithFormat:@"%@ %@ %@ %@",
                                 placemark.thoroughfare,
                                 placemark.subLocality, placemark.subAdministrativeArea,placemark.name];
            
            NSLog(@"%@", location);
           
        }
    }];
    
}



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"requestCln"]) {
        if ([_currentAddress.text isEqualToString:@""]) {
            NSLog(@"error");
            
        }
        else{
            
        ProductSelection *nextView = segue.destinationViewController;
        nextView.carLocationSelected = _currentAddress.text;
    }
}
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void(^)(NSArray *suggestions))handler{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        if(self.simulateLatency){
            CGFloat seconds = arc4random_uniform(4)+arc4random_uniform(4);
            NSLog(@"sleeping fetch of completion for %f", seconds);
            sleep(seconds);
        }
    
    NSArray *completions;
    if(self.testWithAutoCompleteObjectsInsteadOfStrings){
        completions = [self requestForwardGeoCodingArray:_currentAddress.text];
        NSLog(@"to drop downed %@", completions);
    }
        handler(completions);
    });
}


//forward returning Array
- (NSArray *)requestForwardGeoCodingArray:(NSString *)address
{
    [geocoder geocodeAddressString:address
                 completionHandler:^(NSArray* placemarks, NSError* error) {
                     // check that there is no error
                     if (placemarks && placemarks.count > 0) {
                      // NSLog(@"%@", placemarks);
                         locationsFound = [[NSArray alloc]initWithArray:placemarks];
                        // NSLog(@"%@", locationsFound);
                                              } else {
                         [error localizedDescription];
                     }
                 }];
    return locationsFound;
}


@end

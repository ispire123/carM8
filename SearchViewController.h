//
//  SearchViewController.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 2/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface SearchViewController : UIViewController <CLLocationManagerDelegate,UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *locationView;
@property (strong, nonatomic) IBOutlet UITextView *userAddress;
@property(nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)requestCleaning:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UITextField *currentAddress;
@property (strong, nonatomic) IBOutlet UIButton *requestButton;

@property (assign) BOOL simulateLatency;
@property (assign) BOOL testWithAutoCompleteObjectsInsteadOfStrings;
@end

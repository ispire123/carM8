//
//  EditProfileViewController.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 5/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController
{
     NSMutableArray *cProfile;
}
@property (weak, nonatomic) IBOutlet UITextField *cname;
@property (weak, nonatomic) IBOutlet UITextField *cphone;


- (IBAction)update:(id)sender;
@end

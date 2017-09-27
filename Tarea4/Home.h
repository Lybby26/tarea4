//
//  ViewController.h
//  Tarea4
//
//  Created by Mac Mini on 9/25/17.
//  Copyright © 2017 lybby26. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Home :  UIViewController
 <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}

@property (strong, nonatomic) IBOutlet UITableView *tblMain;
- (IBAction)btnAddPressed:(id)sender;


@end


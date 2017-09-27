//
//  ViewController.m
//  Tarea4
//
//  Created by Mac Mini on 9/25/17.
//  Copyright © 2017 lybby26. All rights reserved.
//

#import "Home.h"
#import "cellMainTable.h"

@interface Home ()
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;
@property UIImage *choosenImage;
@property NSString *choosenName;
@property NSString *choosenAge;
@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------
- (void)initController {
    self.userNames  = [[NSMutableArray alloc] initWithObjects: @"Tyrion Lannister", @"Daenerys Targaryen", @"Jon Snow", @"Arya Stark", @"Cersei Lannister", nil];
    
    self.userAges  = [[NSMutableArray alloc] initWithObjects: @"38 años", @"22 años", @"25 años", @"16 años", @"42 años", nil];
    
    self.userImages = [[NSMutableArray alloc] initWithObjects: [UIImage imageNamed: @"tyrion.jpg"] , [UIImage imageNamed:@"daenerys.jpeg"], [UIImage imageNamed:@"jon.jpeg" ], [UIImage imageNamed:@"arya.jpg" ], [UIImage imageNamed:@"cersei.jpeg" ], nil];
    
    
    
}
/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellMainTable" bundle:nil] forCellReuseIdentifier:@"cellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    }
    //Fill cell with info from arrays
    cell.lblName.text       = self.userNames[indexPath.row];
    cell.lblAge.text        = self.userAges[indexPath.row];
    NSLog(@"Paso por aqui");
    cell.imgUser.image      = self.userImages[indexPath.row];
    //[UIImage imageNamed:self.userImages[indexPath.row]];
    
    return cell;
}

 /*
  Este es el metodo para obtener la imagen de la camara
  -(void)getPhotofrom{
 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
 picker.delegate = self;
 picker.allowsEditing = YES;
 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
 [self presentViewController:picker animated:YES completion:nil];
  }*/
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Pending
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Paso por aqui imagePickerController");
    // output image
    UIImage *chosenImg = info[UIImagePickerControllerOriginalImage];
    self.choosenImage = chosenImg;
    
    [self.userNames addObject:_choosenName];
    [self.userAges addObject:_choosenAge];
    [self.userImages addObject:chosenImg];
     //[UIImage imageNamed:@"daenerys.jpeg"]];
   
    [picker dismissViewControllerAnimated:YES completion:nil];
     [self.tblMain reloadData];
    
}
- (IBAction)btnAddPressed:(id)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Agregar personaje" message: @"Ingresa nombre y edad del personaje" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"nombre";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"edad";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
    }];
    
    /**/
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        UITextField * agefield = textfields[1];
        
        
        
        NSLog(@"%@:%@",namefield.text,agefield.text);
        if (![namefield.text isEqualToString:@""] && ![agefield.text isEqualToString:@""]) {
            
            self.choosenName= namefield.text;
            self.choosenAge = agefield.text;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
            [self presentViewController:picker animated:YES completion:nil];
   
            
        }
        
    }]];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancelled");
    }];
    [alertController addAction:cancelAction];

    
    /**/
    
    //[self.tblMain reloadData];
   
    [self presentViewController:alertController animated:YES completion:nil];
    
    
  
}
@end

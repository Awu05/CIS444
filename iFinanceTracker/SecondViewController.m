//
//  SecondViewController.m
//  iFinanceTracker
//
//  Created by Andy Wu on 11/21/15.
//  Copyright © 2015 Andy Wu. All rights reserved.
//

#import "SecondViewController.h"
#import "AddAmountViewController.h"
#import "LoginViewController.h"
#import "dbModel.h"
#import "DBManager.h"

//ViewController for Food
@interface SecondViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@end

NSString *globalSumFood;

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"appdb.sql"];
    NSInteger hold;
    NSString *foodData;
    NSInteger b;
    @try {
        
        foodData = [NSString stringWithFormat:@"select * from userInfo where username = '%@'", globalUser];
        NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:foodData]];
        b = [filler intValue];
        filler = [[results objectAtIndex:0]objectAtIndex:4];
        hold = [filler integerValue] + [globalSumFood integerValue];
        globalSumFood = [NSString stringWithFormat:@"%ld", (long)hold];
        _amountSpentFood.text = [NSString stringWithFormat:@"%@", globalSumFood];
        
        
    }
    
    @catch(NSException *exception)
    {
        filler = foodData;
        _amountSpentFood.text = filler;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewFoodTransacts:(UIButton *)sender {
    //I used code from this website http://hayageek.com/uialertcontroller-example-ios/#simple
    //This is used to pop up an alerter to show the transactions
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Food Transactions"
                                  message:@"You are using UIAlertController"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    //This is the function to create the OK button on the alerter
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

// Used code from http://www.mysamplecode.com/2012/12/ios-passing-data-between-view-controllers.html
// This method determines which viewcontroller it came from so that it fills out the category
// in the Add Amount page.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    AddAmountViewController *transferViewController = segue.destinationViewController;
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"Food"])
    {
        transferViewController.fnameText = @"Food";
        
        
    }
    
}

@end

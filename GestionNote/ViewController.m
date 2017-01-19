//
//  ViewController.m
//  GestionNote
//
//  Created by ios on 25/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import "ViewController.h"
#import "Matiere.h"
#import "AppDelegate.h"
#import "ListeMatiereViewController.h"
#import "Reachability.h"
#include <stdlib.h>

@interface ViewController ()
{
    Reachability *internetReachableFoo;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  testInternetConnection];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    txtCode.inputAccessoryView = numberToolbar;
    
    int r = arc4random_uniform(1000);
    lbRandomCode.text = [NSString stringWithFormat:@"%d", r];



}




- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
           // NSLog(@"Yayyy, we have the interwebs!");
              [self fetchJson];
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
           // NSLog(@"Someone broke the internet :(");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"You don't have internet connexion ! Your application will be closed"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
            alert.tag = 100;
            [alert show];
        
        });
    };
    
    [internetReachableFoo startNotifier];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    // Is this my Alert View?
    if (alertView.tag == 100) {
        //Yes
       
        
        // You need to compare 'buttonIndex' & 0 to other value(1,2,3) if u have more buttons.
        // Then u can check which button was pressed.
        if (buttonIndex == 0) {// 1st Other Button
            
            exit(0);
            
        }
    }
}

-(void) fetchJson {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AppDelegate* appd = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        //Background Thread
        NSString *req = [NSString stringWithFormat: @"http://%@/iosProject/index.php?tag=getAll",  appd.ipAdresse];
        
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:req]];
        NSError *error;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        id jsonobject=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if ([jsonobject isKindOfClass:[NSDictionary class]]) {
            // NSDictionary *dict=(NSDictionary *)jsonobject;
            //NSLog(@"dict==%@",dict);
            // NSString *matieres = [dict objectForKey:@"matieres"];
            NSArray *matieres = [json objectForKey:@"matieres"];
            Matiere* mat;
            for (NSDictionary * dataDict in matieres) {
                float matiereNote = [[dataDict objectForKey:@"note"] floatValue];
                NSString* matiereNom = [dataDict objectForKey:@"nom"] ;
                float matiereCoef = [[dataDict objectForKey:@"coef"]floatValue];
                mat = [[Matiere alloc]initMatiereWithName:matiereNom  withNote:matiereNote withCoef:matiereCoef ];
                [mat addMatiereToList:(appd.listMatiere)];
            }
            
            NSLog(@"metieres %@", matieres);
            
        }
        else
        {
            NSArray *array=(NSArray *)jsonobject;
            NSLog(@"array==%@",array);
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Your main thread code goes in here
            NSLog(@"Im on the main thread");
        });
    });
    
}


-(void)cancelNumberPad{
    [txtCode resignFirstResponder];
    txtCode.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = txtCode.text;
    [txtCode resignFirstResponder];
}



-(IBAction)GoToList:(id)sender
{
    if([txtCode.text isEqualToString:lbRandomCode.text])
    {
        

    ListeMatiereViewController* secondView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListeMatiereViewController"];
    [self.navigationController pushViewController:secondView animated:YES];
        lbMessage.text = [NSString stringWithFormat:@""];
        txtCode.text = [NSString stringWithFormat:@""];
    }
    else
    {
       lbMessage.text = [NSString stringWithFormat:@"Invalid Code ! Please right again"];
    }
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

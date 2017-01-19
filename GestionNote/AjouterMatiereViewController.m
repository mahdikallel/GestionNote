//
//  AjouterMatiereViewController.m
//  GestionNote
//
//  Created by ios on 26/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import "AjouterMatiereViewController.h"
#import "Matiere.h"
#import "AppDelegate.h"
#import "ListeMatiereViewController.h"

@interface AjouterMatiereViewController ()

@end

@implementation AjouterMatiereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    txtNote.inputAccessoryView = numberToolbar;
   
    
    // Do any additional setup after loading the view.
}



-(void)cancelNumberPad{
    [txtNote resignFirstResponder];
    txtNote.text = @"";
    
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = txtNote.text;
    [txtNote resignFirstResponder];
  
}


-(IBAction)addMatiere:(id)sender
{
    float note =[txtNote.text floatValue];
    
    if(note >20 || note <0)
    {
        lbmessage.text = [NSString stringWithFormat:@"Invalid note ! Please right again"];
    }else if(txtNote.text.length==0 || txtCoef.text.length==0 ||txtNom.text.length==0)
    {
        lbmessage.text = [NSString stringWithFormat:@"All fields are mandatory ! Please right again"];
    }
    else{
    Matiere* mat = [[Matiere alloc]initMatiereWithName:txtNom.text  withNote:[txtNote.text floatValue] withCoef:[txtCoef.text floatValue] ];
    //add to database json
    AppDelegate* appd = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *req = [NSString stringWithFormat: @"http://%@/iosProject/index.php?tag=register&nom=%@&coef=%@&note=%@",  appd.ipAdresse,txtNom.text,txtCoef.text,txtNote.text];
        
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:req]];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
    id jsonobject=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        
        
        
        
        
        
    

    [mat addMatiereToList:(appd.listMatiere)];
    
    
    ListeMatiereViewController* listeMatView = [self.storyboard instantiateViewControllerWithIdentifier:@"ListeMatiereViewController"];
    [self.navigationController pushViewController:listeMatView animated:YES];
    }
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

@end

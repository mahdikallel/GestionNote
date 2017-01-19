//
//  ListeMatiereViewController.m
//  GestionNote
//
//  Created by ios on 25/11/2016.
//  Copyright (c) 2016 ios. All rights reserved.
//

#import "ListeMatiereViewController.h"
#import "AjouterMatiereViewController.h"
#import "AppDelegate.h"
#import "ListViewCell.h"
#import "Matiere.h"
#import "MoyenneViewController.h"
@interface ListeMatiereViewController ()

@end

@implementation ListeMatiereViewController
@synthesize moyView;

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.hidesBackButton = YES;
    
    //moyView.moy=0;
    self.sommeNote=0;
    self.sommeCoef=0;
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AppDelegate* appd = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appd.listMatiere.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    static NSString* simpleTableIdentifier = @"ListViewCell";
    
    ListViewCell* cell =[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil)
    {
        
        NSArray* nib = [[ NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell= [nib objectAtIndex:0];
    }
    AppDelegate* appd = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    Matiere* mat=[appd.listMatiere objectAtIndex:indexPath.row];
    
    
    cell.lbMatiere.text=mat.nom;
    cell.lbNote.text=[NSString stringWithFormat:@"%.02f",mat.note] ;
    
    cell.lbCoeff.text= [NSString stringWithFormat:@"%.02f",mat.coef] ;
    
    self.sommeCoef+=mat.coef ;
    self.sommeNote+=mat.note *mat.coef ;
    return cell;
}

-(IBAction)GoToForm:(id)sender
{
    AjouterMatiereViewController* formView = [self.storyboard instantiateViewControllerWithIdentifier:@"AjouterMatiereViewController"];
    [self.navigationController pushViewController:formView animated:YES];

}

-(IBAction)GoToMoyenne:(id)sender
{
      moyView = [self.storyboard instantiateViewControllerWithIdentifier:@"MoyenneViewController"];
    if(self.sommeNote>0)
    {
        moyView.moy=self.sommeNote/self.sommeCoef;
    }
  
    [self.navigationController pushViewController:moyView animated:YES];
    
}




-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    headerView.layer.borderWidth = 1.0;
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
    headerLabel.text = @"Matter                                      Note      Coefficient";
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:headerLabel];
    return headerView;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        AppDelegate* appd =(AppDelegate*)[[UIApplication sharedApplication]delegate];
        Matiere* mtr=[appd.listMatiere objectAtIndex: indexPath.row];
       
        [appd.listMatiere removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSString *req = [NSString stringWithFormat: @"http://%@/iosProject/index.php?tag=remove&nom=%@",  appd.ipAdresse,mtr.nom];
        
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:req]];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        id jsonobject=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
  
        float note=mtr.note ;
        float coeff=mtr.coef ;
        self.sommeNote-=(note*coeff);
        self.sommeCoef-=coeff;
        NSLog(@"somme note @%f",self.sommeNote);
        NSLog(@"somme coef @%f",self.sommeCoef);
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

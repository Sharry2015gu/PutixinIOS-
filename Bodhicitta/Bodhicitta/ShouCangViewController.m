//
//  ShouCangViewController.m
//  Bodhicitta
//
//  Created by 怀恩2 on 15/6/18.
//  Copyright (c) 2015年 怀恩2. All rights reserved.
//

#import "ShouCangViewController.h"

@interface ShouCangViewController ()

@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"cellID";
    ShouCangViewController *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (cell == nil) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShouCangViewController" owner:nil options:nil][0];
    }
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 250)];
    view.backgroundColor=[UIColor whiteColor];
    

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

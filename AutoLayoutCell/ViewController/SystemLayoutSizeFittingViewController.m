//
//  SystemLayoutSizeFittingViewController.m
//  AutoLayoutCell
//
//  Created by Destiny on 2018/1/8.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "SystemLayoutSizeFittingViewController.h"
#import "TestCell.h"
#import "UITableView+AutoLayoutCell.h"

@interface SystemLayoutSizeFittingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SystemLayoutSizeFittingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:nil] forCellReuseIdentifier:@"TestCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
    [cell updatecellHeight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView heightForAutoLayoutCellWithIdentifier:@"TestCell" cacheKey:[NSString stringWithFormat:@"TestCell%ld_%ld",indexPath.section,indexPath.row] configaurtaion:^(id cell) {
        [cell updatecellHeight];
    }];
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

//
//  PICLoginViewController.m
//  Picidae
//
//  Created by Neo on 2017/3/4.
//  Copyright © 2017年 394570610@qq.com. All rights reserved.
//

#import "PICLoginViewController.h"

@interface PICLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation PICLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)loginClick:(UIButton *)sender {
    if (self.phoneNum.text.length != 0 && self.password.text.length != 0) {
        [self.navigationController popViewControllerAnimated:YES];
        self.loginButton.enabled = NO;
    }
    else{
        
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    if (self.loginButton.enabled == YES) {
        if (self.successCallBack) {
            self.successCallBack(nil);
        }
    }
    else{
        if (self.successCallBack) {
            self.successCallBack(@{@"phone":self.phoneNum.text});
        }
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

//
//  PICLoginViewController.h
//  Picidae
//
//  Created by Neo on 2017/3/4.
//  Copyright © 2017年 394570610@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PICLoginViewController : UIViewController
@property(nonatomic,copy)void (^errorCallBack)(NSError *error);
@property(nonatomic,copy) void (^successCallBack)(NSDictionary *responseDict);
@end

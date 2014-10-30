//
//  GatherViewController.h
//  HappyJoke
//
//  Created by Betel on 11-7-25.
//  Copyright 2011年 231313. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
@interface GatherViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate, MFMessageComposeViewControllerDelegate>
 {
    UITableView *cellPhoneTable;
    UIButton* sureButton;
    NSString *phonelLable;
    NSString *phoneNO;
    int nCount;
    NSMutableArray* tongXunIfo;
    NSMutableArray* tongXunNameIfo;

    BOOL isSave;
    UIView* lableView;
    UIImage* bottle;
    UIImageView* bottleView;
    NSString* partName;
    NSString* fullName;
    NSMutableDictionary* phoneInfo;
    NSMutableArray* numberX;
    NSMutableArray* addreeBookSelArray;
    NSMutableDictionary* addressBookDic;//根据拼音首字母进行排序过的字典
    NSMutableArray* addressBookAllArray;//所有的通讯录中的联系人数组
    NSMutableArray* listArray;//存放通讯录中所有人的姓名的首字母的数组

}

@property(nonatomic, retain)IBOutlet UITableView *cellPhoneTable;
@property(nonatomic, retain)IBOutlet UIButton *sureButton;
@property(nonatomic, retain)  NSString *phonelLable;
@property(nonatomic, retain)  NSString *fullName;
@property(nonatomic, retain)  NSString *partName;
@property(nonatomic, retain) NSString *phoneNO;
@property(nonatomic, retain) NSMutableArray *tongXunIfo;
@property(nonatomic, retain) NSMutableArray *tongXunNameIfo;
@property(nonatomic, retain) NSMutableArray *numberX;
@property(nonatomic, assign) BOOL isSave;
@property(nonatomic, retain) UIView* lableView;
@property(nonatomic, retain)  UIImage *bottle;
@property(nonatomic, retain)  UIImageView* bottleView;
@property(nonatomic, retain) NSMutableDictionary* phoneInfo;
@property(nonatomic, retain) NSMutableArray* addreeBookSelArray;
@property(nonatomic, retain) NSMutableDictionary* addressBookDic;//根据拼音首字母进行排序过的字典
@property(nonatomic, retain) NSMutableArray* addressBookAllArray;//所有的通讯录中的联系人数组
@property(nonatomic, retain) NSMutableArray* listArray;

/**把数据处理成可以按中文拼音首字母索引排序的表格，和音乐库的效果是一样的*/
-(NSMutableDictionary*) processAddressDataSource:(NSArray*) dataSource;
-(IBAction)sureButtonPressed;
-(void)click:(id)sender;
-(IBAction)addToContact;
@end

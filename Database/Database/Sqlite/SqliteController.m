//
//  SqliteController.m
//  Database
//
//  Created by  on 12-2-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SqliteController.h"


@interface SqliteController ()

@end

@implementation SqliteController
@synthesize table = table_;
@synthesize dataSource = dataSource_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SQLite操作";
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:0];
    self.dataSource = array;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)addRealTool:(id)sender
{
    NSString* userName = @"RealTool";
    NSString* password = @"PasswordRealTool";
    [self insertUsername:userName insertPassword:password];
}

-(IBAction)addStudio:(id)sender
{
    NSString* userName = @"Studio";
    NSString* password = @"PasswordStudio";
    [self insertUsername:userName insertPassword:password];
}


-(void)openSQLiteDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* dbFileName = @"sample1.db";
    NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:dbFileName];  
    if (sqlite3_open([dataFilePath UTF8String], &database) != SQLITE_OK) 
    {  
        sqlite3_close(database); 
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"打开数据库文件失败" 
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)initDB 
{  
    char *errorMsg;  
    NSString *sql = @"CREATE TABLE IF NOT EXISTS USER (USER_ID INTEGER PRIMARY KEY,USERNAME TEXT,PASSWORD TEXT);";  
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) 
    {  
        sqlite3_close(database);  
    }  
} 

- (void)insertUsername:(NSString *)username insertPassword:(NSString *)password 
{  
    [self openSQLiteDB];//调用打开库  
    [self initDB];//调用创建表  
    char *update = "INSERT OR REPLACE INTO USER (USERNAME,PASSWORD) VALUES (?,?);";//添加语句  
    sqlite3_stmt *statement;  
    if (sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK) 
    {  
        sqlite3_bind_text(statement, 1, [username UTF8String], -1, SQLITE_TRANSIENT);  
        sqlite3_bind_text(statement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);  
    }  
    if (sqlite3_step(statement) != SQLITE_DONE) 
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"执行数据库操作失败" 
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else 
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"执行数据库操作成功" 
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    sqlite3_finalize(statement);  
    sqlite3_close(database);  
} 

- (void)getUserInfo
{
    [self openSQLiteDB];//调用打开库  
    [self initDB];//调用创建表 
    [dataSource_ removeAllObjects];
    sqlite3_stmt *statement = nil;
    char *sql = "SELECT * FROM USER";
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) 
    {
        NSLog(@"Error: failed to prepare statement with message:get channels.");
    }
    //查询结 果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
    while (sqlite3_step(statement) == SQLITE_ROW) 
    {
        char* userName = (char*)sqlite3_column_text(statement, 1);
        char* password = (char*)sqlite3_column_text(statement, 2);     
        NSString* userNameStr= [NSString stringWithUTF8String:userName];
        NSString* passwordStr = [NSString stringWithUTF8String:password];
        NSLog(@"userName=%@  password=%@", userNameStr, passwordStr);
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:userNameStr, @"username",passwordStr,@"password", nil];
        [dataSource_ addObject:dic];
    }
    sqlite3_finalize(statement);
    sqlite3_close(database); 
}

-(IBAction)searchTable:(id)sender
{
    [self getUserInfo];
    [table_ reloadData];
}

-(void)deleteUser
{
    [self openSQLiteDB];
    [self initDB];
    NSString *sql =  @"DELETE FROM USER WHERE USERNAME=?;";//删除语句  
    sqlite3_stmt *statement;  
    NSString* username = @"RealTool";
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) 
    {  
        sqlite3_bind_text(statement, 1, [username UTF8String], -1, SQLITE_TRANSIENT);  

    }  
    if (sqlite3_step(statement) != SQLITE_DONE) 
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"执行删除数据库操作失败" 
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else 
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"执行删除数据库操作成功" 
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    sqlite3_finalize(statement);  
    sqlite3_close(database); 
}

-(IBAction)deleteSQLiteExe:(id)sender
{
    [self deleteUser];
    [table_ reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(dataSource_ != nil)
    {
        return [dataSource_ count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSDictionary* dic = [dataSource_ objectAtIndex:row];
    UITableViewCell* cell =  (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UserCell"];
    }
    cell.textLabel.text = [dic objectForKey:@"username"];
    cell.detailTextLabel.text = [dic objectForKey:@"password"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

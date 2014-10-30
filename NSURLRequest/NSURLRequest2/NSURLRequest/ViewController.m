//
//  ViewController.m
//  NSURLRequest
//
//  Created by Kevin Zhao on 11-12-8.
//  Copyright (c) 2011年 FH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize imagePathField = imagePathField_;
@synthesize imageView = imageView_;


//触发网络连接
- (IBAction)doConnect:(id)sender
{
    //初始化URL
    //NSURL *url = [[NSURL alloc] initWithString:[[self imagePathField] text]];
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"];
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    
    //初始化连接
    ///NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //发送请求
    //[connection start];
    
    NSHTTPURLResponse *httpURLResponse;
    
    [NSURLConnection sendSynchronousRequest: request returningResponse: &httpURLResponse error: nil]; 
    if ([httpURLResponse respondsToSelector:@selector(allHeaderFields)])
    {
        NSDictionary *dictionary = [httpURLResponse allHeaderFields];
        NSLog(@"%@", [dictionary description]);
    }

}



#pragma mark - NSURLConnectionDelegate

//收到应答
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    
    NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Status code :[%@]", [httpURLResponse statusCode]);
    
    
}

//接收数据回调
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    
    UIImage *image = [[UIImage alloc] initWithData:data];
    [[self imageView] setImage:image];
    

}

//网络连接结束
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
}

//网络连接错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}



@end

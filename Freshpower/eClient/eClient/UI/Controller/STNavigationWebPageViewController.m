#import "STNavigationWebPageViewController.h"

@interface STNavigationWebPageViewController ()

@end

@implementation STNavigationWebPageViewController

- (id)initWithNavigationTitle:(NSString *)navigationTitle resourcePath:(NSString *)resourcePath {
    self = [super init];
    if (self) {
        self.navigationItem.title=navigationTitle;
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:webView];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"page.bundle/%@.html",resourcePath]];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
        
    }
    return self;
}

@end

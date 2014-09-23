#import "STCommentViewController.h"
#define SUBMITFEEDBACKREQUESTCODE 501

@interface STCommentViewController ()

@end

@implementation STCommentViewController {
    UITextView *txtContent;
    TQStarRatingView *starRatingView;
    float _score;
}

- (id)init
{
    self = [super init];
    if (self) {
        _score=5;
        self.title=@"评论";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"提交"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(submit:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:self.view.bounds];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    txtContent=[[UITextView alloc]initWithFrame:CGRectMake(11.75, 10, 296.5, 147.5)];
    [txtContent setFont:[UIFont systemFontOfSize: 12.0]];
    [txtContent setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dbj"]]];
    [control addSubview:txtContent];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 167.5, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"总体评价:"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(90, 167.5, 200, 30) numberOfStar:5];
    starRatingView.delegate = self;
    [control addSubview:starRatingView];
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    _score=score*5;
}

- (void)submit:(id)sender
{
    
    [self backgroundDoneEditing:nil];
    NSString *content=[txtContent text];
    if([@"" isEqualToString:content]){
        [Common alert:@"请输入反馈内容"];
        return;
    }
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:content forKey:@"content"];
    [p setObject:@"3" forKey:@"msgType"];
    [p setObject:[NSString stringWithFormat:@"%.f",ceil(_score)] forKey:@"StarNum"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:SUBMITFEEDBACKREQUESTCODE];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLaddSuggest params:p];
}


- (void)backgroundDoneEditing:(id)sender
{
    [txtContent resignFirstResponder];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==SUBMITFEEDBACKREQUESTCODE){
        NSString *rs=[[response resultJSON] objectForKey:@"rs"];
        if([@"1" isEqualToString:rs]){
            [Common alert:@"评论成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Common alert:@"评论失败，请重试!"];
        }
    }
}

@end
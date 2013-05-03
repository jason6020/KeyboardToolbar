//
//  KeyboardToolbar.m
//  Jason6020 2013-05-03
//

#import "KeyboardToolbar.h"

@implementation KeyboardToolbar
@synthesize prevBarBtn = prevBarBtn_;
@synthesize nextBarBtn = nextBarBtn_;

@synthesize doneBarBtn = doneBarBtn_;

@synthesize textFieldArr = textFieldArr_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setFrame:frame];
        self.barStyle = UIBarStyleBlackTranslucent;
        
        self.prevBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleBordered  target:self action:@selector(prev:)];
        self.nextBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleBordered  target:self action:@selector(next:)];
        
        self.doneBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered  target:self action:@selector(done:)];
        
        NSMutableArray *btnArr = [[NSMutableArray alloc] init];
        [btnArr addObject:self.prevBarBtn];
        [btnArr addObject:self.nextBarBtn];
        
        UIBarButtonItem *spaceBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [btnArr addObject:spaceBarBtn];
        
        spaceBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [btnArr addObject:spaceBarBtn];
        
        [btnArr addObject:self.doneBarBtn];
        
        [self setItems:btnArr animated:YES];
        
        self.textFieldArr = [[NSMutableArray alloc] init];
        self.textFieldIndex = 0;
    }
    return self;
}

- (void)addTextField:(UITextField *)textField {
    
    if (nil == textField || nil == self.textFieldArr) return ;
    
    textField.tag = [self.textFieldArr count];
    [self.textFieldArr addObject:textField];
}

- (IBAction)prev:(id)sender {
    
    if (self.textFieldIndex > 0 && self.textFieldIndex < [self.textFieldArr count] && [self.textFieldArr count] > 0) {
        
        self.textFieldIndex --;
        UITextField *tmpTextField = (UITextField *)[self.textFieldArr objectAtIndex:self.textFieldIndex];
        [self.kbDelegate moveKeyboardFocus:tmpTextField];
    }
    
    [self updateBtnStatus];
}

- (IBAction)next:(id)sender {
    
    if (self.textFieldIndex < [self.textFieldArr count] - 1 && [self.textFieldArr count] > 0) {
        
        self.textFieldIndex ++;
        UITextField *tmpTextField = (UITextField *)[self.textFieldArr objectAtIndex:self.textFieldIndex];
        [self.kbDelegate moveKeyboardFocus:tmpTextField];
    }
    
    [self updateBtnStatus];
}

- (IBAction)done:(id)sender {
    
    NSLog(@"done....");
    
    for (int i = 0; i < [self.textFieldArr count]; i ++) {
        
        UITextField *tmpTextField = (UITextField *)[self.textFieldArr objectAtIndex:i];
        [tmpTextField resignFirstResponder];
        
        NSLog(@"done inside...  tag => %d", tmpTextField.tag);
        
        [self.kbDelegate doneKeyboard];
    }
}

- (void)updateBtnStatus {
    
    if ([self.textFieldArr count] == 0) {
        
        self.prevBarBtn.enabled = NO;
        self.nextBarBtn.enabled = NO;
    } else {
        
        if (self.textFieldIndex == 0) {
            
            self.prevBarBtn.enabled = NO;
            self.nextBarBtn.enabled = YES;
        }
        else if (self.textFieldIndex == [self.textFieldArr count] - 1) {
            
            self.prevBarBtn.enabled = YES;
            self.nextBarBtn.enabled = NO;
        }
        else {
            self.prevBarBtn.enabled = YES;
            self.nextBarBtn.enabled = YES;
        }
    }
}
@end
































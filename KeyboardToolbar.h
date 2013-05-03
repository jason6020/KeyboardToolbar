//
//  KeyboardToolbar.h
//  Jason6020 2013-05-03
//

#import <UIKit/UIKit.h>

@protocol KeyboardToolbarDelegate <NSObject>

- (void)moveKeyboardFocus:(UITextField *)textField;
- (void)doneKeyboard;

@end

@interface KeyboardToolbar : UIToolbar {
    
    UIBarButtonItem *prevBarBtn_;
    UIBarButtonItem *nextBarBtn_;
    
    UIBarButtonItem *doneBarBtn_;
    
    NSMutableArray *textFieldArr_;
}
@property (strong, nonatomic) UIBarButtonItem *prevBarBtn;
@property (strong, nonatomic) UIBarButtonItem *nextBarBtn;

@property (strong, nonatomic) UIBarButtonItem *doneBarBtn;

@property (strong, nonatomic) NSMutableArray *textFieldArr;
@property (assign) NSInteger textFieldIndex;

@property (assign) id<KeyboardToolbarDelegate> kbDelegate;

- (void)addTextField:(UITextField *)textField;

- (IBAction)prev:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;

- (void)updateBtnStatus;
@end

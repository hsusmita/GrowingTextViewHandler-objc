# GrowingTextViewHandler
An NSObject subclass to handle resizing of UITextView as the user types in. The textview resizes as long as the number of lines lies between specified minimum and maximum number of lines. 
These are the public properties which can be set from the client code.
  * animationDuration    : Default 0.7
  * maximumNumberOfLines : Default 3
  * minimumNumberOfLines : Default 1

#Installation

Add following lines in your pod file  

pod 'GrowingTextViewHandler', '~> 1.0.1'

#Usage

First create an instance of GrowingTextViewHandler. It takes an UITextView and its height constraint as arguments. You can specify the maximum and minimum number of lines. Then in the method "textViewDidChange" call the method resizeTextView  

     @interface ViewController ()<UITextViewDelegate>

      @property (weak, nonatomic) IBOutlet UITextView *textView;
      @property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
      @property (strong, nonatomic) GrowingTextViewHandler *handler;

     @end

     @implementation ViewController

      - (void)viewDidLoad {
        [super viewDidLoad];
        self.handler = [[GrowingTextViewHandler alloc]initWithTextView:self.textView withHeightConstraint:self.heightConstraint];
	    [self.handler updateMinimumNumberOfLines:3 andMaximumNumberOfLine:8];
       }

      - (void)textViewDidChange:(UITextView *)textView {
         [self.handler resizeTextViewWithAnimation:YES];
      }
     @end


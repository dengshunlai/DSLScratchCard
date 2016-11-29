# DSLScratchCard
刮刮乐，支持xib

##使用：
```
#import "DSLScratchCard.h"

DSLScratchCard *card = [DSLScratchCard scratchCardWithHiddenImage:[UIImage imageNamed:@"RMB.jpg"]
                                                       coverColor:[UIColor lightGrayColor]
                                                       coverImage:nil];
card.frame = CGRectMake(...);
[self.view addSubview:card];
```

##效果图：
![](https://github.com/dengshunlai/DSLScatchCard/raw/master/snapshot.png)


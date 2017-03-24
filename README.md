# A-ChainAnimation

For Swift version of Simple UIView Chain Animation Block, pelase check out this file: **[A_ChainAnimation.swift](https://gist.github.com/Animaxx/4802f8c7eb66fa92332dd0cd39a4aac8)**


A-ChainAnimation is separated from Project **[A-IOSHelper](https://github.com/Animaxx/A-IOSHelper)**


This project provides two animation methods:

1. **`A-Animation`** - One-time animation
2. **`A-ChainAnimation`** - Multiple combination animations


### Quick Example:

##### Display one-time custom effection animation(Press) by **A-Animation**:

<pre lang="Objective-C">
// Objective-C
[box A_AnimationEffect:A_AnimationEffectType_press Repeat:2.5 Duration:1.0];`
</pre>
<pre lang="Swift">
// Swift
box.a_AnimationEffect(.press, repeat: 2.5, duration: 1.0)`
</pre>

##### Display one-time CALayer animation by **A-Animation**:

<pre lang="Objective-C">
// Objective-C
[box.layer A_AnimationSetScaleX:1.5 AnimtionType:A_AnimationType_easeInOutBounce Duraion:1.0];
</pre>
<pre lang="Swift">
// Swift
box.layer.a_AnimationSetScaleX(1.5, animtionType: .easeInOutBounce, duraion:1.0)
</pre>

##### Display chain animation 

UIView block animation and Effection animation chain mix example
<pre lang="Objective-C">
// Objective-C
[[[[[box addAnimateWithDuration:1.0 aniamtion:^{
    [box setAlpha:0.3];
}] addAnimateWithEffect:A_AnimationEffectType_pulse type:A_AnimationType_easeInBack duration:1.0]
   addAnimateWithDuration:1.0 aniamtion:^{
       [box setAlpha:1.0];
   }] addAnimateWithEffect:A_AnimationEffectType_squeeze type:A_AnimationType_easeOutElastic duration:1.0]
 play];
</pre>
<pre lang="Swift">
// Swift
box.addAnimate(withDuration: 1.0, aniamtion: { 
		box.alpha = 0.3 
	 })
    .addAnimate(with: .pulse, type: .easeInBack, duration: 1.0)
    .addAnimate(withDuration: 1.0, aniamtion: {
        box.alpha = 1.0
    })
    .addAnimate(with: .squeeze, type: .easeOutElastic, duration: 1.0)
    .play()
</pre>



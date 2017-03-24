# A-ChainAnimation

For Swift version of Simple UIView Chain Animation Block, pelase check out this file: **[A_ChainAnimation.swift](https://gist.github.com/Animaxx/4802f8c7eb66fa92332dd0cd39a4aac8)**


A-ChainAnimation is separated from Project **[A-IOSHelper](https://github.com/Animaxx/A-IOSHelper)**


This project provides two animation methods:

1. **`A-Animation`** - One-time animation
2. **`A-ChainAnimation`** - Multiple combination animations


### Quick Example:

##### Display one-time custom effection animation(Press) by **A-Animation**:

<table>
<tr>
<td width="25%">
	<img src="./DemoGifs/quick_demo_1.gif" ></img>
</td>
<td width="75%">
	<pre lang="Objective-C">
	// Objective-C
	[box A_AnimationEffect:A_AnimationEffectType_press Repeat:2.5 Duration:1.0];
	</pre>
	<pre lang="Swift">
	// Swift
	box.a_AnimationEffect(.press, repeat: 2.5, duration: 1.0)
	</pre>
</td>
</tr>
</table>


##### Display one-time CALayer animation by **A-Animation**:

<table>
<tr>
<td width="25%">
	<img src="./DemoGifs/quick_demo_2.gif" ></img>
</td>
<td width="75%">
	<pre lang="Objective-C">
	// Objective-C
	[box.layer A_AnimationSetScaleX:1.5 AnimtionType:A_AnimationType_easeInOutBounce Duraion:1.0];
	</pre>
	<pre lang="Swift">
	// Swift
	box.layer.a_AnimationSetScaleX(1.5, animtionType: .easeInOutBounce, duraion:1.0)
	</pre>
</td>
</tr>
</table>


##### Display chain animation by **A-ChainAnimation**

<table>
<tr>
<td width="25%">
	<img src="./DemoGifs/quick_demo_3.gif" ></img>
</td>
<td width="75%">
	<pre lang="Objective-C">
	// Objective-C
	[[[[[box syncAnimate]
	   setPositionX:20 AnimtionType:A_AnimationType_spring Duraion:2.0]
	  setSize:CGSizeMake(5, 5) AnimtionType:A_AnimationType_bigLongSpring Duraion:3.0].then
	 setCornerRadius:10 AnimtionType:A_AnimationType_noEffect]
	 play];
	</pre>
	<pre lang="Swift">
	// Swift
	box.syncAnimate()
	    .setPositionX(20, animtionType: .spring, duraion: 2.0)
	    .setSize(CGSize(width: 5, height: 5), animtionType: .bigLongSpring , duraion: 3.0)
	    .then
	    .setCornerRadius(10, animtionType: .noEffect)
	    .play()
	</pre>
</td>
</tr>
</table>






---
layout: post
title: "Upgrade the SSD on Your 2015 Dell Chromebook 13"
---

I recently purchased a [Dell Chromebook 13 ](http://www.dell.com/us/p/chromebook-13-7310/pd?ref=PD_OC) for personal use, and am absolutely loving it!

The build quality rivals Macbooks I've used, and the combination of a backlit keyboard, small form factor, 1080p screen, and extremely impressive battery life (10+ hours) makes it an almost "no compromises" laptop!

![Keyboard close-up](http://i.imgur.com/fvU86Al.jpg)
![Back lid close-up](http://i.imgur.com/W0dWlwx.jpg)

Since I was on a budget, I went with the entry-level Celeron processor, 4 GB of RAM model.  Unfortunately, this model also came with an uninspiring 16 GB SSD.  This is more than adequate for the average Chromebook user, as Chrome OS has a very small footprint, relying heavily on Google's cloud services for file storage.  However, I planned to use my new Chromebook for development work, so I knew a storage upgrade would be necessary at some point.

After setting up the laptop, I followed [this](https://www.linux.com/learn/how-easily-install-ubuntu-chromebook-crouton) excellent guide to get Ubuntu installed alongside Chrome OS.  Things were working great up until I tried syncing my Dropbox folder, and realized that I was **very** quickly going to use up that 16 GB of on-board storage.

I struggled along for a few weeks, selectively syncing Dropbox folders and holding off on critical Ubuntu updates until I finally caved and picked up a [MyDigitalSSD 128 GB SSD](http://www.amazon.com/MyDigitalSSD-128GB-120GB-Super-Drive/dp/B00LNF1RVM) off of Amazon.  When looking for your own SSD to use, you'll want to be sure of a few things:

* It utilizes the SATA III interface
* It is a 42mm form factor
* Don't be afraid to spring for more capacity now (it's less hassle than upgrading again)

Before removing any screws on the case, you'll want to be sure to create a Chrome OS recovery drive.  This can be done by downloading the [Chromebook Recovery Utility](https://chrome.google.com/webstore/detail/chromebook-recovery-utili/jndclpdbaamdhonoechobihbbiimdgai) from the Chrome Web Store, running the app, and following the on-screen instructions.

Once the recovery drive is built, go ahead and eject the flash drive.  Then, shut down the Chromebook completely and unplug any other peripherals/power cables.

Next, flip the Chromebook over onto its cover with the metal bottom of the case facing upwards.  You should see 11 screws holding the bottom cover on.  Go ahead and remove all 11, taking care to not drop or lose them.  If you have cats, now might be a good time to put a wall or door between you and them...

![Identifying the screws](http://i.imgur.com/4hEghZM.jpg)

Once you have all the screws removed, take a non-metal flat object (in this case I used a plastic car trim tool) and stick it in the gap between the screen hinge and the metal bottom plate.

![Opening the case](http://i.imgur.com/yBNIfEE.jpg)

NOTE: Be very careful while sticking anything inside the computer.  It is possible to scratch/scuff/damage critical components on the motherboard if you're not careful!

It shouldn't take much force to pry the bottom away from the rest of the body, but you will need to slide the tool back and forth in the gap of the hinge while prying downwards until the retaining clips let loose.

![Opening the case cont.](http://i.imgur.com/8LkSH8S.jpg)

At this point, you should be able to use your hands and continue pulling around the edge until the bottom plate releases releases completely.

![Case cracked open](http://i.imgur.com/IDZhAtt.jpg)

Set the bottom aside and take note of the internals of your Chromebook:

![Examining the internals](http://i.imgur.com/TDwETFC.jpg)

The SSD is held in with a single screw and a small piece of black adhesive tape.  Lightly separate the adhesive tape from the edge of the factory SSD, and remove the single screw.

![Removing the tape](http://i.imgur.com/b8hVHqH.jpg)
![Removing the screw](http://i.imgur.com/cMfWdWa.jpg)

At this point, the SSD should lift up and out.  Now take your new SSD and reverse the procedure, taking care not to jam anything in.  It shouldn't require much if any pressure to seat the new SSD (making sure the adhesive tape is out of the way).

Replace the screw and tape, reattach the bottom cover, and carefully thread the 11 screws back in.

NOTE: Be very gentle when re-inserting the screws.  They shouldn't take much force to turn, so be cautious of cross-threading any of them.  If you encounter resistance, simply back the screw out a few turns and try again.

Once you've accounted for all 11 screws, start up your Chromebook and you'll be greeted with this scary looking screen:

![Chrome OS recovery screen](http://i.imgur.com/eUYoqfp.jpg)

Don't be alarmed, simply insert the recovery USB you made earlier and wait for the recovery process to finish.

Once it's done, your Chromebook 13 is now upgraded and ready to roll!  Congratulations!
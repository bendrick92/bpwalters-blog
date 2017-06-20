---
layout: post
title: "Raspberry Pi-Powered Internet Cat Feeder"
image: http://i.imgur.com/YS9YQDL.jpg
---

A few months ago, I came across a blog post from [David Bryan](http://drstrangelove.net/) on building a [Raspberry Pi-powered Cat Feeder](http://drstrangelove.net/2013/12/raspberry-pi-power-cat-feeder-updates/).  He does a great job highlighting the supplies, tools, and technical expertise needed for the project so I thought I'd give it a try myself.

In looking over his plans, I decided there were a few additional features I'd add:

* **Remotely operatable** - I wanted to be able to activate the feeder, on command, while away from my home network
* **Customizable schedule** - The ability to set a few planned meals in advance would be great if my girlfriend and were planning a day trip out of town
* **Camera integration** - After all, if I was going to be operating the feeder remotely, I'd need some confirmation that the food actually dispensed
* **Custom enclosure** - Our younger cat has a reputation for being a bit of an ass, so some sort of case/container would be absolutely necessary to keep him from tipping it all over

#### Parts List

The list of the parts I used loosely followed David's original documentation, but for reference here's a general list of the supplies I used:

* [Zevro Compact Dry Food Dispenser](https://www.amazon.com/gp/product/B009Q8PZMK/ref=oh_aui_detailpage_o06_s00?ie=UTF8&psc=1)
* [Raspberry Pi V2 Camera Module](https://www.amazon.com/gp/product/B00E1GGE40/ref=oh_aui_detailpage_o02_s00?ie=UTF8&psc=1)
* [Adafruit 24" Flex Cable for Raspberry Pi Camera Module](https://www.amazon.com/gp/product/B00M4DAQH8/ref=oh_aui_detailpage_o02_s01?ie=UTF8&psc=1)
* [Adafruit Breadboard Power Supply Kit](https://www.adafruit.com/products/184)
* [Adafruit 1/4 Perma-Proto Breadboard](https://www.adafruit.com/products/1608)
* [FeeTech Continuous Rotation Servo](https://www.adafruit.com/products/154)

#### Putting It All Together (Part I): Getting The Servo Mounted

Since the cereal dispenser David utilized was no longer available, I decided to go with the aforementioned Zevro dispenser instead.  The main reasons I chose this dispenser were the large reservoir, flexible silicone paddles, and plastic construction.  The use of flexible paddles on the dispenser wheel meant there was little chance for food to get jammed, while the plastic construction meant it would be easy to modify to suit my needs.

When the dispenser arrived from Amazon, I immediately noticed a problem: the dispenser handle was mounted on the front - not ideal, and it meant there wasn't anywhere to mount the servo.  I ended up modifying the dispenser and flipped the reservoir top 180 degrees.  This required removing a few screws and minimal modification (a Dremel is a lifesaver here).

Once I had relocated the handle, I used some extra perspex plastic I had laying around from my [obdPi](http://blog.bpwalters.com/raspberry-pi-obd-ii-carputer/) project to build a mount for the servo.  It would need to support the servo vertically, but also provide enough horizontal force to keep the motor from falling out of the arm.

![Mounting the servo](http://i.imgur.com/ceYjlPA.jpg)

![Mounting the servo cont.](http://i.imgur.com/CehKn7C.jpg)

![Mounting the servo cont.](http://i.imgur.com/UAkS9cs.jpg)

With that done, I got initial impressions from the primary stakeholders:

![Testing the setup](http://i.imgur.com/i4HCU0i.jpg)

The excitement was palpable.  Anyways, see the masking tape holding the lid onto the reservoir?  Yeah that became immediately necessary after the younger one discovered how top heavy the dispenser was.  A rethink was in order...

#### Putting It All Together (Part II): The Hamper

After a few beers and a stroll down the storage container aisle at Target, I came across a nice looking plastic clothes hamper on sale.  With it's mesh design (perfect for mounting the dispenser) and fancy looks, I figured it would be as good a place as any to start.

A few bolts were used to hold the dispenser in place:

![Mounting the reservoir](http://i.imgur.com/6cTeZSU.jpg)

And some strategically positioned PVC would handle the duty of catching, dispensing, and dividing the food into two neat piles:

![The PVC in use](http://i.imgur.com/6uZIC0e.jpg)

This design got a more enthusiastic response...

![Finished attempt #2](http://i.imgur.com/YS9YQDL.jpg)

...but wasn't without its flaws.

The food would dispense just fine, but the sharp edges of the PVC joining together was catching a large amounts of food.  The cats remedied this issue by discovering they could fit nearly their entire arms up the pipes to grab the trapped food, but I knew the design would need yet another rethink.

#### Putting It All Together (Part III): Break Out the Power Tools

After several days of strong contemplation and many more beers, I decided it would be most effective to build an entirely custom enclosure for the reservoir.

With temperatures here in the Midwest rapidly approaching freezing, I quickly drew up the plans and got to work!

![The plan of attack for attempt #3](http://i.imgur.com/pO7DSP5.jpg)

Several trips to Home Depot later for tools I didn't know I'd ever need...

![Right angle drill bits = lifesaver](http://i.imgur.com/nG5DfwR.jpg)

...and I was beginning to make some real progress:

![The wood enclosure coming together](http://i.imgur.com/ZbfAq4i.jpg)

I decided to do away with the plastic base of the Zevro and mount the servo directly to the frame of the enclosure.  The bonus of this was that the entire reservoir/servo would now lift out for easy cleaning!

![Mounting the custom servo bracket](http://i.imgur.com/lQXxQRM.jpg)

At this point, I was ready to mount the Raspberry Pi's camera to the enclosure.  It would need to be located centrally and far enough back that it would be able to capture evidence of the food having dispensed.  In the end, I drilled a hole in the front side of the enclosure and chiseled out a cubby for the lens to peek through:

![Mounting the camera](http://i.imgur.com/oe3kvry.jpg)

Here's an example of the camera in action:

![Camera working!](http://i.imgur.com/w9zHGKo.jpg)

With that done, I assembled the rest of the container and installed the Pi, servo, and temporary breadboard wiring to test it out:

![The reservoir installed](http://i.imgur.com/6K9ynKu.jpg)

#### Final Touches

For testing, I used a breadboard and jumper wires for temporary connections:

![Breadboard setup for the servo](http://i.imgur.com/a0w2Dp8.jpg)

However, after proving the design was functional, I followed David's example and utilized a [Adafruit 1/4 Perma-Proto Breadboard](https://www.adafruit.com/products/1608) to wire up a more permanent solution:

![Final wiring](http://i.imgur.com/7oWt5ia.jpg)

![Final wiring cont.](http://i.imgur.com/XOtSC5m.jpg)

*NOTE: The [Adafruit Breadboard Power Supply Kit](https://www.adafruit.com/products/184) PCB utilizes standard breadboard spacing, but the 1/4 Perma-Proto board's bordering voltage and ground channels do not line up.  I ended up utilzing the PSU's inner soldering points (on either side of the potentiometer in the images above).*

Installed everything in the back of the enclosure...

![Everything installed](http://i.imgur.com/Iw8Gfhq.jpg)

...and tested it out!

<iframe width="560" height="500" src="https://www.youtube.com/embed/WC-2G3SU3-Q" frameborder="0" allowfullscreen></iframe>

#### The Code

The Python scripts I'm utilizing are available on Github [here](https://github.com/bendrick92/catpi), but for simplicity's sake, here's a high-level overview of the functionality:

The `main.py` script is set to be run on boot using `systemd` (see my [obdPi documentation](http://bendrick92.github.io/obdPi/setup/) for details on setting up a daemon script in Raspbian).  This script runs on a delayed cycle of ~10 minutes.  Each loop, the script utilizes the Dropbox Python API to download, parse, and evaluate the contents of a JSON file (`schedule.json`).

Within this JSON file, I have the ability to define any number of separate events, each with the following properties:

* `event_time`
* `feed_amount`
* `has_run`

If the code determines there is an unevaluated event (i.e. the `event_time` has passed and `has_run = false`), it will utilize the defined `feed_amount` to dispense the appropriate amount of food.

*NOTE: Due to the design of the dispenser, the exact amount of food dispensed can vary, but is relatively consistent.*

Once all events have been evaluated, updated (i.e. `has_run = true`), and the appropriate amount of food dispensed, the code then executes the command to take a series of pictures using the camera and store them locally on the Pi.

Finally, the code utilizes the Dropbox API to synchronize the Dropbox folder with any new images as well as update the `schedule.json` file.

![Contents of the Dropbox image folder](http://i.imgur.com/wHUGdSz.png)

Currently I am updating the JSON file manually, but am working on a Backbone.js administration page to make file management/updating much easier.

#### Closing Thoughts

There's tons of room for improvement, but overall I'm very happy with the results.

David's [blog post](http://drstrangelove.net/2013/12/raspberry-pi-power-cat-feeder-updates/) was invaluable in providing the motivation/inspiration for this project, so be sure to check him out if you haven't already.

Thanks for reading, and drop a comment below if you have any questions/want more information on this project!  I'll try to keep it updated as I make changes/improvements to the catPi!

![Just making sure it's working...](http://i.imgur.com/mgi5P1J.jpg)
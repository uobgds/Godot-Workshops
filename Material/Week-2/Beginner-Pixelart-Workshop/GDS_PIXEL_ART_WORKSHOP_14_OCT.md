**UoB Game Development Society**  
**Tutorial Beginner Pixel Art (14 Oct 2026\)**

Structure:

1. Intro and instructor’s introduction  
2. Learning about the tool (Piskel)  
   1. Making basic shapes and colouring  
   2. Making a simple animation  
   3. Exporting sprite  
3. Making a platforming character (using a base)  
   1. Importing a base spritesheet  
   2. Animating a Walk Cycle

## INTRO

Welcome to the Pixel Art workshop, today we are going to learn how to make assets for our game.  
Pixel art is a very popular medium for game art because it has several big advantages:

1. It is very accessible and does not require advanced tools  
2. It is simple and easy to learn, and scales well with your skill  
3. It is easy to integrate into games

First, you can literally make pixel art with *pen and* *paper*. It’s what devs did back when games development was still at its early stage. Grab a grid notebook and pixel away\!

![Image 1][image1]

Second, a coherent image can be made using a minimal amount of pixels and colours, which is pretty easy to do. For example, the original Megaman sprite is only 16 pixels tall with 5 colours and can be easily replicated with minimal skill..

![Image 2][image2]  
But with more advanced techniques, shading, etc.. and bigger canvas, the MM8 one (40 pixels tall with much more colours) looks pretty dang good doesn’t it?

Lastly, pixel art file size is very SMALL. It’s perfect for small games that will run on any hardware using any game engine.

Now a little bit about myself, my name is Irfan Satria and my alias is TheGuudKnight. I just finished my 1 year MSc Electronic and Computer Engineering here at UoB. I've known the people here in GDS since last year and we worked on a game jam together. I’ve been dabbling in digital illustration and pixel art for about 2 years now since 2024\. I started with pixel art because of its simplicity, and then worked my way through different art styles in the process of learning. I also joined the UoB Artsoc and it pretty much helped me improve as an artist.

Here are some of my art and here are the games that I’ve had a hand on creating, so I feel my qualifications are just enough to teach you about the basics of pixel art.

Let’s start with the basics, there are probably only two things in mind if you’re going to start a project,

***The first one is sprite size \-\> your game’s target style***

In retro games/ pixel art games, dimension plays a very big role because it is based on how many pixels the hardware can render every frame. This is called a “native” resolution. The more pixels there are, the more detailed your piece will be.

![Image 3][image3]  
From   
PIXEL LOGIC by Michael Azzi

Obviously nowadays we are not constrained by small resolutions as HD has become the standard, and with game engines like Godot you are able to set the resolution of the game yourself. Pixel art has become more of a stylistic choice nowadays rather than necessity, unless you are using something like Pico-8 or developing for an old console.

My game Fish Greaves, was built for the original gameboy hardware from 1989\. I had to work with the hard limits of the gameboy to actually make the game, such as the cramped 160x144 native resolution and a tiny 4-colour palette. The player character Mr Fishy is a 32x32 sprite, which looks huge on the gameboy’s screen.

![Image 4][image4] ![Image 5][image5]

Even if you’re developing a modern game, if you’re intentionally going for a retro aesthetic it’s very important to know what console “style” you’re emulating.

For example, games like Mina the Hollower target the Gameboy Colour style, therefore it deliberately uses a limited amount of pixels, and limited colours. In fact, Mina the Hollower uses a similar native resolution to a gameboy colour (160x144), but modified to 16:9 (256 pixels wide by 144 pixels tall). So in a way, it is a GBC-styled modern game. Mina herself is only 16x16 pixels.

![Image 6][image6]

![Image 7][image7]

More “detailed” pixel art games like Sonic Mania has the resolution 424x240, which is a popular 16:9 “approximation” of 240p graphics consoles style in the 16 bit era, such as the Sega Genesis (320x240) and Super Nintendo (256x240) (and by extension the Saturn and PS1). 	Sonic’s sprite in these games is 39 pixels tall.

![Image 8][image8]

Another example is “Goodboy Galaxy”, a modern game from 2023 designed for the Gameboy Advance, with a native resolution of 240x160 pixels. The player character is 32 pixels tall.

![Image 9][image9]

For beginners you don’t really have to agonise over this, but if you’re going for a style in mind, determining the resolution your game will be in and the sprite sizes ***is very*** **important** to have a consistent art style. 

***And then the second one is the tool.***

I’ve mentioned before that pixel art can be done in many programs, even MS Paint if you’d like. While there is hardly a wrong choice in which tool to pick for doing pixel art there are dedicated pixel art editors that make our life much easier.

Open Source

- Piskel  
- LibreSprite (a fork of old version of Aseprite)  
- Aseprite (compile yourself, paid precompiled version available)

Freemium

- Dotpict  
- ReSprite

Etc.

A huge advantage of dedicated pixel art editors that saves you the time and headache is exporting game-ready assets.

For today’s example we’ll be using the simplest one which is Piskel, you can use the online version here:  
[https\://www\.piskelapp.com/kids/](https://www.piskelapp.com/kids/)

Note that we use the “kids” version as it has all the features as the normal version but with no ads\!

## LEARNING ABOUT THE TOOL

1. ### SIMPLE BALL

   

Piskel is a completely free tool for creating pixel art that has just enough features for a beginner and suitable to just “trying out” pixel art before moving to more advanced software like Aseprite.

We’ll learn more about the tool as we go but there are some settings that I recommend you to apply first.

First, create a new sprite (Or resize your sprite) to become a 32x32 image.

Go to Settings\>misc and select the lightest background (left) and 1.00 layer opacity.  
This allows better visibility and doesn’t obscure the layer underneath when we add new layers.

![Image 10][image10]

Next, go to Settings\>Grid and enable it using these settings.  
Using a grid makes a difference when you’re doing detailed work\! You can adjust the grid spacing as well.

![Image 11][image11]

Now that our settings are set, your work environment should look like this.

![Image 12][image12]

Let’s walk through the tools with learning by doing. Let’s draw a very simple, shaded ball.

First, we want to make a circle using the circle tool (C) and holding shift to make a perfect circle.

![Image 13][image13]

![Image 14][image14]

It’s okay if the circle is not in the middle of the workspace, you can center it by clicking the auto align function in the transform menu on the right.

![Image 15][image15]

We now have a Line Art of a circle. 

Line art is the most basic form of pixel art, and everything later will come together with the shape of our line.

Now give the circle a basic colour.

Go to the primary colour selection and select any saturated colour (e.g. red, \#ff0000). (tip: go to the top right of the colour picker)

![Image 16][image16]

Colour the circle with the paint bucket tool.

![Image 17][image17]

We now have a red 2-dimensional circle.

The next part is rendering it to make it three dimensional.  
Let’s decide that a light source is coming from the top right of the image. Therefore the colour will gradually go from light to dark starting from the top right to the bottom left.

Click on the New Layer on the layers menu and name it shadows.  
![Image 18][image18]

Change the colour into a deeper shade of your saturated colour (tip: stick to the right of the colour picker).. 

![Image 19][image19]

Using the pen tool and eraser tool, work out the shadows of the ball by imagining a rounded shape.  
As we can see on the preview on the top right corner, it’s starting to have a 3d shape from afar.

![Image 20][image20]

Now add a new layer and call it light.

Similarly as we did previously, still imagining a rounded shape, we will now paint the top right of the circle with a lighter colour to simulate light striking the ball. Use a less saturated bright colour of your original shade (tip: go to the middle top).

![Image 21][image21]

![Image 22][image22]

Now we have a shaded ball with a soft light.

Add a white highlight if you wish\!

![Image 23][image23]

You can also colour in your lineart to sell the 3D immersion. Use a variety of saturated colours (the right edge of the colour picker) that’s darker than your base colour. Or just stick with black if you’re going for a cartoon black lines style. It’s up to your style\!

![Image 24][image24]

Save the work we did so far by clicking the save menu on the right edge of the screen.

![Image 25][image25]

2. SIMPLE ANIMATION

Now we are going to simulate a bouncy ball using simple animations.

To simplify the next steps, go to the Layers menu and merge below all of our layers until we end up with one layer.

![Image 26][image26]  
![Image 27][image27]

Next, duplicate our first frame until we get 5 identical ones.

![Image 28][image28]

On the first frame, click the Move tool or press ‘M’ and move the ball down until it touches the bottom.  
On the second frame, move it to the center of the frame.  
On the third frame, move it to the top but leave a one pixel margin,  
On the fourth frame, move it to the center but push it up one pixel.  
On the fifth frame, move it just one pixel above the bottom of the frame.

![Image 29][image29]

The FPS slider on the right determines the speed of the frame by frame animation. Change it to a specific value e.g. 8 FPS.

Now go to the first frame, and pick the rectangle selection tool (S)

![Image 30][image30]

Select about the top half like this:

![Image 31][image31]

And while holding SHIFT, drag the selection down to squish the ball

![Image 32][image32]

And we’ll end up with an oval shape.

![Image 33][image33]

In the 2nd frame, we will take the left and right side of the ball and squish it inward horizontally.

![Image 34][image34]

Like so.

![Image 35][image35]

Continue Selecting and moving the parts of the ball until we get a smooth 5 frame animation of a bouncing ball with squash and stretch. 

Frame 2 should just be squished horizontally slightly  
Frame 3 should have a bigger squish  
Frame 4 should be the same as Frame 2  
Frame 5 should be our original unmodified ball.

![Image 36][image36]

We now have a complete sprite animation\! Take a second to admire your work and don’t forget to save it.

Next, you can export this animation as a GIF Animation, or as a spritesheet to be used in Godot.

![Image 37][image37]

It really depends on how you want to export your sprite sheet as Godot (should) allows reading of sprite sheets in any row or column size. But let's keep it simple and export as a 5 column x 1 row sheet.

![Image 38][image38]

And this is what we ended up with. This bouncy ball can be used as a simple character with a Jump animation if you’d like\!

![Image 39][image39]

Finished Project:  
[https\://drive.google.com/drive/folders/18ah28-4qH4YFG\_7IX9\_ESEGxnZ8zxrAC?usp=sharing](https://drive.google.com/drive/folders/18ah28-4qH4YFG_7IX9_ESEGxnZ8zxrAC?usp=sharing)

## CREATING A PLATFORMER CHARACTER

We now understand how to work with a 32 x 32 workspace, have our way around the tools, creating and exporting a simple animation. Now we’ll try to make a game ready platformer character.

To save time, we can modify an existing asset into our own. There are tons of free assets available, but we are especially interested in ones that state this:

“These assets are released under a Creative Commons Zero (CC0) license. You can distribute, remix, adapt, and build upon the material in any medium or format, even for commercial purposes. “

It is important to check with the author for their attribution and credit system. Gotta stay ethical\!

One such asset pack we can modify is this one:

[https\://pixelfrog-assets.itch.io/pixel-adventure-1](https://pixelfrog-assets.itch.io/pixel-adventure-1)

Which is perfect because the characters are 32x32, the same as our previous example\!  
Download it and extract.

1. Importing a sprite sheet

In an empty Piskel workspace, select import, and import from picture

![Image 40][image40]

![Image 41][image41]

Look for “Pink Man” inside the Main Characters folder in the Pixel Adventure 1 asset pack.  
Choose the Run (32x32) png file.

![Image 42][image42]

Now import this as a sprite sheet, change the frame size to 32 x 32\.

![Image 43][image43]

Now we’ve imported the character’s walk cycle as a sprite sheet\!

![Image 44][image44]

As we can see, the walk cycle is 12 Frames. To save time, we can strategically remove the in-between frames to end up with just a 5 frame walk cycle.

![Image 45][image45]

We can leave the following frames to make a sufficient walk cycle:  
2, 5, 8, 9, 10

![Image 46][image46]

Download the modified file here:  
[https\://drive.google.com/drive/folders/18ah28-4qH4YFG\_7IX9\_ESEGxnZ8zxrAC?usp=sharing](https://drive.google.com/drive/folders/18ah28-4qH4YFG_7IX9_ESEGxnZ8zxrAC?usp=sharing)

It’s not gonna be the smoothest walk cycle, but for the sake of simplicity of this workshop and your upcoming game jam, we can use it. Feel free to modify the original 12 frame animation if you want your stuff to look smooth\!

2. Modifying the sprite to animate your own character’s walk cycle

It really depends on what your character will be and the design of the character, but let’s say I want to make a woodland creature inspired by the Minish race from the Legend of Zelda.

![Image 47][image47] 

I painted on top of the first frame first, preserving the original lineart and shape while adding my own elements.

![Image 48][image48]

With the rectangle tool selected, I can select over the whole area and press CTRL+C to copy

![Image 49][image49]

Move to Frame 2, create a New layer, and paste (CTRL+V) your character into the second frame.

![Image 50][image50]

Move the character in Frame 2 to the bottom, erase the arms and legs of the new character and erase the head of the old character.

We will paint new arms and legs to match up with the reference.

![Image 51][image51]

![Image 52][image52]

Do the same with frame 3, 4, and 5\!   
Take your time in figuring out things, as this is where the real creative process happens. 🙂

![Image 53][image53]

![Image 54][image54]

Now export your newly crafted spritesheet and admire your work\!

That wraps up this tutorial session, every .piskel and spritesheet file made is on this drive link:

[https\://drive.google.com/drive/folders/18ah28-4qH4YFG\_7IX9\_ESEGxnZ8zxrAC?usp=drive\_link](https://drive.google.com/drive/folders/18ah28-4qH4YFG_7IX9_ESEGxnZ8zxrAC?usp=drive_link)

\---

Some cool resources if you want to get serious about pixel art:

What Size To Make Pixel Art: [https\://youtu.be/AXb-VBZTKDA?si=b4ybXTUWRriRHQt6](https://youtu.be/AXb-VBZTKDA?si=b4ybXTUWRriRHQt6) 

3 Pixel Art Technique / Common Mistakes: [https\://youtu.be/gW1G\_FLsuEs?si=RWdcRN88DvJRuUi0](https://youtu.be/gW1G_FLsuEs?si=RWdcRN88DvJRuUi0) 

Basic Anti-Aliasing for Beginner: [https\://youtu.be/UN-m3o9V7kk?si=Uxf84XxhoxBSwUSJ](https://youtu.be/UN-m3o9V7kk?si=Uxf84XxhoxBSwUSJ)

Study various games’ pixel art:  
[https\://www\.spriters-resource.com/](https://www.spriters-resource.com/)

<!-- Image references: place the exported images in the images/ folder. -->
[image1]: images/image19.png
[image2]: images/image16.png
[image3]: images/image27.png
[image4]: images/image6.png
[image5]: images/image34.png
[image6]: images/image35.png
[image7]: images/image13.png
[image8]: images/image45.png
[image9]: images/image7.png
[image10]: images/image30.png
[image11]: images/image5.png
[image12]: images/image11.png
[image13]: images/image3.png
[image14]: images/image28.png
[image15]: images/image8.png
[image16]: images/image1.png
[image17]: images/image52.png
[image18]: images/image41.png
[image19]: images/image14.png
[image20]: images/image37.png
[image21]: images/image43.png
[image22]: images/image49.png
[image23]: images/image33.png
[image24]: images/image44.png
[image25]: images/image39.png
[image26]: images/image17.png
[image27]: images/image24.png
[image28]: images/image10.png
[image29]: images/image18.png
[image30]: images/image22.png
[image31]: images/image50.png
[image32]: images/image53.png
[image33]: images/image29.png
[image34]: images/image12.png
[image35]: images/image25.png
[image36]: images/image25.png
[image37]: images/image31.png
[image38]: images/image42.png
[image39]: images/image47.png
[image40]: images/image9.png
[image41]: images/image20.png
[image42]: images/image38.png
[image43]: images/image51.png
[image44]: images/image4.png
[image45]: images/image48.png
[image46]: images/image40.png
[image47]: images/image15.png
[image48]: images/image46.png
[image49]: images/image26.png
[image50]: images/image21.png
[image51]: images/image2.png
[image52]: images/image36.png
[image53]: images/image23.png
[image54]: images/image32.png

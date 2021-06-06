# Snake
The traditional snake game with some customizations. Created using Assembly Language

The following functionalities have been implemented:
1. A snake that automatically moves left, right, up and down on the screen.
2. Initial size of snake is 20 characters with head of the snake represented by a different
character as compared to its body.
3. The arrow keys are used to determine the direction of snake.
4. If the snake’s head touches the border of screen the players loses one life. Initially the
player has three lives. After losing all three lives the game is over.
5. If the snake eats a fruit the size of snake is increased by four characters.
6. If the snake does not eat the fruit, the fruit remains on the screen.
7. After the fruit is eaten by the snake, the next fruit immediately appears on a random
location on the screen.
8. Maximum size of snake can be 240 characters.
9. If the snake does not reach the maximum size in 4 minutes one life of player will end.
10. If the snake reaches the maximum size in 4 minutes the player earns some points and
moves to the next level
11. After every 20 seconds the speed of snake is twice as the previous speed.
12. If the snake touches itself one life of player will end.
13. There are 3 levels which are shown in the screenshots of the running application below
14. There is a dangerous fruit (the one in black that is blinking). If the snake eats this fruit, the player loses some points 


## How to run the code
To run the asm file, you need Dosbox, nasm and AFD installed. 

Open Dosbox and navigate to the folder where you have nasm, afd and the snake.asm file.
Use the following command to create the output file

`nasm snake.asm -o snake.com`

Then use the following command to run the application

`snake.com`



## The running application 

Below is the default home page of the game. The UI is kept simple but colourful to keep the user's interest peaked. 

On the top right, we have shown the total lives and the current lives of the user. 
On the top left, we show the score and level. In the center, we show the size of the snake and when the game begins, a timer is also shown here. 

![Home page](https://github.com/fatimahasan125/Snake/blob/main/snake_screenshots/1.png?raw=true)


Here we have the first level of the game. There are no hurdles in this level because it is the easiest one. The player needs to eat fruit to get to the size 240 after which the second level appears. 


![Level1](https://github.com/fatimahasan125/Snake/blob/main/snake_screenshots/2.png?raw=true)


Level 2 of the game is shown below:

![Level2](https://github.com/fatimahasan125/Snake/blob/main/snake_screenshots/3.png?raw=true)

The last level is shown below:

![Level3](https://github.com/fatimahasan125/Snake/blob/main/snake_screenshots/4.png?raw=true)

If you complete the last level, then you will have won the game. If you lose all the lives in between, you lose. 

Hope you enjoy playing!

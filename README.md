# Food Rush
#### Video Demo:  <URL [HERE](https://youtu.be/4D1LGGZgJEU)>
#### Description:
This project is going to be a small arcade game using lua as a coding language as per the project requirements. The goal of the game is to score as many points as possible, with every 20 seconds the game will get faster and harder to keep up with. There are three different food types that fall from the sky, each with their own speeds, point values, and spawn rates. I added music and sound effects and structured the code based on what I learned from Harvards CD50 programming course.

To begin, we can start with the main.lua file. This is the file I used to initialize a lot of the important global variables. Things such as the window screen size and the virtual screen size. I imported push.lua and class.lua from CD50 to help me with this project and used it liberally. In love.load I set up random seeds, music, state machines and input tables. One thing of note in this portion are the spawner logic. Separating burger, sushi, and cake spawners (and later a lot of other things) in the main.lua file was necessary since they needed to be global variables that needed to be set after math.randomseed(os.time()) and initialized everytime the game began. Every other "object specific" logic will be implemented into their own .lua files.

Next we can go to the StateMachine.lua. It mostly handles the logic of swapping states and updating every state. BaseState.lua is a "parent" class. It outlines a commonality between "states" that they all inherent from the BaseState.lua. It includes 


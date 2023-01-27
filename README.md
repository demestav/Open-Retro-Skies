# Open Retro Skies

A very small game inspired by 1980's top-down arcade shooters. It served as a learning project to familiarize with Godot Game Engine.

By design, the game is extremely basic and has very few features. This way, the chances of me finishing the game are higher.

## Goals

- Single player game
- Basic 4 way movement
- Single weapon with no upgrades
- Single type of enemy
- One level
- The level contains waves of enemies
- The player has lives
- Keep score
- Less than 5 sprites
- Enemy will share the same sprite as the player, maybe different color
- Basic sound effects


## Non-goals

- No high scores
- No power ups
- No main menu
- No music

## Description

### Player

In this game, the player is controlled using keyboard inputs and can move in four directions: up, down, left, and right. The player's movement internally is managed with a state machine. This allows for a clear and organized representation of the player's possible states and the actions that can transition between them. This approach to player control allows for a more maintainable and extensible codebase, as opposed to using nested "if" statements to handle logic. I found several resources on how to implement a state machine in Godot, with varying levels of complexity. I decided to go with a simple approach, which is to use a single script to handle all the player's states, since the game is very simple. My implementation is mostly based on

### Enemies

In the games, enemies come in waves. They don't move individually, rather they all follow a pre-defined path, which is different for each wave. Godot has a very convenient mechanism to handle this, which is the Path2D node. It allows you to define a path using a series of points, and then you can use the PathFollow2D node to follow that path. The PathFollow2D node has a "unit offset" property, which is a value between 0 and 1, and it represents the position of the node along the path. By updating this value, the enemy will move along the path. Each enemy has it's own PathFollow2D node, so they can follow the path independently.


### Waves

A wave has three parameters that set the difficulty of the wave. The first parameter is the number of enemies in the wave. The second parameter is the speed of the enemies. The third parameter is the amount of bullets each enemy can fire. The main level scene controls ths spawning of waves, which in turn controls the spawning of enemies. The wave has a flag "finished", which is set to true when the wave is over. The main level scene checks this flag to determine when to spawn the next wave.

### Projectiles

Projectiles are yet another scene that is instantiated by an airplane when it fires. The rotation and direction of the projectile is defined by the direction the airplane is facing. It moves at a constant speed and is destroyed when it collides with the player or enemy airplanes or it goes off screen. A projectile fired by the player can only collide with an enemy airplane. A projectile fired by an enemy airplane can only collide with the player airplane. This is done to avoid friendly fire. My implementation is based on


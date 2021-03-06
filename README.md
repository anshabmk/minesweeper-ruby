# Minesweeper-Ruby

A Ruby implementation of the minesweeper game.

***

### Welcome screen

```
    Welcome to Minesweeper.


    Provide your guess tile by giving x,y coordinates of the tile.
    For example, to open first row first column give input as 0,0.

    Press Ctrl + C or type "exit" to exit from game anytime.
    Press "Enter" key to start the game...

```

### Game play screens

#### Start game

```
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
Enter your guess (x, y): 0,1
```

#### After opening tile 0,1

```
-  4  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -  -
Enter your guess (x, y):
```
## Local Setup

### Pre-requesities

### Ruby

Download & Install ruby from [here](https://www.ruby-lang.org/en/downloads/) for your OS.

### 1. Clone the repo and move inside the root folder

`$ git clone git@github.com:anshabmk/minesweeper-ruby.git`

`$cd minesweeper-cli-game`

### 2. Install dependencies

`$ bundle install`

### 3. Run the game

`$ ./bin/run_game`

Follow the instructions given in the screen to play the game.

## Running Tests

`$ rake test`

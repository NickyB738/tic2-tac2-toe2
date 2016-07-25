# Tic²Tac²Toe²

This is a game I've put together using Love2D. It's a pretty simple concept but it leads to very interesting gameplay that requires thought and stategy.

I did not come up with the game (a friend showed it to me), but I really wanted to implement a version of it on the computer so that it was easier and we didn't have to remember what player went last and in what board ect.

I hope you enjoy this game as much as I enjoyed making (and playing) it :D

### The Rules

The game board is a tic tac toe board made up of 9 smaller tic tac toe boards. The objective of the game is to win three big boards in a row that form a line just like standard tic tac toe.

Each small board follows the rules of a standard game of tic tac toe. If you win a small board, it becomes your piece on the big board, and the objective is to get three in a row. Once a board is won it can no longer be played on.

The first player gets to place their piece on any section of any of the little boards. The catch is that: for every move, the next player has to play their piece on the big board corresponding to the section that the previous player played on their little board. For example, if the first player plays a piece in the top right corner of a board on their first turn, the next player has to play *on the top right board*. Then for example if that player plays in the bottom center (of the top right board), the next player has to play *on the bottom center board*. This is indicated in the game by a square that surrounds the board(s) that the next player is allowed to play.

Now there are a few edge cases. For exmaple, if you try to send someone into a board that has already been won, they get to choose wherever they would like to go. For example, if the center board has already been won (by either player one or two) and player one plays in the center section of their board, player two may play in whatever board they would like, since the center board has been won already and may not be played in.

Another suttle detail is what happens when a small board is tied. If a small board is tied, it counts towards BOTH players pieces in the big board, not neither. This also means that there is a very rare case that if both players have two pieces in a row that would be completed into three in a row by a single board and that board is tied, BOTH players would technically win and the game would end there as a draw. (I'm not 100% sure that's correct but that was what made the most sence to me.)

I think that's about it, if I forgot anything please let me know! I'm also aware that the graphics are not very nice, but hey it works :P

## Running the Program - Love2D

This program is written in Lua using the Love2D framework. It's absolutely excellent and you should check it out here: https://love2d.org/

To run the game, download Love2D (I wrote it using 0.10.1, so if a newer version comes out it might not be guarenteed to work using those). Once it's downloaded, drag the "Tic²Tac²Toe²" folder onto love.exe and it'll run (on Windows. Not sure about Mac and Linux but I'm sure it's not very hard).
-- Tic²Tac²Toe²
-- by thearst3rd

function love.load()
	
	-- Create some fonts for later use
	fontBig = love.graphics.newFont( 86 )
	fontMed = love.graphics.newFont( 32 )
	fontSmall = love.graphics.newFont( 18 )
	
	mouseDownLast = {}
	mouseDownLast[1] = love.mouse.isDown( 1 )
	mouseDownLast[2] = love.mouse.isDown( 2 )
	mousePressed = {}
	mouseReleased = {}
	
	-- Define player colors
	
	ply1Color = { 255, 0, 0 }
	ply2Color = { 0, 0, 255 }
	tieColor = { 0, 127, 0 }
	
	-- Create menu layout
	menu = {}
	menu.playButton = { text = "Play Game", x = love.graphics.getWidth()/2 - 100, y = 400, w = 200, h = 50 }
	menu.helpButton = { text = "Help / Credits", x = menu.playButton.x - 25, y = 470, w = 250, h = 50 }
	
	menu.backButton = { text = "Back", x = menu.playButton.x, y = 470, w = 200, h = 50 }
	
	menu.resumeButton = { text = "Resume Game", x = love.graphics.getWidth()/2 - 150 - 175, y = 400, w = 300, h = 50 }
	menu.restartButton = { text = "Restart Game", x = love.graphics.getWidth()/2 - 150 + 175, y = 400, w = 300, h = 50 }
	
	menu.menuButton = { text = "Main Menu", x = 10, y = 540, w = 200, h = 50 }
	
	-- Setup game details
	gameState = 0
	
end

function love.update( dt ) 	----------- UPDATE -----------
	
	-- Handle mouse functions
	for k, v in pairs( mouseDownLast ) do
		mousePressed[k] = love.mouse.isDown( k ) and not v
		mouseReleased[k] = v and not love.mouse.isDown( k )
	end
	
	if gameState == 0 then 	-- Menu
		if buttonPressed( menu.playButton ) then
			gameInit()
		elseif buttonPressed( menu.helpButton ) then
			gameState = 0.5
		end
	elseif gameState == 0.25 then
		if buttonPressed( menu.resumeButton ) then 
			gameState = 1
		elseif buttonPressed( menu.restartButton ) then
			gameInit()
		elseif buttonPressed( menu.helpButton ) then
			gameState = 0.75
		end
	elseif gameState == 0.5 then 	-- Credits
		if buttonPressed( menu.backButton ) then
			gameState = 0
		end
	elseif gameState == 0.75 then
		if buttonPressed( menu.backButton ) then
			gameState = 0.25
		end
	elseif gameState == 1 then 	-- Game running
		for i=1, 9 do
			if ( location == 0 or location == i ) and game[i].won == 0 then
				pos = checkBoardPressed( game[i], ( i-1 ) % 3 * 190 + 235, math.floor( ( i-1 ) / 3 ) * 190 + 35 )
				if pos and pos > 0 then
					game[i][pos] = player
					checkBoardWon( game[i] )
					player = player == 1 and 2 or 1
					if game[pos].won == 0 then
						location = pos
					else
						location = 0
					end
					checkEndGame()
				end
			end
		end
		if buttonPressed( menu.menuButton ) then
			gameState = 0.25
		end
	elseif gameState == 2 then
		if buttonPressed( menu.menuButton ) then
			gameState = 0
		end
	end
	
	-- End of cycle
	mouseDownLast[1] = love.mouse.isDown( 1 )
	mouseDownLast[2] = love.mouse.isDown( 2 )
	
end

function love.draw() 	---------- DRAW ----------
	
	love.graphics.setBackgroundColor( 240, 240, 240 )
	
	if gameState == 0 or gameState == 0.25 then 	-- Menu
		love.graphics.setColor( 15, 15, 15 )
		love.graphics.setFont( fontBig )
		love.graphics.printf( "Tic²Tac²Toe²", 0, 90, love.graphics.getWidth(), "center" )
		
		love.graphics.setFont( fontMed )
		love.graphics.printf( "by thearst3rd", 0, 200, love.graphics.getWidth(), "center" )
		
		if gameState == 0 then
			drawButton( menu.playButton )
		else
			drawButton( menu.resumeButton )
			drawButton( menu.restartButton )
		end
		drawButton( menu.helpButton )
	elseif gameState == 0.5 or gameState == 0.75 then
		love.graphics.setColor( 15, 15, 15 )
		love.graphics.setFont( fontBig )
		love.graphics.printf( "Tic²Tac²Toe²", 0, 90, love.graphics.getWidth(), "center" )
		
		love.graphics.setFont( fontSmall )
		love.graphics.printf( "Tic²Tac²Toe² is tic tac toe within tic tac toe. There are 9 tic tac toe boards that form one large board, and players take turns putting Xs and Os in the spots on the small boards. If a player wins any small board, that board becomes their piece on the big board - a tie counting towards both players. The objective of the game is to get three in a row on the big board. The catch is: when a player plays a piece on a small board, the next person must play on the big board corresponding to the section that was played on the small board. If it is a board that has already won, the player may choose whichever board they would like. Yeah okay that's it stop reading this now and and go play teh gaem and stuff                          ", 100, 200, love.graphics.getWidth()-200, "justify" )
		
		love.graphics.print( "v1.0", 20, 560 )
		
		drawButton( menu.backButton )
	elseif gameState == 1 then
		for i=1, 9 do
			local x = ( i-1 ) % 3 * 190 + 235
			local y = math.floor( ( i-1 ) / 3 ) * 190 + 35
			drawBoard( game[i], x, y )
			if ( location == 0 or location == i ) and game[i].won == 0 then
				love.graphics.setColor( player == 1 and ply1Color or ply2Color )
				love.graphics.rectangle( "line", x-10, y-10, 170, 170 )
			end
		end
		love.graphics.setColor( 0, 0, 0 )
		love.graphics.rectangle( "fill", 215, 203, 570, 5 )
		love.graphics.rectangle( "fill", 215, 393, 570, 5 )
		love.graphics.rectangle( "fill", 403, 15, 5, 570 )
		love.graphics.rectangle( "fill", 593, 15, 5, 570 )
		
		love.graphics.setColor( player == 1 and ply1Color or ply2Color )
		love.graphics.setFont( fontMed )
		love.graphics.printf( "PLAYER " .. player .. "'S TURN", 10, 10, 220, "center" )
		
		drawButton( menu.menuButton )
	elseif gameState == 2 then
		for i=1, 9 do
			local x = ( i-1 ) % 3 * 190 + 235
			local y = math.floor( ( i-1 ) / 3 ) * 190 + 35
			drawBoard( game[i], x, y )
		end
		love.graphics.setColor( 0, 0, 0 )
		love.graphics.rectangle( "fill", 215, 203, 570, 5 )
		love.graphics.rectangle( "fill", 215, 393, 570, 5 )
		love.graphics.rectangle( "fill", 403, 15, 5, 570 )
		love.graphics.rectangle( "fill", 593, 15, 5, 570 )
		
		love.graphics.setFont( fontMed )
		if winner == 1 then
			love.graphics.setColor( ply1Color )
			love.graphics.printf( "PLAYER 1 WINS THE GAME", 10, 10, 220, "center" )
		elseif winner == 2 then
			love.graphics.setColor( ply2Color )
			love.graphics.printf( "PLAYER 2 WINS THE GAME", 10, 10, 220, "center" )
		elseif winner == -1 then
			love.graphics.setColor( tieColor )
			love.graphics.printf( "THE GAME IS A TIE", 10, 10, 220, "center" )
		end
		
		drawButton( menu.menuButton )
	end
	
end


---- ####              #### ----
---- #### MY FUNCTIONS #### ----
---- ####              #### ----

function drawButton( button )
	
	local f = love.graphics.getFont()
	local c = { love.graphics.getColor() }
	
	local mx, my = love.mouse.getPosition()
	local mouseOver = mx >= button.x and mx <= button.x + button.w and my >= button.y and my <= button.y + button.h
	local md = love.mouse.isDown( 1 )
	
	love.graphics.setColor( mouseOver and ( md and { 150, 150, 150 } or { 255, 255, 255 } ) or { 200, 200, 200 } )
	love.graphics.rectangle( "fill", button.x, button.y, button.w, button.h )
	
	love.graphics.setColor( 0, 0, 0 )
	love.graphics.rectangle( "line", button.x, button.y, button.w, button.h )
	
	love.graphics.setFont( fontMed )
	love.graphics.printf( button.text, button.x, button.y+5, button.w, "center" )
	
	love.graphics.setFont( f )
	love.graphics.setColor( c )
	
end

function buttonPressed( button )
	
	local mx, my = love.mouse.getPosition()
	local mouseOver = mx >= button.x and mx <= button.x + button.w and my >= button.y and my <= button.y + button.h
	
	if mouseOver and mouseReleased[ 1 ] then
		return true
	end
	return false
	
end

function gameInit()
	
	game = {}
	for i=1, 9 do
		local board = {}
		for j=1, 9 do
			board[j] = 0
		end
		board.won = 0
		game[i] = board
	end
	
	gameState = 1
	location = 0
	player = 1
	winner = 0
	
end

function drawBoard( board, x, y )
	
	love.graphics.push()
	love.graphics.translate( x, y )
	love.graphics.setColor( 0, 0, 0 )
	love.graphics.line( 50, 0, 50, 150 )
	love.graphics.line( 100, 0, 100, 150 )
	love.graphics.line( 0, 50, 150, 50 )
	love.graphics.line( 0, 100, 150, 100 )
	
	for i=1, 9 do
		local xx = ( ( i-1 ) % 3 ) * 50
		local yy = math.floor( ( i-1 ) / 3 ) * 50
		love.graphics.push()
		love.graphics.translate( xx, yy )
		if board[i] == 1 then
			love.graphics.setColor( ply1Color )
			love.graphics.line( 6, 6, 42, 42 )
			love.graphics.line( 6, 42, 42, 6 )
		elseif board[i] == 2 then
			love.graphics.setColor( ply2Color )
			love.graphics.circle( "line", 25, 25, 19 )
		end
		love.graphics.pop()
	end
	
	if not ( board.won == 0 ) then
		print( "rendering" )
		love.graphics.setColor( 255, 255, 255, 200 )
		love.graphics.rectangle( "fill", -6, -6, 162, 162 )
		if board.won == 1 then
			love.graphics.setColor( ply1Color )
			love.graphics.line( 0, 0, 150, 150 )
			love.graphics.line( 0, 150, 150, 0 )
		elseif board.won == 2 then
			love.graphics.setColor( ply2Color)
			love.graphics.circle( "line", 75, 75, 75 )
		elseif board.won == -1 then
			love.graphics.setColor( tieColor )
			love.graphics.line( 0, 0, 150, 150 )
			love.graphics.line( 0, 150, 150, 0 )
			love.graphics.circle( "line", 75, 75, 75 )
		end
	end
	
	love.graphics.pop()
	
end

function checkBoardPressed( board, x, y )
	
	local mx, my = love.mouse.getPosition()
	local pos = 0
	
	if mx > x and mx < x + 150 and my > y and my < y + 150 then
		local xx = mx - x
		local yy = my - y
		pos = math.floor( xx / 50 ) + 3*math.floor( yy / 50 ) + 1
		if mousePressed[ 1 ] and board[pos] == 0 then
			return pos
		end
	end
	
end

function checkBoardWon( board )
	
	for i=1, 7, 3 do
		if board[i] == board[i+1] and board[i+1] == board[i+2] and board[i] ~= 0 then
			board.won = board[i]
			return board.won
		end
	end
	for i=1, 3 do
		if board[i] == board[i+3] and board[i+3] == board[i+6] and board[i] ~= 0 then
			board.won = board[i]
			return board.won
		end
	end
	if board[1] == board[5] and board[5] == board[9] and board[1] ~= 0  then
		board.won = board[1]
		return board.won
	end
	if board[3] == board[5] and board[5] == board[7] and board[3] ~= 0  then
		board.won = board[3]
		return board.won
	end
	if board[1] ~= 0 and board[2] ~= 0 and board[3] ~= 0 and board[4] ~= 0 and board[5] ~= 0 and board[6] ~= 0 and board[7] ~= 0 and board[8] ~= 0 and board[9] ~= 0 then
		board.won = -1
		return board.won
	end
	
end

function checkEndGame()
	
	local wins = {}
	for i=1, 9 do
		wins[i] = game[i].won
	end
	
	local redWins = {}
	for i=1, 9 do
		redWins[i] = wins[i] ~= -1 and wins[i] or 1
	end
	local blueWins = {}
	for i=1, 9 do
		blueWins[i] = wins[i] ~= -1 and wins[i] or 2
	end
	
	redWon = checkBoardWon( redWins ) == 1
	blueWon = checkBoardWon( blueWins ) == 2
	
	if redWon and ( not blueWon ) then
		gameState = 2
		winner = 1
	elseif blueWon and ( not redWon ) then
		gameState = 2
		winner = 2
	elseif ( redWon and blueWon ) or ( wins[1] ~= 0 and wins[2] ~= 0 and wins[3] ~= 0 and wins[4] ~= 0 and wins[5] ~= 0 and wins[6] ~= 0 and wins[7] ~= 0 and wins[8] ~= 0 and wins[9] ~= 0 ) then
		gameState = 2
		winner = -1
	end
	
end

// TODO: handle tileSets bigger than the display

viewTileSet = function(tileDisp)
	_checkTileDisplay tileDisp
	_viewTileSet tileDisp
end function

_checkTileDisplay = function(tileDisp)
	if not tileDisp isa TileDisplay then
		print "Parameter must be a TileDisplay"
		exit
	end if
	if not tileDisp.tileSet then
		print "Property tileSet of TileDisplay not set"
		exit
	end if
	if not tileDisp.tileSetTileSize then
		print "Property tileSetTileSize of TileDisplay not set"
		exit
	end if
end function

_viewTileSet = function(tileDisp)
	// Prepare display
	prevDisp = display(0)
	g = new PixelDisplay
	g.install 0
	g.clear "#00000088"
	// Draw contents
	_drawContents(g,tileDisp)
	// Wait for key
	text.delimiter = ""
	text.inverse = true
	print "[Press any key]"
	text.inverse = false
	key.get
	// Restore display
	text.column = 0
	print " " * 32
	g.clear
	prevDisp.install 0
	display(0).mode = prevDisp.mode
	text.delimiter = char(13)		
end function

_drawContents = function(g,tileDisp)
	pic = tileDisp.tileSet
	tileSize = tileDisp.tileSetTileSize
	cols = pic.width / tileSize
	rows = pic.height / tileSize
	
	bottomLeftX = 960/2-pic.width/2
	bottomLeftY = 640/2-pic.height/2
	
	// Draw tileSet
	g.drawImage pic, bottomLeftX, bottomLeftY
	
	// Draw index labels
	idx = 0
	for row in range(1,rows)
		for col in range(1,cols)
			x = bottomLeftX + tileSize * (col - 1)
			y = bottomLeftY + tileSize * (rows - 1 - (row - 1))
			g.print idx,x+7,tileSize-20+y+1,color.black,"small"
			g.print idx,x+5,tileSize-20+y+2,color.white,"small"
			idx = idx + 1
		end for
	end for
	
end function

// == DEMO PART ==
__DEMO__ = function; end function

if locals == globals then
	
	TILESHEET_TILE_SIZE = 64
	
	tileSheet = file.loadImage("sokoban_tilesheet.png")
	
	// -- Setup tile display
	display(6).mode = displayMode.tile
	tileDisp = display(6)
	tileDisp.tileSet = tileSheet
	tileDisp.tileSetTileSize = TILESHEET_TILE_SIZE
	tileDisp.cellSize = TILE_SIZE
	
	clear
	tileDisp.clear
	
	viewTileSet tileDisp
end if

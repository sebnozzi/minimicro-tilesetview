
// TODO: handle tileSets bigger than the display

// Parameter "obj" can be:
// - a TileDisplay
// - an Image
// - a path (string)
// If not a TileDisplay, then a tileSize is required
viewTileSet = function(obj,tileSize=null)
	if obj isa TileDisplay then
		tileDisp = obj
		_checkTileDisplay tileDisp,tileSize
		image = tileDisp.tileSet
		if tileSize then 
			resolvedTileSize = tileSize
		else
			resolvedTileSize = tileDisp.tileSetTileSize
		end if
		_viewTileSet image,resolvedTileSize
		exit
	else 
		_checkTileSize tileSize
		if obj isa Image then
			image = obj
			_viewTileSet image,tileSize
		else if obj isa string then
			path = obj
			image = file.loadImage(path)
			_checkImage image, path
			_viewTileSet image,tileSize
		end if
	end if
end function

_checkTileDisplay = function(tileDisp,tileSize)
	if not tileDisp.tileSet then
		print "Property tileSet of TileDisplay not set"
		exit
	end if
	if not tileDisp.tileSetTileSize and not tileSize then
		print "Required value: either TileDisplay.tileSetTileSize or parameter tileSize"
		exit
	end if
end function

_checkImage = function(image, path)
	if not image then
		print "Could not load image from: " + path
		exit
	end if
end function

_checkTileSize = function(tileSize)
	if not tileSize then
		print "Parameter tileSize must be set"
		exit
	end if
end function

_viewTileSet = function(image,tileSize)
	// Prepare display
	prevDisp = display(0)
	g = new PixelDisplay
	g.install 0
	g.clear "#00000088"
	// Draw contents
	_drawContents(g,image,tileSize)
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

_drawContents = function(g,image,tileSize)
	cols = image.width / tileSize
	rows = image.height / tileSize
	
	bottomLeftX = 960/2-image.width/2
	bottomLeftY = 640/2-image.height/2
	
	// Draw tileSet
	g.drawImage image, bottomLeftX, bottomLeftY
	
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
	
	clear
	
	path = "sokoban_tilesheet.png"
	image = file.loadImage(path)
	tileSize = 64
	
	display(6).mode = displayMode.tile
	tileDisp = display(6)
	tileDisp.tileSet = image
	tileDisp.tileSetTileSize = tileSize
	
	tileDisp.clear
	
	viewTileSet image,tileSize
end if

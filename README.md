# Tileset Viewer

A little tileset viewer tool for the Mini Micro.

This module can be used to display a tile-set together with the corresponding tile indexes. 

Very useful when referencing tiles in a TileDisplay.

## Usage

The entry-function `viewTileSet` of this module can invoked in three different ways:

1. Passing an already-configured TileDisplay (see below).
2. Passing an image (of a tile-set) and a tile-size
3. Passing a path to an image (of a tile-set) and a tile-size

Then, the tile-set image is displayed together with the corresponding tile-index numbers.

![Tool showing indexed tiles](screenshot.png)

This makes it easy to know which index to use for which tile image.

NOTE: when passing a TileDisplay the following properties need to be set:

- The tileSet (image)
- The tileSetTileSize

## Installation

This module can be used as a stand-alone program, but it really shines when imported as a module on system startup and exposing its entry-function. That way it is always "present" and can be invoked  without replacing a loaded program.

In order to do so the file `tilesetViewer.ms` has to be put somewhere where it can be imported as a module. Preferably under 

```
/usr/lib
```

Then, your `startup.ms` needs to include something like:

```
import "tilesetViewer"

viewTileSet = function(tileDisp)
	tilesetViewer.viewTileSet tileDisp
end function

// Save this state to survive "reset"s
_saveGlobals
```

This would create a function `viewTileSet` which display the tiles of a tileset with their corresponding indexes.

You can of course choose another name.

The last line `_saveGlobals` is particularly important, otherwise this function would be deleted if you execute a `reset` statement.


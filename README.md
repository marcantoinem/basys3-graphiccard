# basys3-graphiccard
This project is just a fun experiment to utilize a basys 3 as a graphic card and display some text.

## Goals
- Make a basic videogame like Pong on a FPGA
- Play a low-res video with heavy compression using only block ram

## What's working right now
640x480 60fps vga is produced from a buffer of 640x480 pixel

### Requirement
- Vivado
- GHDL and GTKWave (for testing purpose)
- Basys3

### Toolchain
`make` to synthesize and implement on the basys3
`make test` to produce a waveform and open in GTKWave
`make clean` to clean all files produced by Vivado

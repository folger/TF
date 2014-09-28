#! /usr/bin/python

while True:
    color = input('RGB: ')
    if len(color) == 0:
        break
    if color.find(' ') > 0:
        rgb = color.split(' ')
        print('{:x}'.format((int(rgb[0]) << 16) + (int(rgb[1]) << 8) + int(rgb[2])))
    else:
        ncolor = int(color)
        print('R: {}, G: {}, B: {}'.format((ncolor >> 16) & 0xFF,
                                           (ncolor >> 8) & 0xFF,
                                           ncolor & 0xFF))

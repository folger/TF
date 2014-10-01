#! /usr/bin/python

while True:
    color = input('RGB: ')
    if len(color) == 0:
        break

    def makeRGB(rgb):
        return ('{:x}'.format((int(rgb[0]) << 16) + (int(rgb[1]) << 8) + int(rgb[2])))

    if color.find(',') > 0:
        out = []
        refpt = (-1, -1)
        for group in color.split(','):
            items = group.split(' ')
            if refpt[0] == -1:
                refpt = (int(items[0]), int(items[1]))
                out.append(makeRGB([items[2], items[3], items[4]]))
            else:
                out.append('({}, {}), {}'.format(int(items[0]) - refpt[0], int(items[1]) - refpt[1], makeRGB([items[2], items[3], items[4]])))
        print('\n'.join(out))
    elif color.find(' ') > 0:
        print(makeRGB(color.split(' ')))
    else:
        ncolor = int(color)
        print('R: {}, G: {}, B: {}'.format((ncolor >> 16) & 0xFF,
                                           (ncolor >> 8) & 0xFF,
                                           ncolor & 0xFF))

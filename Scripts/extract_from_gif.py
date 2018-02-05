#!/usr/bin/env python

import os
import sys
from PIL import Image

def extract_frames(filename, output):
    frame = Image.open(filename)
    nframes = 0
    while frame:
        frame.save('%s/%s-%s.gif' % (output, os.path.basename(filename), nframes), 'GIF')
        nframes += 1
        #try:
        #    frame.seek(nframes)
        #except EOFError:
        #    break;
    return True
    
extract_frames(sys.argv[1], 'output')

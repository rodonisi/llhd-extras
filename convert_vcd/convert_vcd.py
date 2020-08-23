#! /Users/simon/.pyenv/shims/python
from vcdvcd import VCDVCD
import math
import re
import sys
import argparse
from pprint import PrettyPrinter

p = PrettyPrinter()

# Construct the argument parser
ap = argparse.ArgumentParser()

# Add the arguments to the parser
ap.add_argument('input', metavar='<input-file>', type=str,
                    help='The input VCD file')
ap.add_argument("-o", dest="output", default='-', metavar='<output-file>',
                    help="Define the ouptut file")
ap.add_argument("-T", dest="time", default=0, type=int, metavar='<max-time>',
                    help="Define a time at which to stop converting")
args = ap.parse_args()

# Get output stream
out = sys.stdout
if args.output != '-' :
    out = open(args.output, "w")

# Construct VCD parser
print('Parsing input vcd.', file=sys.stderr)
vcd = VCDVCD(args.input)
data = vcd.get_data()
print('Done.', file=sys.stderr)

def format_value_dump(val, size, n_elems):
    """ Formats the value string to a hexadecimal representation, 0-padded to the next byte.

    Args:
        val (str): the string representing the value to format
        size (int): the bitwidth of val
        n_elems (int): the number of elements, required to pretty_print arrays. An array has the number of n_elems < size
    Returns:
        The formatted value. If the value is not numeric (e.g. an 'x'), val is returned as is.
    """
    digit = val.isdigit()
    words = int(math.ceil(size/8) * 2)
    hexa = vcd._to_hex(val)
    hex_words = len(hexa)
    zext = ('0' * (words - hex_words)) + hexa
    if n_elems > 0 and n_elems < size:
        elem_word = int(words/n_elems)
        elem_format = []
        for i in range(0, n_elems):
            if digit:
                start = i*elem_word
                elem_format.append('0x' + zext[start:(start + elem_word)])
            else:
                elem_format.append(val)
        elem_format.reverse()
        return elem_format
    if digit:
        return ['0x' + zext]
    return [val]


# Transpose the signal changes to be ordered by time-step. Changes equal to the
# previous value are filtered out.
changes = {}
lastValue = {}

for i in data:
    sig = data[i]
    if sig['var_type'] == 'parameter':
        continue
    sys.stderr.write('\rProcessing ' + sig['references'][0] + '\x1b[0K')

    elem_size = -1
    s = re.split(r'(\[\d+:\d+\])', sig['references'][0])
    if len(s) > 1:
        v = re.split(r'\D+', s[1])
        elem_size = int(v[1]) + 1 - int(v[2])

    name_format = re.sub('\[\d+:\d+\]', '', sig['references'][0])
    name_format = re.sub('\.', '/', name_format)
    for change in sig['tv']:
        if args.time > 0 and change[0] > args.time:
            break
        val_formats = format_value_dump(change[1], int(sig['size']), elem_size)
        name_formats = []
        if len(val_formats) > 1:
            for x in range(0,len(val_formats)):
                name_formats.append(name_format + '[' + str(x) + ']')
        else:
            name_formats = [name_format]
        for c in zip(name_formats, val_formats):
            n, v = c
            if n not in lastValue or lastValue[n] != v:
                dump_format = '  ' + n + '  ' + v
                changes.setdefault(change[0], []).append(dump_format)
            lastValue[n] = v

sys.stderr.write('\n')

# Dump the trace in a diff-able format.
for time in sorted(changes.keys()):
    out.write(str(time) + 'ps\n')
    dumps = changes[time]
    dumps.sort()
    for dump in dumps:
        out.write(dump + '\n')

sys.stderr.write("done.\n")
out.close()

#! /Users/simon/.pyenv/shims/python
from vcdvcd import VCDVCD
import math
import re
import sys
import argparse

# Construct the argument parser
ap = argparse.ArgumentParser()

# Add the arguments to the parser
ap.add_argument('input', metavar='<input-file>', type=str,
                    help='The input VCD file')
ap.add_argument("-o", dest="output", default='-', metavar='<output-file>', help="Define the ouptut file")
args = ap.parse_args()

# Get output stream
out = sys.stdout
if args.output != '-' :
    out = open(args.output, "w")

# Construct VCD parser
vcd = VCDVCD(args.input)
data = vcd.get_data()


def format_value_dump(val, size):
    """ Formats the value string to a hexadecimal representation, 0-padded to the next byte.

    Args:
        val (str): the string representing the value to format
        size (str): the bitwidth of val
    Returns:
        The formatted value. If the value is not numeric (e.g. an 'x'), val is returned as is.
    """
    if val.isdigit():
        words = math.ceil(int(size)/8) * 2
        hexa = vcd._to_hex(val)
        hex_words = len(hexa)
        leading = '0x' + ('0' * (words - hex_words))
        return leading + hexa
    return val


# Transpose the signal changes to be ordered by time-step. Changes equal to the
# previous value are filtered out.
changes = {}
lastValue = {}

for i in data:
    sig = data[i]
    name_format = re.sub('\[\d+:\d+\]', '', sig['references'][0])
    name_format = re.sub('\.', '/', name_format)
    for change in sig['tv']:
        if i not in lastValue or lastValue[i] != change[1]:
            val_format = format_value_dump(change[1], sig['size'])
            dump_format = '  ' + name_format + '  ' + val_format
            changes.setdefault(change[0], []).append(dump_format)
        lastValue[i] = change[1]

# Dump the trace in a diff-able format.
for time in sorted(changes.keys()):
    out.write(str(time) + 'ps\n')
    dumps = changes[time]
    dumps.sort()
    for dump in dumps:
        out.write(dump + '\n')

sys.stderr.write("done.\n")
out.close()

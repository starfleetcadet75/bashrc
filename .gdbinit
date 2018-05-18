set disassembly-flavor intel
set follow-fork-mode child
set history save on
set history size 256
set history filename /tmp/.gdb_history

source /home/starfleetcadet75/Tools/pwndbg/gdbinit.py
source /usr/lib/python3.6/site-packages/voltron/entry.py

set context-sections disasm code

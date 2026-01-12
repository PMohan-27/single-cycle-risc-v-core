# Running tests:
```bash
cd test
make -B
```

Outputs go into the sim_build/rtl folder.

To view waveforms, look at cpu_top.fst.
```bash
gtkwave sim_build/rtl/cpu_top.fst
```
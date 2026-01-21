# Running tests

```bash
cd test
make -B
```

Or you can use the run.sh file to compile, test, and view the waveform:

```bash
./run.sh
```

Outputs go into the sim_build/rtl folder.

To view waveforms, look for fst files.

```bash
gtkwave sim_build/rtl/cpu_top.fst
```

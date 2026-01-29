# Running tests

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cd test
make -B
```

Or you can use the run.sh file to compile, test, and view the waveform:

```bash
./run.sh
./run.sh ALU
./run.sh CPU_TOP
./run.sh DATA_MEM
./run.sh CONTROL_UNIT
```

**Note:** Running `./run.sh` without parameters currently runs the top module test.

**Future Plans:**
- Default command will execute complete programs
- `CPU_TOP` will run one instance of each instruction type


## Viewing Results

### Simulation Outputs
All outputs are generated in the `sim_build/rtl/` folder.

### Waveforms
View waveforms using GTKWave with the generated `.fst` files:
```bash
gtkwave sim_build/rtl/cpu_top.fst
```

### Memory Dumps
Memory dumps are stored in the `dumps/` folder. Each test generates a unique memory dump file.
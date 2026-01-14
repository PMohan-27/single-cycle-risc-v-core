# Single-Cycle RISC-V Core

I'm making this project to get better at Verilog and to learn CPU architechure fundamentals. 

## Project Goals
1. Build a working single-cycle RV32I core
2. Add 5-stage pipeline
3. Extend with RV32M (multiply/divide)
4. Explore other ISA extensions


## Current Status
Phase 1 - Single-Cycle Core


## Project Structure
```
rtl/        - Verilog source files
test/       - Cocotb tests
docs/       - Documentation and diagrams
```


### TODO
- [x] Instruction memory
- [x] Register file
- [ ] ALU
- [ ] Control unit
- [ ] Data memory
- [x] PC (Program Counter)
- [ ] Immediate generator
- [ ] Integration & testing


## Running Tests
See [test.md](test/test.md) for instructions.
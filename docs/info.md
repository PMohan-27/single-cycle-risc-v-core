# CPU Arch Info

Single-cycle RISC-V CPU implementation.

![CPU Arch Diagram](RISCV-CPU.png)

| ALU Op | Operation | funct3 | funct7 |
|--------|-----------|--------|--------|
| 0000   | ADD       | 000    | 0000000|
| 0001   | SUB       | 000    | 0100000|
| 0010   | XOR       | 100    | 0000000|
| 0011   | OR        | 110    | 0000000|
| 0100   | AND       | 111    | 0000000|
| 0101   | SLL       | 001    | 0000000|
| 0110   | SRL       | 101    | 0000000|
| 0111   | SRA       | 101    | 0100000|
| 1000   | SLT       | 010    | 0000000|
| 1001   | SLTU      | 011    | 0000000|

## TODO
- [x] CPU architecture diagram
- [ ] Datapath description
- [ ] Control signals table

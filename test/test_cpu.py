
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

def load_rv32i_test_program(dut):
    
    dut.instruction_memory_inst.instr[0].value = 0b00000000001000001000001100110011   # ADD x6, x1, x2
    dut.instruction_memory_inst.instr[1].value = 0b01000000000100010000001000110011   # SUB x4, x2, x1
    dut.instruction_memory_inst.instr[2].value = 0b00000000001000001111010000110011   # AND x8, x1, x2
    dut.instruction_memory_inst.instr[3].value = 0b00000000001000001110010010110011   # OR x9, x1, x2
    dut.instruction_memory_inst.instr[4].value = 0b00000000001000001100010110110011   # XOR x11, x1, x2
    dut.instruction_memory_inst.instr[5].value = 0b00000000001100001001011000110011   # SLL x12, x1, x3
    dut.instruction_memory_inst.instr[6].value = 0b00000000001100010101011010110011   # SRL x13, x2, x3
    dut.instruction_memory_inst.instr[7].value = 0b01000000001100100101011100110011   # SRA x14, x4, x3
    dut.instruction_memory_inst.instr[8].value = 0b00000000000100100010011110110011   # SLT x15, x4, x1
    dut.instruction_memory_inst.instr[9].value = 0b00000000000100100011100000110011   # SLTU x16, x4, x1
    
    dut.instruction_memory_inst.instr[10].value = 0b00000000111100001000100010010011  # ADDI x17, x1, 15
    dut.instruction_memory_inst.instr[11].value = 0b00000001010000001010100100010011  # SLTI x18, x1, 20
    dut.instruction_memory_inst.instr[12].value = 0b00000000010100100011100110010011  # SLTIU x19, x4, 5
    dut.instruction_memory_inst.instr[13].value = 0b00000000011100001100101000010011  # XORI x20, x1, 7
    dut.instruction_memory_inst.instr[14].value = 0b00000000010100001110101010010011  # ORI x21, x1, 5
    dut.instruction_memory_inst.instr[15].value = 0b00000000111100010111101100010011  # ANDI x22, x2, 15
    dut.instruction_memory_inst.instr[16].value = 0b00000000001000001001101110010011  # SLLI x23, x1, 2
    dut.instruction_memory_inst.instr[17].value = 0b00000000001000010101110000010011  # SRLI x24, x2, 2
    dut.instruction_memory_inst.instr[18].value = 0b01000000000100100101110010010011  # SRAI x25, x4, 1
    
    dut.instruction_memory_inst.instr[19].value = 0b00000000000000101000110100000011  # LB x26, 0(x5)
    dut.instruction_memory_inst.instr[20].value = 0b00000000000000101001110110000011  # LH x27, 0(x5)
    dut.instruction_memory_inst.instr[21].value = 0b00000000000000101010111000000011  # LW x28, 0(x5)
    dut.instruction_memory_inst.instr[22].value = 0b00000000010000101100111010000011  # LBU x29, 4(x5)
    dut.instruction_memory_inst.instr[23].value = 0b00000000010000101101111100000011  # LHU x30, 4(x5)
    
    dut.instruction_memory_inst.instr[24].value = 0b00000000000100101000010000100011  # SB x1, 8(x5)
    dut.instruction_memory_inst.instr[25].value = 0b00000000001000101001010100100011  # SH x2, 10(x5)
    dut.instruction_memory_inst.instr[26].value = 0b00000000001100101010011000100011  # SW x3, 12(x5)
    
    dut.instruction_memory_inst.instr[27].value = 0b00000001111100001000010001100011  # BEQ x1, x1, 8
    dut.instruction_memory_inst.instr[28].value = 0b00000110001100000000111110010011  # ADDI x31, x0, 99 (SKIP)
    dut.instruction_memory_inst.instr[29].value = 0b00000000001000001001010001100011  # BNE x1, x2, 8
    dut.instruction_memory_inst.instr[30].value = 0b00000101100000000000111110010011  # ADDI x31, x0, 88 (SKIP)
    dut.instruction_memory_inst.instr[31].value = 0b00000000000100100100010001100011  # BLT x4, x1, 8
    dut.instruction_memory_inst.instr[32].value = 0b00000100110100000000111110010011  # ADDI x31, x0, 77 (SKIP)
    dut.instruction_memory_inst.instr[33].value = 0b00000000010000001101010001100011  # BGE x1, x4, 8
    dut.instruction_memory_inst.instr[34].value = 0b00000100001000000000111110010011  # ADDI x31, x0, 66 (SKIP)
    dut.instruction_memory_inst.instr[35].value = 0b00000000001000011110010001100011  # BLTU x3, x2, 8
    dut.instruction_memory_inst.instr[36].value = 0b00000011011100000000111110010011  # ADDI x31, x0, 55 (SKIP)
    dut.instruction_memory_inst.instr[37].value = 0b00000000001100010111010001100011  # BGEU x2, x3, 8
    dut.instruction_memory_inst.instr[38].value = 0b00000010110000000000111110010011  # ADDI x31, x0, 44 (SKIP)
    
    dut.instruction_memory_inst.instr[39].value = 0b00000000100000000000000011101111  # JAL x1, 8
    dut.instruction_memory_inst.instr[40].value = 0b00000010000100000000111110010011  # ADDI x31, x0, 33 (SKIP)
    
    dut.instruction_memory_inst.instr[41].value = 0b00000000100001010000000101100111  # JALR x2, 8(x10)
    
    dut.instruction_memory_inst.instr[42].value = 0b00010010001101000101000110110111  # LUI x3, 0x12345
    
    dut.instruction_memory_inst.instr[43].value = 0b00000001000000000000001000010111  # AUIPC x4, 0x1000

# just a test to see if it compiles / has no glaring errors
@cocotb.test()
async def test_cpu_baasic(dut):
    
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    dut.rst.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)  

    dut.rst.value = 0

    # dut.reg_file_inst.registers[5].value = 0x100  

    # dut.reg_file_inst.registers[1].value = 10
    # dut.reg_file_inst.registers[2].value = 20
    # dut.reg_file_inst.registers[3].value = 5
    # dut.reg_file_inst.registers[4].value = -3
    # dut.reg_file_inst.registers[5].value = 0
    # dut.reg_file_inst.registers[10].value = 100
    
    # dut.data_memory_inst.memory[0].value = 0x12345678
    # dut.data_memory_inst.memory[1].value = 0xAABBCCDD
    # dut.data_memory_inst.memory[2].value = 0xDEADBEEF
    # dut.data_memory_inst.memory[3].value = 0xCAFEBABE

    # dut.instruction_memory_inst.instr[0].value = 0b00000000100000101000000011100111 # jalr x1, 8(x5)
    # load_rv32i_test_program(dut)
    dut.instruction_memory_inst.instr[0].value = 0b00000000101000000000000010010011   # addi x1, x0, 10
    dut.instruction_memory_inst.instr[1].value = 0b00000000000000000000000100010011   # addi x2, x0, 0
    dut.instruction_memory_inst.instr[2].value = 0b00000000000100010000000100010011   # addi x2, x2, 1
    dut.instruction_memory_inst.instr[3].value = 0b11111111111100001000000010010011   # addi x1, x1, -1
    dut.instruction_memory_inst.instr[4].value = 0b11111110000000001001110011100011   # bne x1, x0, -8



                
    # Run for 100 clock cycles
    for i in range(50):
        await RisingEdge(dut.clk)
        # cocotb.log.info(
        #     f"PC={int(dut.PC_out.value):08X} "
        #     f"PCSel={dut.PCSel.value} "
        #     f"ImmExt={dut.ImmExt.value}"
        #     f"opCode={dut.opcode.value}"

        # )
        if i % 10 == 0:
            cocotb.log.info(f"Cycle {i}")
    await RisingEdge(dut.clk)
    with open("dumps/mem_dump.txt", "w") as f:
        f.write("Register File Dump\n")
        for reg_num in range(32):
            try:
                reg_val = int(dut.reg_file_inst.registers[reg_num].value)
                f.write(f"x{reg_num:2d} = 0x{reg_val:08X} ({reg_val:11d})\n")
            except:
                f.write(f"x{reg_num:2d} = N/A\n")
        f.write("Data mem Dump\n")
        for data in range(32):
            try:
                data_val = int(dut.data_memory_inst.memory[data].value)
                f.write(f"d{data:2d} = 0x{data_val:08X} ({data_val:11d})\n")
            except:
                f.write(f"d{data:2d} = N/A\n")

    cocotb.log.info("Test completed!")
    cocotb.log.info("Memory dumped to mem_dump.txt")


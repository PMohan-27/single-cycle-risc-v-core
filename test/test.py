
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
import ctypes

# just a test to see if it compiles / has no glaring errors
@cocotb.test()
async def test_cpu_basic(dut):
    
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    dut.rst.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)  

    dut.rst.value = 0

    dut.reg_file_inst.registers[5].value = 0x100  

    dut.instruction_memory_inst.instr[0].value = 0b00000000100000101000000011100111 # jalr x1, 8(x5)
        
                
    cocotb.log.info("Register file dumped to register_dump.txt")
    # Run for 100 clock cycles
    for i in range(100):
        await RisingEdge(dut.clk)
        if i % 10 == 0:
            cocotb.log.info(f"Cycle {i}")
    await RisingEdge(dut.clk)
    
    with open("mem_dump.txt", "w") as f:
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

# @cocotb.test
async def ALU_test(dut):
    ALU_OPS = {
        "ADD":  (0b0000, lambda a,b: a + b),  
        "SUB":  (0b0001, lambda a,b: a - b),  
        "XOR":  (0b0010, lambda a,b: a ^ b),  
        "OR":   (0b0011, lambda a,b: a | b),  
        "AND":  (0b0100, lambda a,b: a & b),  
        "SLL":  (0b0101, lambda a,b: a << (b &0b11111)),  
        "SRL":  (0b0110, lambda a,b: ctypes.c_uint32(a).value >> (b &0b11111)),  
        "SRA":  (0b0111, lambda a,b: ctypes.c_int32(a).value >> (b &0b11111)), 
        "SLT":  (0b1000, lambda a,b: ctypes.c_int32(a).value < ctypes.c_int32(b).value),  
        "SLTU": (0b1001, lambda a,b: ctypes.c_uint32(a).value < ctypes.c_uint32(b).value),  
    }

    src_values = [
        (5, 3),
        (0xFFFFFFFF, 1),
        (0x7FFFFFFF, 1),
        (0x80000000, 1),
        (1, 2),
        (0, 0),
        (0xFFFFFFFF, 0xFFFFFFFF),
        (0x7FFFFFFF, 0x7FFFFFFF),
        (100, 50),
        (0x12345678, 0x87654321)
    ]

    for values in src_values:
        for operation in ALU_OPS:
            dut.AluOp.value , calculation = ALU_OPS[operation]
            
            dut.SrcA.value = values[0]
            dut.SrcB.value = values[1]

            await Timer(10, unit="ns")

            dut._log.info(f"U{operation} {int(dut.SrcA.value)}, {int(dut.SrcB.value)} result: {int(dut.AluResult.value)}")
            dut._log.info(f"{operation} {int(dut.SrcA.value.to_signed())}, {int(dut.SrcB.value.to_signed())} result: {int(dut.AluResult.value.to_signed())}")

            expected_result = calculation(int(dut.SrcA.value),int(dut.SrcB.value))
            assert(int(dut.AluResult.value) == (expected_result & 0xFFFFFFFF))


    
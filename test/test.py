
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
import ctypes

@cocotb.test()
async def test_cpu_basic(dut):
    
    # Create a 10ns period clock (100MHz)
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Keep reset low
    dut.rst.value = 0
    
    # Run for 100 clock cycles
    for i in range(100):
        await RisingEdge(dut.clk)
        if i % 10 == 0:
            cocotb.log.info(f"Cycle {i}")
    
    cocotb.log.info("Test completed!")

@cocotb.test
async def ALU_test(dut):

    ALU_OPS = {
        "ADD":  (0b0000, lambda a,b: a + b),  
        "SUB":  (0b0001, lambda a,b: a - b),  
        "XOR":  (0b0010, lambda a,b: a ^ b),  
        "OR":   (0b0011, lambda a,b: a | b),  
        "AND":  (0b0100, lambda a,b: a & b),  
        "SLL":  (0b0101, lambda a,b: a << (b &0b11111)),  
        "SRL":  (0b0110, lambda a,b: a >> (b &0b11111)),  
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

            dut._log.info(f"{operation} {int(dut.SrcA.value)}, {int(dut.SrcB.value)} result: {int(dut.result.value):08X} ({dut.result.value.to_signed()})")
            expected_result = calculation(int(dut.SrcA.value),int(dut.SrcB.value))
            assert(int(dut.result.value) == (expected_result & 0xFFFFFFFF))


    

import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock

@cocotb.test()
async def data_mem_test(dut):
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    dut.rst.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)  
    dut.rst.value = 0

    # (WE, ExtSign, MemSize, addr, WD, expected result, case desc)
    test_cases = [
        (0, 1, 0b10, 0x00, 0x00000000, 0xAABBCCDD, "lw from 0x00"),
        (0, 1, 0b10, 0x04, 0x00000000, 0x11223344, "lw from 0x04"),
        (0, 1, 0b00, 0x00, 0x00000000, 0xFFFFFFDD, "lb from 0x00"),
        (0, 1, 0b00, 0x03, 0x00000000, 0xFFFFFFAA, "lb from 0x03"),
        (0, 0, 0b00, 0x00, 0x00000000, 0x000000DD, "lbu from 0x00"),
        (0, 1, 0b01, 0x00, 0x00000000, 0xFFFFCCDD, "lh from 0x00"),
        (0, 0, 0b01, 0x02, 0x00000000, 0x0000AABB, "lhu from 0x02"),
        (1, 0, 0b00, 0x14, 0x000000FF, None, "sb 0xFF to 0x14"),
        (1, 0, 0b01, 0x18, 0x0000ABCD, None, "sh 0xABCD to 0x18"),
        (1, 0, 0b10, 0x1C, 0xDEADBEEF, None, "sw 0xDEADBEEF to 0x1C"),
        (0, 1, 0b10, 0x14, 0x00000000, 0x000000FF, "lw verify sb"),
        (0, 1, 0b10, 0x18, 0x00000000, 0x0000ABCD, "lw verify sh"),
        (0, 1, 0b10, 0x1C, 0x00000000, 0xDEADBEEF, "lw verify sw"),
    ]


    dut.memory[0].value = 0xAABBCCDD
    dut.memory[1].value = 0x11223344
    dut.memory[2].value = 0x87654321
    dut.memory[3].value = 0x7FFFABCD
    dut.memory[4].value = 0xDEADBEEF
    dut.memory[5].value = 0x00000000
    
    for we, extsign, memsize, addr, wd, expected_result, case_desc in test_cases:
        cocotb.log.info(case_desc)
        dut.WE.value = we
        dut.MemSize.value = memsize
        dut.addr.value = addr
        dut.ExtSign.value = extsign
        dut.WD.value = wd
        if(we == 0):
            await Timer(1, units='ns')
            assert(int(dut.read.value) == expected_result), case_desc + " failed"
        else:
            await RisingEdge(dut.clk)


    with open("dumps/data_mem_test_dump.txt", "w") as f:
        f.write("Register File Dump\n")
        f.write("Data mem Dump\n")
        for data in range(32):
            try:
                data_val = int(dut.memory[data].value)
                f.write(f"d{data:2d} = 0x{data_val:08X} ({data_val:11d})\n")
            except:
                f.write(f"d{data:2d} = N/A\n")




    

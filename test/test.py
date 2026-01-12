
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

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
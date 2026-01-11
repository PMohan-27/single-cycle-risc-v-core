

import cocotb



@cocotb.test
async def testfunc(dut):
    dut._log.info("Hello cocotb test")
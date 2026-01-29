import cocotb
from cocotb.triggers import Timer

def set_instruction(dut, opcode, funct7, funct3, Zero=0, Overflow=0, Negative=0, Carry=0):
    dut.opcode.value       = opcode
    dut.funct7.value       = funct7
    dut.funct3.value       = funct3
    dut.ZeroFlag.value     = Zero
    dut.OverflowFlag.value = Overflow
    dut.NegativeFlag.value = Negative
    dut.CarryFlag.value    = Carry

async def test_r_type(dut,funct7,funct3,name):

    set_instruction(
        dut,
        opcode=0b0110011,
        funct7=funct7,
        funct3=funct3,
    )

    await Timer(1,units='ns')

    assert dut.RegWrite.value == 1, f"{name}: RegWrite"
    assert dut.MemWrite.value == 0, f"{name}: MemWrite"
    assert dut.ResultSrc.value == 0, f"{name}: ResultSrc"
    assert dut.PCSel.value == 0,     f"{name}: PCSel"
    assert dut.AluSrcASel.value == 0
    assert dut.AluSrcBSel.value == 0
    assert dut.ExtSign.value == 0
    assert dut.ImmSel.value == 0
    cocotb.log.info(f"{name} instr test passed")

async def test_i_type(dut,funct7,funct3,name):

    set_instruction(
        dut,
        opcode=0b0110011,
        funct7=funct7,
        funct3=funct3,
    )

    await Timer(1,units='ns')

    assert dut.RegWrite.value == 1, f"{name}: RegWrite"
    assert dut.MemWrite.value == 0, f"{name}: MemWrite"
    assert dut.ResultSrc.value == 0, f"{name}: ResultSrc"
    assert dut.PCSel.value == 0,     f"{name}: PCSel"
    assert dut.AluSrcASel.value == 0
    assert dut.AluSrcBSel.value == 0
    assert dut.ExtSign.value == 0
    assert dut.ImmSel.value == 0
    cocotb.log.info(f"{name} instr test passed")
    
@cocotb.test()
async def control_unit_test(dut):
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b000, name="ADD")
    await test_r_type(dut=dut, funct7=0b0100000, funct3=0b000, name="SUB")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b001, name="SLL")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b010, name="SLT")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b011, name="SLTU")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b100, name="XOR")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b101, name="SRL")
    await test_r_type(dut=dut, funct7=0b0100000, funct3=0b101, name="SRA")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b110, name="OR")
    await test_r_type(dut=dut, funct7=0b0000000, funct3=0b111, name="AND")

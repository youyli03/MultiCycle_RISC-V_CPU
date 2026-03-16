
oledGame.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <_start>:
80000000:	80002137          	lui	sp,0x80002
80000004:	d0010113          	addi	sp,sp,-768 # 80001d00 <ramod_val+0x41e>
80000008:	0f0000ef          	jal	ra,800000f8 <main>
8000000c:	0000006f          	j	8000000c <_start+0xc>

80000010 <resetTIM>:
80000010:	fe010113          	addi	sp,sp,-32
80000014:	00812e23          	sw	s0,28(sp)
80000018:	02010413          	addi	s0,sp,32
8000001c:	fea42623          	sw	a0,-20(s0)
80000020:	f00027b7          	lui	a5,0xf0002
80000024:	00400713          	li	a4,4
80000028:	00e7a023          	sw	a4,0(a5) # f0002000 <ramod_val+0x7000071e>
8000002c:	f00027b7          	lui	a5,0xf0002
80000030:	00878793          	addi	a5,a5,8 # f0002008 <ramod_val+0x70000726>
80000034:	0007a023          	sw	zero,0(a5)
80000038:	f00027b7          	lui	a5,0xf0002
8000003c:	00c78793          	addi	a5,a5,12 # f000200c <ramod_val+0x7000072a>
80000040:	0007a023          	sw	zero,0(a5)
80000044:	f00027b7          	lui	a5,0xf0002
80000048:	00478793          	addi	a5,a5,4 # f0002004 <ramod_val+0x70000722>
8000004c:	fec42703          	lw	a4,-20(s0)
80000050:	00e7a023          	sw	a4,0(a5)
80000054:	f00027b7          	lui	a5,0xf0002
80000058:	00300713          	li	a4,3
8000005c:	00e7a023          	sw	a4,0(a5) # f0002000 <ramod_val+0x7000071e>
80000060:	00000013          	nop
80000064:	01c12403          	lw	s0,28(sp)
80000068:	02010113          	addi	sp,sp,32
8000006c:	00008067          	ret

80000070 <KeyIsDown>:
80000070:	fd010113          	addi	sp,sp,-48
80000074:	02812623          	sw	s0,44(sp)
80000078:	03010413          	addi	s0,sp,48
8000007c:	fca42e23          	sw	a0,-36(s0)
80000080:	f00007b7          	lui	a5,0xf0000
80000084:	0007a783          	lw	a5,0(a5) # f0000000 <ramod_val+0x6fffe71e>
80000088:	fdc42703          	lw	a4,-36(s0)
8000008c:	00100693          	li	a3,1
80000090:	00e69733          	sll	a4,a3,a4
80000094:	00e7f7b3          	and	a5,a5,a4
80000098:	04079663          	bnez	a5,800000e4 <KeyIsDown+0x74>
8000009c:	fe042623          	sw	zero,-20(s0)
800000a0:	0100006f          	j	800000b0 <KeyIsDown+0x40>
800000a4:	fec42783          	lw	a5,-20(s0)
800000a8:	00178793          	addi	a5,a5,1
800000ac:	fef42623          	sw	a5,-20(s0)
800000b0:	fec42703          	lw	a4,-20(s0)
800000b4:	0000c7b7          	lui	a5,0xc
800000b8:	34f78793          	addi	a5,a5,847 # c34f <_start-0x7fff3cb1>
800000bc:	fee7f4e3          	bgeu	a5,a4,800000a4 <KeyIsDown+0x34>
800000c0:	f00007b7          	lui	a5,0xf0000
800000c4:	0007a783          	lw	a5,0(a5) # f0000000 <ramod_val+0x6fffe71e>
800000c8:	fdc42703          	lw	a4,-36(s0)
800000cc:	00100693          	li	a3,1
800000d0:	00e69733          	sll	a4,a3,a4
800000d4:	00e7f7b3          	and	a5,a5,a4
800000d8:	00079663          	bnez	a5,800000e4 <KeyIsDown+0x74>
800000dc:	00100793          	li	a5,1
800000e0:	0080006f          	j	800000e8 <KeyIsDown+0x78>
800000e4:	00000793          	li	a5,0
800000e8:	00078513          	mv	a0,a5
800000ec:	02c12403          	lw	s0,44(sp)
800000f0:	03010113          	addi	sp,sp,48
800000f4:	00008067          	ret

800000f8 <main>:
800000f8:	ff010113          	addi	sp,sp,-16
800000fc:	00112623          	sw	ra,12(sp)
80000100:	00812423          	sw	s0,8(sp)
80000104:	01010413          	addi	s0,sp,16
80000108:	f00007b7          	lui	a5,0xf0000
8000010c:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000110:	00010737          	lui	a4,0x10
80000114:	f0f70713          	addi	a4,a4,-241 # ff0f <_start-0x7fff00f1>
80000118:	00e7a023          	sw	a4,0(a5)
8000011c:	f00007b7          	lui	a5,0xf0000
80000120:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000124:	00001737          	lui	a4,0x1
80000128:	a0470713          	addi	a4,a4,-1532 # a04 <_start-0x7ffff5fc>
8000012c:	00e7a023          	sw	a4,0(a5)
80000130:	544000ef          	jal	ra,80000674 <OLED_Init>
80000134:	00400693          	li	a3,4
80000138:	800017b7          	lui	a5,0x80001
8000013c:	5ec78613          	addi	a2,a5,1516 # 800015ec <ramod_val+0xfffffd0a>
80000140:	00000593          	li	a1,0
80000144:	06400513          	li	a0,100
80000148:	77c000ef          	jal	ra,800008c4 <OLED_DisplayStr>
8000014c:	130010ef          	jal	ra,8000127c <Dino_Start>
80000150:	0000006f          	j	80000150 <main+0x58>

80000154 <Delay_5us>:
80000154:	ff010113          	addi	sp,sp,-16
80000158:	00812623          	sw	s0,12(sp)
8000015c:	01010413          	addi	s0,sp,16
80000160:	00000013          	nop
80000164:	00c12403          	lw	s0,12(sp)
80000168:	01010113          	addi	sp,sp,16
8000016c:	00008067          	ret

80000170 <I2C_Start>:
80000170:	ff010113          	addi	sp,sp,-16
80000174:	00112623          	sw	ra,12(sp)
80000178:	00812423          	sw	s0,8(sp)
8000017c:	01010413          	addi	s0,sp,16
80000180:	f00007b7          	lui	a5,0xf0000
80000184:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000188:	0007a703          	lw	a4,0(a5)
8000018c:	f00007b7          	lui	a5,0xf0000
80000190:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000194:	00376713          	ori	a4,a4,3
80000198:	00e7a023          	sw	a4,0(a5)
8000019c:	f00007b7          	lui	a5,0xf0000
800001a0:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800001a4:	0007a703          	lw	a4,0(a5)
800001a8:	f00007b7          	lui	a5,0xf0000
800001ac:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800001b0:	00376713          	ori	a4,a4,3
800001b4:	00e7a023          	sw	a4,0(a5)
800001b8:	f9dff0ef          	jal	ra,80000154 <Delay_5us>
800001bc:	f00007b7          	lui	a5,0xf0000
800001c0:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800001c4:	0007a703          	lw	a4,0(a5)
800001c8:	f00007b7          	lui	a5,0xf0000
800001cc:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800001d0:	ffe77713          	andi	a4,a4,-2
800001d4:	00e7a023          	sw	a4,0(a5)
800001d8:	f7dff0ef          	jal	ra,80000154 <Delay_5us>
800001dc:	f00007b7          	lui	a5,0xf0000
800001e0:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800001e4:	0007a703          	lw	a4,0(a5)
800001e8:	f00007b7          	lui	a5,0xf0000
800001ec:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800001f0:	ffc77713          	andi	a4,a4,-4
800001f4:	00e7a023          	sw	a4,0(a5)
800001f8:	f5dff0ef          	jal	ra,80000154 <Delay_5us>
800001fc:	00000013          	nop
80000200:	00c12083          	lw	ra,12(sp)
80000204:	00812403          	lw	s0,8(sp)
80000208:	01010113          	addi	sp,sp,16
8000020c:	00008067          	ret

80000210 <I2C_Stop>:
80000210:	ff010113          	addi	sp,sp,-16
80000214:	00112623          	sw	ra,12(sp)
80000218:	00812423          	sw	s0,8(sp)
8000021c:	01010413          	addi	s0,sp,16
80000220:	f00007b7          	lui	a5,0xf0000
80000224:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000228:	0007a703          	lw	a4,0(a5)
8000022c:	f00007b7          	lui	a5,0xf0000
80000230:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000234:	00376713          	ori	a4,a4,3
80000238:	00e7a023          	sw	a4,0(a5)
8000023c:	f00007b7          	lui	a5,0xf0000
80000240:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000244:	0007a783          	lw	a5,0(a5)
80000248:	ffc7f713          	andi	a4,a5,-4
8000024c:	f00007b7          	lui	a5,0xf0000
80000250:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000254:	00276713          	ori	a4,a4,2
80000258:	00e7a023          	sw	a4,0(a5)
8000025c:	ef9ff0ef          	jal	ra,80000154 <Delay_5us>
80000260:	f00007b7          	lui	a5,0xf0000
80000264:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000268:	0007a703          	lw	a4,0(a5)
8000026c:	f00007b7          	lui	a5,0xf0000
80000270:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000274:	00176713          	ori	a4,a4,1
80000278:	00e7a023          	sw	a4,0(a5)
8000027c:	ed9ff0ef          	jal	ra,80000154 <Delay_5us>
80000280:	00000013          	nop
80000284:	00c12083          	lw	ra,12(sp)
80000288:	00812403          	lw	s0,8(sp)
8000028c:	01010113          	addi	sp,sp,16
80000290:	00008067          	ret

80000294 <I2C_Wait_Ack>:
80000294:	fe010113          	addi	sp,sp,-32
80000298:	00112e23          	sw	ra,28(sp)
8000029c:	00812c23          	sw	s0,24(sp)
800002a0:	02010413          	addi	s0,sp,32
800002a4:	fe042623          	sw	zero,-20(s0)
800002a8:	f00007b7          	lui	a5,0xf0000
800002ac:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
800002b0:	0007a783          	lw	a5,0(a5)
800002b4:	ffc7f713          	andi	a4,a5,-4
800002b8:	f00007b7          	lui	a5,0xf0000
800002bc:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
800002c0:	00276713          	ori	a4,a4,2
800002c4:	00e7a023          	sw	a4,0(a5)
800002c8:	f00007b7          	lui	a5,0xf0000
800002cc:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800002d0:	0007a703          	lw	a4,0(a5)
800002d4:	f00007b7          	lui	a5,0xf0000
800002d8:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800002dc:	00376713          	ori	a4,a4,3
800002e0:	00e7a023          	sw	a4,0(a5)
800002e4:	e71ff0ef          	jal	ra,80000154 <Delay_5us>
800002e8:	0280006f          	j	80000310 <I2C_Wait_Ack+0x7c>
800002ec:	fec42783          	lw	a5,-20(s0)
800002f0:	00178793          	addi	a5,a5,1
800002f4:	fef42623          	sw	a5,-20(s0)
800002f8:	fec42703          	lw	a4,-20(s0)
800002fc:	0fa00793          	li	a5,250
80000300:	00e7f863          	bgeu	a5,a4,80000310 <I2C_Wait_Ack+0x7c>
80000304:	f0dff0ef          	jal	ra,80000210 <I2C_Stop>
80000308:	00100793          	li	a5,1
8000030c:	0380006f          	j	80000344 <I2C_Wait_Ack+0xb0>
80000310:	f00007b7          	lui	a5,0xf0000
80000314:	0007a783          	lw	a5,0(a5) # f0000000 <ramod_val+0x6fffe71e>
80000318:	0017f793          	andi	a5,a5,1
8000031c:	fc0798e3          	bnez	a5,800002ec <I2C_Wait_Ack+0x58>
80000320:	f00007b7          	lui	a5,0xf0000
80000324:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000328:	0007a703          	lw	a4,0(a5)
8000032c:	f00007b7          	lui	a5,0xf0000
80000330:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000334:	ffd77713          	andi	a4,a4,-3
80000338:	00e7a023          	sw	a4,0(a5)
8000033c:	e19ff0ef          	jal	ra,80000154 <Delay_5us>
80000340:	00000793          	li	a5,0
80000344:	00078513          	mv	a0,a5
80000348:	01c12083          	lw	ra,28(sp)
8000034c:	01812403          	lw	s0,24(sp)
80000350:	02010113          	addi	sp,sp,32
80000354:	00008067          	ret

80000358 <I2C_Write_Byte>:
80000358:	fd010113          	addi	sp,sp,-48
8000035c:	02812623          	sw	s0,44(sp)
80000360:	03010413          	addi	s0,sp,48
80000364:	00050793          	mv	a5,a0
80000368:	fcf40fa3          	sb	a5,-33(s0)
8000036c:	f00007b7          	lui	a5,0xf0000
80000370:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000374:	0007a703          	lw	a4,0(a5)
80000378:	f00007b7          	lui	a5,0xf0000
8000037c:	00478793          	addi	a5,a5,4 # f0000004 <ramod_val+0x6fffe722>
80000380:	00376713          	ori	a4,a4,3
80000384:	00e7a023          	sw	a4,0(a5)
80000388:	fe0407a3          	sb	zero,-17(s0)
8000038c:	0b40006f          	j	80000440 <I2C_Write_Byte+0xe8>
80000390:	f00007b7          	lui	a5,0xf0000
80000394:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000398:	0007a703          	lw	a4,0(a5)
8000039c:	f00007b7          	lui	a5,0xf0000
800003a0:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800003a4:	ffd77713          	andi	a4,a4,-3
800003a8:	00e7a023          	sw	a4,0(a5)
800003ac:	fdf40783          	lb	a5,-33(s0)
800003b0:	0207d263          	bgez	a5,800003d4 <I2C_Write_Byte+0x7c>
800003b4:	f00007b7          	lui	a5,0xf0000
800003b8:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800003bc:	0007a703          	lw	a4,0(a5)
800003c0:	f00007b7          	lui	a5,0xf0000
800003c4:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800003c8:	00176713          	ori	a4,a4,1
800003cc:	00e7a023          	sw	a4,0(a5)
800003d0:	0200006f          	j	800003f0 <I2C_Write_Byte+0x98>
800003d4:	f00007b7          	lui	a5,0xf0000
800003d8:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800003dc:	0007a703          	lw	a4,0(a5)
800003e0:	f00007b7          	lui	a5,0xf0000
800003e4:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800003e8:	ffe77713          	andi	a4,a4,-2
800003ec:	00e7a023          	sw	a4,0(a5)
800003f0:	f00007b7          	lui	a5,0xf0000
800003f4:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
800003f8:	0007a703          	lw	a4,0(a5)
800003fc:	f00007b7          	lui	a5,0xf0000
80000400:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000404:	00276713          	ori	a4,a4,2
80000408:	00e7a023          	sw	a4,0(a5)
8000040c:	f00007b7          	lui	a5,0xf0000
80000410:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000414:	0007a703          	lw	a4,0(a5)
80000418:	f00007b7          	lui	a5,0xf0000
8000041c:	00878793          	addi	a5,a5,8 # f0000008 <ramod_val+0x6fffe726>
80000420:	ffd77713          	andi	a4,a4,-3
80000424:	00e7a023          	sw	a4,0(a5)
80000428:	fdf44783          	lbu	a5,-33(s0)
8000042c:	00179793          	slli	a5,a5,0x1
80000430:	fcf40fa3          	sb	a5,-33(s0)
80000434:	fef44783          	lbu	a5,-17(s0)
80000438:	00178793          	addi	a5,a5,1
8000043c:	fef407a3          	sb	a5,-17(s0)
80000440:	fef44703          	lbu	a4,-17(s0)
80000444:	00700793          	li	a5,7
80000448:	f4e7f4e3          	bgeu	a5,a4,80000390 <I2C_Write_Byte+0x38>
8000044c:	00000013          	nop
80000450:	02c12403          	lw	s0,44(sp)
80000454:	03010113          	addi	sp,sp,48
80000458:	00008067          	ret

8000045c <Delay_ms>:
8000045c:	fd010113          	addi	sp,sp,-48
80000460:	02812623          	sw	s0,44(sp)
80000464:	03010413          	addi	s0,sp,48
80000468:	fca42e23          	sw	a0,-36(s0)
8000046c:	04c0006f          	j	800004b8 <Delay_ms+0x5c>
80000470:	00000013          	nop
80000474:	00000013          	nop
80000478:	00000013          	nop
8000047c:	00b00793          	li	a5,11
80000480:	fef407a3          	sb	a5,-17(s0)
80000484:	fbe00793          	li	a5,-66
80000488:	fef40723          	sb	a5,-18(s0)
8000048c:	00000013          	nop
80000490:	fee44783          	lbu	a5,-18(s0)
80000494:	fff78793          	addi	a5,a5,-1
80000498:	fef40723          	sb	a5,-18(s0)
8000049c:	fee44783          	lbu	a5,-18(s0)
800004a0:	fe0798e3          	bnez	a5,80000490 <Delay_ms+0x34>
800004a4:	fef44783          	lbu	a5,-17(s0)
800004a8:	fff78793          	addi	a5,a5,-1
800004ac:	fef407a3          	sb	a5,-17(s0)
800004b0:	fef44783          	lbu	a5,-17(s0)
800004b4:	fc079ee3          	bnez	a5,80000490 <Delay_ms+0x34>
800004b8:	fdc42783          	lw	a5,-36(s0)
800004bc:	fff78713          	addi	a4,a5,-1
800004c0:	fce42e23          	sw	a4,-36(s0)
800004c4:	fa0796e3          	bnez	a5,80000470 <Delay_ms+0x14>
800004c8:	00000013          	nop
800004cc:	02c12403          	lw	s0,44(sp)
800004d0:	03010113          	addi	sp,sp,48
800004d4:	00008067          	ret

800004d8 <OLED_Write_Byte>:
800004d8:	fe010113          	addi	sp,sp,-32
800004dc:	00112e23          	sw	ra,28(sp)
800004e0:	00812c23          	sw	s0,24(sp)
800004e4:	02010413          	addi	s0,sp,32
800004e8:	00050793          	mv	a5,a0
800004ec:	00058713          	mv	a4,a1
800004f0:	fef407a3          	sb	a5,-17(s0)
800004f4:	00070793          	mv	a5,a4
800004f8:	fef40723          	sb	a5,-18(s0)
800004fc:	c75ff0ef          	jal	ra,80000170 <I2C_Start>
80000500:	07800513          	li	a0,120
80000504:	e55ff0ef          	jal	ra,80000358 <I2C_Write_Byte>
80000508:	d8dff0ef          	jal	ra,80000294 <I2C_Wait_Ack>
8000050c:	fee44783          	lbu	a5,-18(s0)
80000510:	00078513          	mv	a0,a5
80000514:	e45ff0ef          	jal	ra,80000358 <I2C_Write_Byte>
80000518:	d7dff0ef          	jal	ra,80000294 <I2C_Wait_Ack>
8000051c:	fef44783          	lbu	a5,-17(s0)
80000520:	00078513          	mv	a0,a5
80000524:	e35ff0ef          	jal	ra,80000358 <I2C_Write_Byte>
80000528:	d6dff0ef          	jal	ra,80000294 <I2C_Wait_Ack>
8000052c:	ce5ff0ef          	jal	ra,80000210 <I2C_Stop>
80000530:	00000013          	nop
80000534:	01c12083          	lw	ra,28(sp)
80000538:	01812403          	lw	s0,24(sp)
8000053c:	02010113          	addi	sp,sp,32
80000540:	00008067          	ret

80000544 <OLED_Fill>:
80000544:	fd010113          	addi	sp,sp,-48
80000548:	02112623          	sw	ra,44(sp)
8000054c:	02812423          	sw	s0,40(sp)
80000550:	03010413          	addi	s0,sp,48
80000554:	00050793          	mv	a5,a0
80000558:	fcf40fa3          	sb	a5,-33(s0)
8000055c:	fe0407a3          	sb	zero,-17(s0)
80000560:	06c0006f          	j	800005cc <OLED_Fill+0x88>
80000564:	fef44783          	lbu	a5,-17(s0)
80000568:	fb078793          	addi	a5,a5,-80
8000056c:	0ff7f793          	andi	a5,a5,255
80000570:	00000593          	li	a1,0
80000574:	00078513          	mv	a0,a5
80000578:	f61ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
8000057c:	00000593          	li	a1,0
80000580:	01000513          	li	a0,16
80000584:	f55ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000588:	00000593          	li	a1,0
8000058c:	00000513          	li	a0,0
80000590:	f49ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000594:	fe040723          	sb	zero,-18(s0)
80000598:	0200006f          	j	800005b8 <OLED_Fill+0x74>
8000059c:	fdf44783          	lbu	a5,-33(s0)
800005a0:	04000593          	li	a1,64
800005a4:	00078513          	mv	a0,a5
800005a8:	f31ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800005ac:	fee44783          	lbu	a5,-18(s0)
800005b0:	00178793          	addi	a5,a5,1
800005b4:	fef40723          	sb	a5,-18(s0)
800005b8:	fee40783          	lb	a5,-18(s0)
800005bc:	fe07d0e3          	bgez	a5,8000059c <OLED_Fill+0x58>
800005c0:	fef44783          	lbu	a5,-17(s0)
800005c4:	00178793          	addi	a5,a5,1
800005c8:	fef407a3          	sb	a5,-17(s0)
800005cc:	fef44703          	lbu	a4,-17(s0)
800005d0:	00700793          	li	a5,7
800005d4:	f8e7f8e3          	bgeu	a5,a4,80000564 <OLED_Fill+0x20>
800005d8:	00000013          	nop
800005dc:	02c12083          	lw	ra,44(sp)
800005e0:	02812403          	lw	s0,40(sp)
800005e4:	03010113          	addi	sp,sp,48
800005e8:	00008067          	ret

800005ec <OLED_Set_Pos>:
800005ec:	fe010113          	addi	sp,sp,-32
800005f0:	00112e23          	sw	ra,28(sp)
800005f4:	00812c23          	sw	s0,24(sp)
800005f8:	02010413          	addi	s0,sp,32
800005fc:	00050793          	mv	a5,a0
80000600:	00058713          	mv	a4,a1
80000604:	fef407a3          	sb	a5,-17(s0)
80000608:	00070793          	mv	a5,a4
8000060c:	fef40723          	sb	a5,-18(s0)
80000610:	fee44783          	lbu	a5,-18(s0)
80000614:	fb078793          	addi	a5,a5,-80
80000618:	0ff7f793          	andi	a5,a5,255
8000061c:	00000593          	li	a1,0
80000620:	00078513          	mv	a0,a5
80000624:	eb5ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000628:	fef44783          	lbu	a5,-17(s0)
8000062c:	0047d793          	srli	a5,a5,0x4
80000630:	0ff7f793          	andi	a5,a5,255
80000634:	0107e793          	ori	a5,a5,16
80000638:	0ff7f793          	andi	a5,a5,255
8000063c:	00000593          	li	a1,0
80000640:	00078513          	mv	a0,a5
80000644:	e95ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000648:	fef44783          	lbu	a5,-17(s0)
8000064c:	00f7f793          	andi	a5,a5,15
80000650:	0ff7f793          	andi	a5,a5,255
80000654:	00000593          	li	a1,0
80000658:	00078513          	mv	a0,a5
8000065c:	e7dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000660:	00000013          	nop
80000664:	01c12083          	lw	ra,28(sp)
80000668:	01812403          	lw	s0,24(sp)
8000066c:	02010113          	addi	sp,sp,32
80000670:	00008067          	ret

80000674 <OLED_Init>:
80000674:	ff010113          	addi	sp,sp,-16
80000678:	00112623          	sw	ra,12(sp)
8000067c:	00812423          	sw	s0,8(sp)
80000680:	01010413          	addi	s0,sp,16
80000684:	0c800513          	li	a0,200
80000688:	dd5ff0ef          	jal	ra,8000045c <Delay_ms>
8000068c:	00000593          	li	a1,0
80000690:	0ae00513          	li	a0,174
80000694:	e45ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000698:	00000593          	li	a1,0
8000069c:	00000513          	li	a0,0
800006a0:	e39ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006a4:	00000593          	li	a1,0
800006a8:	01000513          	li	a0,16
800006ac:	e2dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006b0:	00000593          	li	a1,0
800006b4:	04000513          	li	a0,64
800006b8:	e21ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006bc:	00000593          	li	a1,0
800006c0:	0b000513          	li	a0,176
800006c4:	e15ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006c8:	00000593          	li	a1,0
800006cc:	08100513          	li	a0,129
800006d0:	e09ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006d4:	00000593          	li	a1,0
800006d8:	0ff00513          	li	a0,255
800006dc:	dfdff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006e0:	00000593          	li	a1,0
800006e4:	0a100513          	li	a0,161
800006e8:	df1ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006ec:	00000593          	li	a1,0
800006f0:	0a600513          	li	a0,166
800006f4:	de5ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800006f8:	00000593          	li	a1,0
800006fc:	0a800513          	li	a0,168
80000700:	dd9ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000704:	00000593          	li	a1,0
80000708:	03f00513          	li	a0,63
8000070c:	dcdff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000710:	00000593          	li	a1,0
80000714:	0c800513          	li	a0,200
80000718:	dc1ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
8000071c:	00000593          	li	a1,0
80000720:	0d300513          	li	a0,211
80000724:	db5ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000728:	00000593          	li	a1,0
8000072c:	00000513          	li	a0,0
80000730:	da9ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000734:	00000593          	li	a1,0
80000738:	0d500513          	li	a0,213
8000073c:	d9dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000740:	00000593          	li	a1,0
80000744:	08000513          	li	a0,128
80000748:	d91ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
8000074c:	00000593          	li	a1,0
80000750:	0d800513          	li	a0,216
80000754:	d85ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000758:	00000593          	li	a1,0
8000075c:	00500513          	li	a0,5
80000760:	d79ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000764:	00000593          	li	a1,0
80000768:	0d900513          	li	a0,217
8000076c:	d6dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000770:	00000593          	li	a1,0
80000774:	0f100513          	li	a0,241
80000778:	d61ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
8000077c:	00000593          	li	a1,0
80000780:	0da00513          	li	a0,218
80000784:	d55ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000788:	00000593          	li	a1,0
8000078c:	01200513          	li	a0,18
80000790:	d49ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000794:	00000593          	li	a1,0
80000798:	0db00513          	li	a0,219
8000079c:	d3dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007a0:	00000593          	li	a1,0
800007a4:	03000513          	li	a0,48
800007a8:	d31ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007ac:	00000593          	li	a1,0
800007b0:	08d00513          	li	a0,141
800007b4:	d25ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007b8:	00000593          	li	a1,0
800007bc:	01400513          	li	a0,20
800007c0:	d19ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007c4:	00000593          	li	a1,0
800007c8:	0a400513          	li	a0,164
800007cc:	d0dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007d0:	00000593          	li	a1,0
800007d4:	0a600513          	li	a0,166
800007d8:	d01ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007dc:	00000593          	li	a1,0
800007e0:	0af00513          	li	a0,175
800007e4:	cf5ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800007e8:	00000513          	li	a0,0
800007ec:	d59ff0ef          	jal	ra,80000544 <OLED_Fill>
800007f0:	00000013          	nop
800007f4:	00c12083          	lw	ra,12(sp)
800007f8:	00812403          	lw	s0,8(sp)
800007fc:	01010113          	addi	sp,sp,16
80000800:	00008067          	ret

80000804 <OLED_DisplayChar>:
80000804:	fd010113          	addi	sp,sp,-48
80000808:	02112623          	sw	ra,44(sp)
8000080c:	02812423          	sw	s0,40(sp)
80000810:	03010413          	addi	s0,sp,48
80000814:	00050793          	mv	a5,a0
80000818:	00058693          	mv	a3,a1
8000081c:	00060713          	mv	a4,a2
80000820:	fcf40fa3          	sb	a5,-33(s0)
80000824:	00068793          	mv	a5,a3
80000828:	fcf40f23          	sb	a5,-34(s0)
8000082c:	00070793          	mv	a5,a4
80000830:	fcf40ea3          	sb	a5,-35(s0)
80000834:	fe040723          	sb	zero,-18(s0)
80000838:	fdd44783          	lbu	a5,-35(s0)
8000083c:	fe078793          	addi	a5,a5,-32
80000840:	fef40723          	sb	a5,-18(s0)
80000844:	fde44703          	lbu	a4,-34(s0)
80000848:	fdf44783          	lbu	a5,-33(s0)
8000084c:	00070593          	mv	a1,a4
80000850:	00078513          	mv	a0,a5
80000854:	d99ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000858:	fe0407a3          	sb	zero,-17(s0)
8000085c:	0480006f          	j	800008a4 <OLED_DisplayChar+0xa0>
80000860:	fee44703          	lbu	a4,-18(s0)
80000864:	fef44683          	lbu	a3,-17(s0)
80000868:	80001637          	lui	a2,0x80001
8000086c:	00070793          	mv	a5,a4
80000870:	00179793          	slli	a5,a5,0x1
80000874:	00e787b3          	add	a5,a5,a4
80000878:	00179793          	slli	a5,a5,0x1
8000087c:	61c60713          	addi	a4,a2,1564 # 8000161c <ramod_val+0xfffffd3a>
80000880:	00e787b3          	add	a5,a5,a4
80000884:	00d787b3          	add	a5,a5,a3
80000888:	0007c783          	lbu	a5,0(a5)
8000088c:	04000593          	li	a1,64
80000890:	00078513          	mv	a0,a5
80000894:	c45ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000898:	fef44783          	lbu	a5,-17(s0)
8000089c:	00178793          	addi	a5,a5,1
800008a0:	fef407a3          	sb	a5,-17(s0)
800008a4:	fef44703          	lbu	a4,-17(s0)
800008a8:	00500793          	li	a5,5
800008ac:	fae7fae3          	bgeu	a5,a4,80000860 <OLED_DisplayChar+0x5c>
800008b0:	00000013          	nop
800008b4:	02c12083          	lw	ra,44(sp)
800008b8:	02812403          	lw	s0,40(sp)
800008bc:	03010113          	addi	sp,sp,48
800008c0:	00008067          	ret

800008c4 <OLED_DisplayStr>:
800008c4:	fd010113          	addi	sp,sp,-48
800008c8:	02112623          	sw	ra,44(sp)
800008cc:	02812423          	sw	s0,40(sp)
800008d0:	03010413          	addi	s0,sp,48
800008d4:	00050793          	mv	a5,a0
800008d8:	00058713          	mv	a4,a1
800008dc:	fcc42c23          	sw	a2,-40(s0)
800008e0:	fcd42a23          	sw	a3,-44(s0)
800008e4:	fcf40fa3          	sb	a5,-33(s0)
800008e8:	00070793          	mv	a5,a4
800008ec:	fcf40f23          	sb	a5,-34(s0)
800008f0:	fe042623          	sw	zero,-20(s0)
800008f4:	06c0006f          	j	80000960 <OLED_DisplayStr+0x9c>
800008f8:	fd442783          	lw	a5,-44(s0)
800008fc:	fff78793          	addi	a5,a5,-1
80000900:	fcf42a23          	sw	a5,-44(s0)
80000904:	fec42783          	lw	a5,-20(s0)
80000908:	fd842703          	lw	a4,-40(s0)
8000090c:	00f707b3          	add	a5,a4,a5
80000910:	0007c683          	lbu	a3,0(a5)
80000914:	fde44703          	lbu	a4,-34(s0)
80000918:	fdf44783          	lbu	a5,-33(s0)
8000091c:	00068613          	mv	a2,a3
80000920:	00070593          	mv	a1,a4
80000924:	00078513          	mv	a0,a5
80000928:	eddff0ef          	jal	ra,80000804 <OLED_DisplayChar>
8000092c:	fdf44783          	lbu	a5,-33(s0)
80000930:	00678793          	addi	a5,a5,6
80000934:	fcf40fa3          	sb	a5,-33(s0)
80000938:	fdf44703          	lbu	a4,-33(s0)
8000093c:	07a00793          	li	a5,122
80000940:	00e7fa63          	bgeu	a5,a4,80000954 <OLED_DisplayStr+0x90>
80000944:	fc040fa3          	sb	zero,-33(s0)
80000948:	fde44783          	lbu	a5,-34(s0)
8000094c:	00178793          	addi	a5,a5,1
80000950:	fcf40f23          	sb	a5,-34(s0)
80000954:	fec42783          	lw	a5,-20(s0)
80000958:	00178793          	addi	a5,a5,1
8000095c:	fef42623          	sw	a5,-20(s0)
80000960:	fd442783          	lw	a5,-44(s0)
80000964:	f8079ae3          	bnez	a5,800008f8 <OLED_DisplayStr+0x34>
80000968:	00000013          	nop
8000096c:	02c12083          	lw	ra,44(sp)
80000970:	02812403          	lw	s0,40(sp)
80000974:	03010113          	addi	sp,sp,48
80000978:	00008067          	ret

8000097c <OLED_Display_Dino>:
8000097c:	fd010113          	addi	sp,sp,-48
80000980:	02112623          	sw	ra,44(sp)
80000984:	02812423          	sw	s0,40(sp)
80000988:	03010413          	addi	s0,sp,48
8000098c:	00050793          	mv	a5,a0
80000990:	fcf40fa3          	sb	a5,-33(s0)
80000994:	fe0406a3          	sb	zero,-19(s0)
80000998:	fe040623          	sb	zero,-20(s0)
8000099c:	fdf44783          	lbu	a5,-33(s0)
800009a0:	0037d793          	srli	a5,a5,0x3
800009a4:	0ff7f793          	andi	a5,a5,255
800009a8:	00600713          	li	a4,6
800009ac:	40f707b3          	sub	a5,a4,a5
800009b0:	fef406a3          	sb	a5,-19(s0)
800009b4:	fdf44783          	lbu	a5,-33(s0)
800009b8:	0077f793          	andi	a5,a5,7
800009bc:	fef40623          	sb	a5,-20(s0)
800009c0:	fe0407a3          	sb	zero,-17(s0)
800009c4:	04c0006f          	j	80000a10 <OLED_Display_Dino+0x94>
800009c8:	fef44783          	lbu	a5,-17(s0)
800009cc:	00078593          	mv	a1,a5
800009d0:	00000513          	li	a0,0
800009d4:	c19ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
800009d8:	fe040723          	sb	zero,-18(s0)
800009dc:	01c0006f          	j	800009f8 <OLED_Display_Dino+0x7c>
800009e0:	04000593          	li	a1,64
800009e4:	00000513          	li	a0,0
800009e8:	af1ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
800009ec:	fee44783          	lbu	a5,-18(s0)
800009f0:	00178793          	addi	a5,a5,1
800009f4:	fef40723          	sb	a5,-18(s0)
800009f8:	fee44703          	lbu	a4,-18(s0)
800009fc:	00f00793          	li	a5,15
80000a00:	fee7f0e3          	bgeu	a5,a4,800009e0 <OLED_Display_Dino+0x64>
80000a04:	fef44783          	lbu	a5,-17(s0)
80000a08:	00178793          	addi	a5,a5,1
80000a0c:	fef407a3          	sb	a5,-17(s0)
80000a10:	fef44703          	lbu	a4,-17(s0)
80000a14:	00500793          	li	a5,5
80000a18:	fae7f8e3          	bgeu	a5,a4,800009c8 <OLED_Display_Dino+0x4c>
80000a1c:	fec44783          	lbu	a5,-20(s0)
80000a20:	18078863          	beqz	a5,80000bb0 <OLED_Display_Dino+0x234>
80000a24:	fed44783          	lbu	a5,-19(s0)
80000a28:	fff78793          	addi	a5,a5,-1
80000a2c:	fef406a3          	sb	a5,-19(s0)
80000a30:	fed44783          	lbu	a5,-19(s0)
80000a34:	00078593          	mv	a1,a5
80000a38:	00000513          	li	a0,0
80000a3c:	bb1ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000a40:	fe0407a3          	sb	zero,-17(s0)
80000a44:	0480006f          	j	80000a8c <OLED_Display_Dino+0x110>
80000a48:	fef44703          	lbu	a4,-17(s0)
80000a4c:	800027b7          	lui	a5,0x80002
80000a50:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80000a54:	00f707b3          	add	a5,a4,a5
80000a58:	0007c783          	lbu	a5,0(a5)
80000a5c:	00078693          	mv	a3,a5
80000a60:	fec44783          	lbu	a5,-20(s0)
80000a64:	00800713          	li	a4,8
80000a68:	40f707b3          	sub	a5,a4,a5
80000a6c:	00f697b3          	sll	a5,a3,a5
80000a70:	0ff7f793          	andi	a5,a5,255
80000a74:	04000593          	li	a1,64
80000a78:	00078513          	mv	a0,a5
80000a7c:	a5dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000a80:	fef44783          	lbu	a5,-17(s0)
80000a84:	00178793          	addi	a5,a5,1
80000a88:	fef407a3          	sb	a5,-17(s0)
80000a8c:	fef44703          	lbu	a4,-17(s0)
80000a90:	00f00793          	li	a5,15
80000a94:	fae7fae3          	bgeu	a5,a4,80000a48 <OLED_Display_Dino+0xcc>
80000a98:	fed44783          	lbu	a5,-19(s0)
80000a9c:	00178793          	addi	a5,a5,1
80000aa0:	0ff7f793          	andi	a5,a5,255
80000aa4:	00078593          	mv	a1,a5
80000aa8:	00000513          	li	a0,0
80000aac:	b41ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000ab0:	fe0407a3          	sb	zero,-17(s0)
80000ab4:	0840006f          	j	80000b38 <OLED_Display_Dino+0x1bc>
80000ab8:	fef44703          	lbu	a4,-17(s0)
80000abc:	800027b7          	lui	a5,0x80002
80000ac0:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80000ac4:	00f707b3          	add	a5,a4,a5
80000ac8:	0007c783          	lbu	a5,0(a5)
80000acc:	00078713          	mv	a4,a5
80000ad0:	fec44783          	lbu	a5,-20(s0)
80000ad4:	40f757b3          	sra	a5,a4,a5
80000ad8:	01879713          	slli	a4,a5,0x18
80000adc:	41875713          	srai	a4,a4,0x18
80000ae0:	fef44683          	lbu	a3,-17(s0)
80000ae4:	800027b7          	lui	a5,0x80002
80000ae8:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80000aec:	00f687b3          	add	a5,a3,a5
80000af0:	0107c783          	lbu	a5,16(a5)
80000af4:	00078613          	mv	a2,a5
80000af8:	fec44783          	lbu	a5,-20(s0)
80000afc:	00800693          	li	a3,8
80000b00:	40f687b3          	sub	a5,a3,a5
80000b04:	00f617b3          	sll	a5,a2,a5
80000b08:	01879793          	slli	a5,a5,0x18
80000b0c:	4187d793          	srai	a5,a5,0x18
80000b10:	00f767b3          	or	a5,a4,a5
80000b14:	01879793          	slli	a5,a5,0x18
80000b18:	4187d793          	srai	a5,a5,0x18
80000b1c:	0ff7f793          	andi	a5,a5,255
80000b20:	04000593          	li	a1,64
80000b24:	00078513          	mv	a0,a5
80000b28:	9b1ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000b2c:	fef44783          	lbu	a5,-17(s0)
80000b30:	00178793          	addi	a5,a5,1
80000b34:	fef407a3          	sb	a5,-17(s0)
80000b38:	fef44703          	lbu	a4,-17(s0)
80000b3c:	00f00793          	li	a5,15
80000b40:	f6e7fce3          	bgeu	a5,a4,80000ab8 <OLED_Display_Dino+0x13c>
80000b44:	fed44783          	lbu	a5,-19(s0)
80000b48:	00278793          	addi	a5,a5,2
80000b4c:	0ff7f793          	andi	a5,a5,255
80000b50:	00078593          	mv	a1,a5
80000b54:	00000513          	li	a0,0
80000b58:	a95ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000b5c:	fe0407a3          	sb	zero,-17(s0)
80000b60:	0400006f          	j	80000ba0 <OLED_Display_Dino+0x224>
80000b64:	fef44703          	lbu	a4,-17(s0)
80000b68:	800027b7          	lui	a5,0x80002
80000b6c:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80000b70:	00f707b3          	add	a5,a4,a5
80000b74:	0107c783          	lbu	a5,16(a5)
80000b78:	00078713          	mv	a4,a5
80000b7c:	fec44783          	lbu	a5,-20(s0)
80000b80:	40f757b3          	sra	a5,a4,a5
80000b84:	0ff7f793          	andi	a5,a5,255
80000b88:	04000593          	li	a1,64
80000b8c:	00078513          	mv	a0,a5
80000b90:	949ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000b94:	fef44783          	lbu	a5,-17(s0)
80000b98:	00178793          	addi	a5,a5,1
80000b9c:	fef407a3          	sb	a5,-17(s0)
80000ba0:	fef44703          	lbu	a4,-17(s0)
80000ba4:	00f00793          	li	a5,15
80000ba8:	fae7fee3          	bgeu	a5,a4,80000b64 <OLED_Display_Dino+0x1e8>
80000bac:	0ac0006f          	j	80000c58 <OLED_Display_Dino+0x2dc>
80000bb0:	fed44783          	lbu	a5,-19(s0)
80000bb4:	00078593          	mv	a1,a5
80000bb8:	00000513          	li	a0,0
80000bbc:	a31ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000bc0:	fe0407a3          	sb	zero,-17(s0)
80000bc4:	0300006f          	j	80000bf4 <OLED_Display_Dino+0x278>
80000bc8:	fef44703          	lbu	a4,-17(s0)
80000bcc:	800027b7          	lui	a5,0x80002
80000bd0:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80000bd4:	00f707b3          	add	a5,a4,a5
80000bd8:	0007c783          	lbu	a5,0(a5)
80000bdc:	04000593          	li	a1,64
80000be0:	00078513          	mv	a0,a5
80000be4:	8f5ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000be8:	fef44783          	lbu	a5,-17(s0)
80000bec:	00178793          	addi	a5,a5,1
80000bf0:	fef407a3          	sb	a5,-17(s0)
80000bf4:	fef44703          	lbu	a4,-17(s0)
80000bf8:	00f00793          	li	a5,15
80000bfc:	fce7f6e3          	bgeu	a5,a4,80000bc8 <OLED_Display_Dino+0x24c>
80000c00:	fed44783          	lbu	a5,-19(s0)
80000c04:	00178793          	addi	a5,a5,1
80000c08:	0ff7f793          	andi	a5,a5,255
80000c0c:	00078593          	mv	a1,a5
80000c10:	00000513          	li	a0,0
80000c14:	9d9ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000c18:	fe0407a3          	sb	zero,-17(s0)
80000c1c:	0300006f          	j	80000c4c <OLED_Display_Dino+0x2d0>
80000c20:	fef44703          	lbu	a4,-17(s0)
80000c24:	800027b7          	lui	a5,0x80002
80000c28:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80000c2c:	00f707b3          	add	a5,a4,a5
80000c30:	0107c783          	lbu	a5,16(a5)
80000c34:	04000593          	li	a1,64
80000c38:	00078513          	mv	a0,a5
80000c3c:	89dff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000c40:	fef44783          	lbu	a5,-17(s0)
80000c44:	00178793          	addi	a5,a5,1
80000c48:	fef407a3          	sb	a5,-17(s0)
80000c4c:	fef44703          	lbu	a4,-17(s0)
80000c50:	00f00793          	li	a5,15
80000c54:	fce7f6e3          	bgeu	a5,a4,80000c20 <OLED_Display_Dino+0x2a4>
80000c58:	00000013          	nop
80000c5c:	02c12083          	lw	ra,44(sp)
80000c60:	02812403          	lw	s0,40(sp)
80000c64:	03010113          	addi	sp,sp,48
80000c68:	00008067          	ret

80000c6c <OLED_Display_Cactus>:
80000c6c:	fd010113          	addi	sp,sp,-48
80000c70:	02112623          	sw	ra,44(sp)
80000c74:	02812423          	sw	s0,40(sp)
80000c78:	03010413          	addi	s0,sp,48
80000c7c:	00050793          	mv	a5,a0
80000c80:	fcf41f23          	sh	a5,-34(s0)
80000c84:	fe0407a3          	sb	zero,-17(s0)
80000c88:	00800793          	li	a5,8
80000c8c:	fef40723          	sb	a5,-18(s0)
80000c90:	fde41783          	lh	a5,-34(s0)
80000c94:	0007dc63          	bgez	a5,80000cac <OLED_Display_Cactus+0x40>
80000c98:	fde45783          	lhu	a5,-34(s0)
80000c9c:	0ff7f793          	andi	a5,a5,255
80000ca0:	40f007b3          	neg	a5,a5
80000ca4:	fef407a3          	sb	a5,-17(s0)
80000ca8:	fc041f23          	sh	zero,-34(s0)
80000cac:	fde41703          	lh	a4,-34(s0)
80000cb0:	07800793          	li	a5,120
80000cb4:	00e7dc63          	bge	a5,a4,80000ccc <OLED_Display_Cactus+0x60>
80000cb8:	fde45783          	lhu	a5,-34(s0)
80000cbc:	0ff7f793          	andi	a5,a5,255
80000cc0:	f8000713          	li	a4,-128
80000cc4:	40f707b3          	sub	a5,a4,a5
80000cc8:	fef40723          	sb	a5,-18(s0)
80000ccc:	fde45783          	lhu	a5,-34(s0)
80000cd0:	0ff7f793          	andi	a5,a5,255
80000cd4:	00600593          	li	a1,6
80000cd8:	00078513          	mv	a0,a5
80000cdc:	911ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000ce0:	fef44783          	lbu	a5,-17(s0)
80000ce4:	fef406a3          	sb	a5,-19(s0)
80000ce8:	0300006f          	j	80000d18 <OLED_Display_Cactus+0xac>
80000cec:	fed44703          	lbu	a4,-19(s0)
80000cf0:	800027b7          	lui	a5,0x80002
80000cf4:	88878793          	addi	a5,a5,-1912 # 80001888 <ramod_val+0xffffffa6>
80000cf8:	00f707b3          	add	a5,a4,a5
80000cfc:	0007c783          	lbu	a5,0(a5)
80000d00:	04000593          	li	a1,64
80000d04:	00078513          	mv	a0,a5
80000d08:	fd0ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000d0c:	fed44783          	lbu	a5,-19(s0)
80000d10:	00178793          	addi	a5,a5,1
80000d14:	fef406a3          	sb	a5,-19(s0)
80000d18:	fed44703          	lbu	a4,-19(s0)
80000d1c:	fee44783          	lbu	a5,-18(s0)
80000d20:	fcf766e3          	bltu	a4,a5,80000cec <OLED_Display_Cactus+0x80>
80000d24:	fde45783          	lhu	a5,-34(s0)
80000d28:	0ff7f793          	andi	a5,a5,255
80000d2c:	00700593          	li	a1,7
80000d30:	00078513          	mv	a0,a5
80000d34:	8b9ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000d38:	fef44783          	lbu	a5,-17(s0)
80000d3c:	fef406a3          	sb	a5,-19(s0)
80000d40:	0300006f          	j	80000d70 <OLED_Display_Cactus+0x104>
80000d44:	fed44703          	lbu	a4,-19(s0)
80000d48:	800027b7          	lui	a5,0x80002
80000d4c:	88878793          	addi	a5,a5,-1912 # 80001888 <ramod_val+0xffffffa6>
80000d50:	00f707b3          	add	a5,a4,a5
80000d54:	0087c783          	lbu	a5,8(a5)
80000d58:	04000593          	li	a1,64
80000d5c:	00078513          	mv	a0,a5
80000d60:	f78ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000d64:	fed44783          	lbu	a5,-19(s0)
80000d68:	00178793          	addi	a5,a5,1
80000d6c:	fef406a3          	sb	a5,-19(s0)
80000d70:	fed44703          	lbu	a4,-19(s0)
80000d74:	fee44783          	lbu	a5,-18(s0)
80000d78:	fcf766e3          	bltu	a4,a5,80000d44 <OLED_Display_Cactus+0xd8>
80000d7c:	00000013          	nop
80000d80:	02c12083          	lw	ra,44(sp)
80000d84:	02812403          	lw	s0,40(sp)
80000d88:	03010113          	addi	sp,sp,48
80000d8c:	00008067          	ret

80000d90 <OLED_Line>:
80000d90:	fd010113          	addi	sp,sp,-48
80000d94:	02112623          	sw	ra,44(sp)
80000d98:	02812423          	sw	s0,40(sp)
80000d9c:	03010413          	addi	s0,sp,48
80000da0:	00050793          	mv	a5,a0
80000da4:	00058713          	mv	a4,a1
80000da8:	fcf40fa3          	sb	a5,-33(s0)
80000dac:	00070793          	mv	a5,a4
80000db0:	fcf40f23          	sb	a5,-34(s0)
80000db4:	fdf40783          	lb	a5,-33(s0)
80000db8:	0a07c463          	bltz	a5,80000e60 <OLED_Line+0xd0>
80000dbc:	fdf44703          	lbu	a4,-33(s0)
80000dc0:	fde44783          	lbu	a5,-34(s0)
80000dc4:	00f70733          	add	a4,a4,a5
80000dc8:	08000793          	li	a5,128
80000dcc:	00e7dc63          	bge	a5,a4,80000de4 <OLED_Line+0x54>
80000dd0:	fdf44783          	lbu	a5,-33(s0)
80000dd4:	f8000713          	li	a4,-128
80000dd8:	40f707b3          	sub	a5,a4,a5
80000ddc:	fef407a3          	sb	a5,-17(s0)
80000de0:	00c0006f          	j	80000dec <OLED_Line+0x5c>
80000de4:	fde44783          	lbu	a5,-34(s0)
80000de8:	fef407a3          	sb	a5,-17(s0)
80000dec:	fdf44783          	lbu	a5,-33(s0)
80000df0:	00600593          	li	a1,6
80000df4:	00078513          	mv	a0,a5
80000df8:	ff4ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000dfc:	fef44783          	lbu	a5,-17(s0)
80000e00:	fcf40f23          	sb	a5,-34(s0)
80000e04:	0100006f          	j	80000e14 <OLED_Line+0x84>
80000e08:	04000593          	li	a1,64
80000e0c:	00000513          	li	a0,0
80000e10:	ec8ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000e14:	fde44783          	lbu	a5,-34(s0)
80000e18:	fff78713          	addi	a4,a5,-1
80000e1c:	fce40f23          	sb	a4,-34(s0)
80000e20:	fe0794e3          	bnez	a5,80000e08 <OLED_Line+0x78>
80000e24:	fef44783          	lbu	a5,-17(s0)
80000e28:	fcf40f23          	sb	a5,-34(s0)
80000e2c:	fdf44783          	lbu	a5,-33(s0)
80000e30:	00700593          	li	a1,7
80000e34:	00078513          	mv	a0,a5
80000e38:	fb4ff0ef          	jal	ra,800005ec <OLED_Set_Pos>
80000e3c:	0100006f          	j	80000e4c <OLED_Line+0xbc>
80000e40:	04000593          	li	a1,64
80000e44:	01000513          	li	a0,16
80000e48:	e90ff0ef          	jal	ra,800004d8 <OLED_Write_Byte>
80000e4c:	fde44783          	lbu	a5,-34(s0)
80000e50:	fff78713          	addi	a4,a5,-1
80000e54:	fce40f23          	sb	a4,-34(s0)
80000e58:	fe0794e3          	bnez	a5,80000e40 <OLED_Line+0xb0>
80000e5c:	0080006f          	j	80000e64 <OLED_Line+0xd4>
80000e60:	00000013          	nop
80000e64:	02c12083          	lw	ra,44(sp)
80000e68:	02812403          	lw	s0,40(sp)
80000e6c:	03010113          	addi	sp,sp,48
80000e70:	00008067          	ret

80000e74 <Ramod>:
80000e74:	ff010113          	addi	sp,sp,-16
80000e78:	00812623          	sw	s0,12(sp)
80000e7c:	01010413          	addi	s0,sp,16
80000e80:	800027b7          	lui	a5,0x80002
80000e84:	8e279783          	lh	a5,-1822(a5) # 800018e2 <ramod_val+0x0>
80000e88:	00078513          	mv	a0,a5
80000e8c:	00c12403          	lw	s0,12(sp)
80000e90:	01010113          	addi	sp,sp,16
80000e94:	00008067          	ret

80000e98 <Dino_Tick>:
80000e98:	ff010113          	addi	sp,sp,-16
80000e9c:	00812623          	sw	s0,12(sp)
80000ea0:	01010413          	addi	s0,sp,16
80000ea4:	800027b7          	lui	a5,0x80002
80000ea8:	8d07a783          	lw	a5,-1840(a5) # 800018d0 <ramod_val+0xffffffee>
80000eac:	00178713          	addi	a4,a5,1
80000eb0:	800027b7          	lui	a5,0x80002
80000eb4:	8ce7a823          	sw	a4,-1840(a5) # 800018d0 <ramod_val+0xffffffee>
80000eb8:	800027b7          	lui	a5,0x80002
80000ebc:	8d47a783          	lw	a5,-1836(a5) # 800018d4 <ramod_val+0xfffffff2>
80000ec0:	00178713          	addi	a4,a5,1
80000ec4:	800027b7          	lui	a5,0x80002
80000ec8:	8ce7aa23          	sw	a4,-1836(a5) # 800018d4 <ramod_val+0xfffffff2>
80000ecc:	f00007b7          	lui	a5,0xf0000
80000ed0:	0007a703          	lw	a4,0(a5) # f0000000 <ramod_val+0x6fffe71e>
80000ed4:	000107b7          	lui	a5,0x10
80000ed8:	00f777b3          	and	a5,a4,a5
80000edc:	06079c63          	bnez	a5,80000f54 <Dino_Tick+0xbc>
80000ee0:	800027b7          	lui	a5,0x80002
80000ee4:	8cc7a783          	lw	a5,-1844(a5) # 800018cc <ramod_val+0xffffffea>
80000ee8:	06078663          	beqz	a5,80000f54 <Dino_Tick+0xbc>
80000eec:	800027b7          	lui	a5,0x80002
80000ef0:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000ef4:	00078713          	mv	a4,a5
80000ef8:	800027b7          	lui	a5,0x80002
80000efc:	84478793          	addi	a5,a5,-1980 # 80001844 <ramod_val+0xffffff62>
80000f00:	00f707b3          	add	a5,a4,a5
80000f04:	0007c783          	lbu	a5,0(a5)
80000f08:	00078713          	mv	a4,a5
80000f0c:	800027b7          	lui	a5,0x80002
80000f10:	8d07a783          	lw	a5,-1840(a5) # 800018d0 <ramod_val+0xffffffee>
80000f14:	0cf75863          	bge	a4,a5,80000fe4 <Dino_Tick+0x14c>
80000f18:	800027b7          	lui	a5,0x80002
80000f1c:	8c07a823          	sw	zero,-1840(a5) # 800018d0 <ramod_val+0xffffffee>
80000f20:	800027b7          	lui	a5,0x80002
80000f24:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000f28:	00a78793          	addi	a5,a5,10
80000f2c:	0ff7f713          	andi	a4,a5,255
80000f30:	800027b7          	lui	a5,0x80002
80000f34:	8ee78023          	sb	a4,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000f38:	800027b7          	lui	a5,0x80002
80000f3c:	8e07c703          	lbu	a4,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000f40:	01e00793          	li	a5,30
80000f44:	0af71063          	bne	a4,a5,80000fe4 <Dino_Tick+0x14c>
80000f48:	800027b7          	lui	a5,0x80002
80000f4c:	8c07a623          	sw	zero,-1844(a5) # 800018cc <ramod_val+0xffffffea>
80000f50:	0940006f          	j	80000fe4 <Dino_Tick+0x14c>
80000f54:	800027b7          	lui	a5,0x80002
80000f58:	8c07a623          	sw	zero,-1844(a5) # 800018cc <ramod_val+0xffffffea>
80000f5c:	800027b7          	lui	a5,0x80002
80000f60:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000f64:	00078713          	mv	a4,a5
80000f68:	800027b7          	lui	a5,0x80002
80000f6c:	84478793          	addi	a5,a5,-1980 # 80001844 <ramod_val+0xffffff62>
80000f70:	00f707b3          	add	a5,a4,a5
80000f74:	0007c783          	lbu	a5,0(a5)
80000f78:	00078713          	mv	a4,a5
80000f7c:	800027b7          	lui	a5,0x80002
80000f80:	8d07a783          	lw	a5,-1840(a5) # 800018d0 <ramod_val+0xffffffee>
80000f84:	06f75263          	bge	a4,a5,80000fe8 <Dino_Tick+0x150>
80000f88:	800027b7          	lui	a5,0x80002
80000f8c:	8c07a823          	sw	zero,-1840(a5) # 800018d0 <ramod_val+0xffffffee>
80000f90:	800027b7          	lui	a5,0x80002
80000f94:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000f98:	00078e63          	beqz	a5,80000fb4 <Dino_Tick+0x11c>
80000f9c:	800027b7          	lui	a5,0x80002
80000fa0:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000fa4:	ff678793          	addi	a5,a5,-10
80000fa8:	0ff7f713          	andi	a4,a5,255
80000fac:	800027b7          	lui	a5,0x80002
80000fb0:	8ee78023          	sb	a4,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000fb4:	800027b7          	lui	a5,0x80002
80000fb8:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80000fbc:	02079663          	bnez	a5,80000fe8 <Dino_Tick+0x150>
80000fc0:	f00007b7          	lui	a5,0xf0000
80000fc4:	0007a703          	lw	a4,0(a5) # f0000000 <ramod_val+0x6fffe71e>
80000fc8:	000107b7          	lui	a5,0x10
80000fcc:	00f777b3          	and	a5,a4,a5
80000fd0:	00078c63          	beqz	a5,80000fe8 <Dino_Tick+0x150>
80000fd4:	800027b7          	lui	a5,0x80002
80000fd8:	00100713          	li	a4,1
80000fdc:	8ce7a623          	sw	a4,-1844(a5) # 800018cc <ramod_val+0xffffffea>
80000fe0:	0080006f          	j	80000fe8 <Dino_Tick+0x150>
80000fe4:	00000013          	nop
80000fe8:	800027b7          	lui	a5,0x80002
80000fec:	8d47a703          	lw	a4,-1836(a5) # 800018d4 <ramod_val+0xfffffff2>
80000ff0:	00200793          	li	a5,2
80000ff4:	0ef71c63          	bne	a4,a5,800010ec <Dino_Tick+0x254>
80000ff8:	800027b7          	lui	a5,0x80002
80000ffc:	8c07aa23          	sw	zero,-1836(a5) # 800018d4 <ramod_val+0xfffffff2>
80001000:	800027b7          	lui	a5,0x80002
80001004:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
80001008:	fff78713          	addi	a4,a5,-1
8000100c:	800027b7          	lui	a5,0x80002
80001010:	8ae7ac23          	sw	a4,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
80001014:	800027b7          	lui	a5,0x80002
80001018:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
8000101c:	0047a783          	lw	a5,4(a5)
80001020:	fff78713          	addi	a4,a5,-1
80001024:	800027b7          	lui	a5,0x80002
80001028:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
8000102c:	00e7a223          	sw	a4,4(a5)
80001030:	800027b7          	lui	a5,0x80002
80001034:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001038:	0087a783          	lw	a5,8(a5)
8000103c:	fff78713          	addi	a4,a5,-1
80001040:	800027b7          	lui	a5,0x80002
80001044:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001048:	00e7a423          	sw	a4,8(a5)
8000104c:	800027b7          	lui	a5,0x80002
80001050:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001054:	00c7a783          	lw	a5,12(a5)
80001058:	fff78713          	addi	a4,a5,-1
8000105c:	800027b7          	lui	a5,0x80002
80001060:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001064:	00e7a623          	sw	a4,12(a5)
80001068:	800027b7          	lui	a5,0x80002
8000106c:	8b87a703          	lw	a4,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
80001070:	ffb00793          	li	a5,-5
80001074:	06f75263          	bge	a4,a5,800010d8 <Dino_Tick+0x240>
80001078:	800027b7          	lui	a5,0x80002
8000107c:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001080:	0047a703          	lw	a4,4(a5)
80001084:	800027b7          	lui	a5,0x80002
80001088:	8ae7ac23          	sw	a4,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
8000108c:	800027b7          	lui	a5,0x80002
80001090:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001094:	0087a703          	lw	a4,8(a5)
80001098:	800027b7          	lui	a5,0x80002
8000109c:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
800010a0:	00e7a223          	sw	a4,4(a5)
800010a4:	800027b7          	lui	a5,0x80002
800010a8:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
800010ac:	00c7a703          	lw	a4,12(a5)
800010b0:	800027b7          	lui	a5,0x80002
800010b4:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
800010b8:	00e7a423          	sw	a4,8(a5)
800010bc:	800027b7          	lui	a5,0x80002
800010c0:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
800010c4:	00c7a783          	lw	a5,12(a5)
800010c8:	04b78713          	addi	a4,a5,75
800010cc:	800027b7          	lui	a5,0x80002
800010d0:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
800010d4:	00e7a623          	sw	a4,12(a5)
800010d8:	800027b7          	lui	a5,0x80002
800010dc:	8dc7a783          	lw	a5,-1828(a5) # 800018dc <ramod_val+0xfffffffa>
800010e0:	00178713          	addi	a4,a5,1
800010e4:	800027b7          	lui	a5,0x80002
800010e8:	8ce7ae23          	sw	a4,-1828(a5) # 800018dc <ramod_val+0xfffffffa>
800010ec:	00000013          	nop
800010f0:	00c12403          	lw	s0,12(sp)
800010f4:	01010113          	addi	sp,sp,16
800010f8:	00008067          	ret

800010fc <game_over>:
800010fc:	ff010113          	addi	sp,sp,-16
80001100:	00112623          	sw	ra,12(sp)
80001104:	00812423          	sw	s0,8(sp)
80001108:	01010413          	addi	s0,sp,16
8000110c:	00900693          	li	a3,9
80001110:	800017b7          	lui	a5,0x80001
80001114:	5f478613          	addi	a2,a5,1524 # 800015f4 <ramod_val+0xfffffd12>
80001118:	00300593          	li	a1,3
8000111c:	02300513          	li	a0,35
80001120:	fa4ff0ef          	jal	ra,800008c4 <OLED_DisplayStr>
80001124:	800027b7          	lui	a5,0x80002
80001128:	8c07ae23          	sw	zero,-1828(a5) # 800018dc <ramod_val+0xfffffffa>
8000112c:	3e800513          	li	a0,1000
80001130:	b2cff0ef          	jal	ra,8000045c <Delay_ms>
80001134:	f00007b7          	lui	a5,0xf0000
80001138:	0007a703          	lw	a4,0(a5) # f0000000 <ramod_val+0x6fffe71e>
8000113c:	000107b7          	lui	a5,0x10
80001140:	00f777b3          	and	a5,a4,a5
80001144:	fe0798e3          	bnez	a5,80001134 <game_over+0x38>
80001148:	00000513          	li	a0,0
8000114c:	bf8ff0ef          	jal	ra,80000544 <OLED_Fill>
80001150:	800027b7          	lui	a5,0x80002
80001154:	06400713          	li	a4,100
80001158:	8ae7ac23          	sw	a4,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
8000115c:	800027b7          	lui	a5,0x80002
80001160:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001164:	0c800713          	li	a4,200
80001168:	00e7a223          	sw	a4,4(a5)
8000116c:	800027b7          	lui	a5,0x80002
80001170:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001174:	12c00713          	li	a4,300
80001178:	00e7a423          	sw	a4,8(a5)
8000117c:	800027b7          	lui	a5,0x80002
80001180:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001184:	19000713          	li	a4,400
80001188:	00e7a623          	sw	a4,12(a5)
8000118c:	00400693          	li	a3,4
80001190:	800017b7          	lui	a5,0x80001
80001194:	60078613          	addi	a2,a5,1536 # 80001600 <ramod_val+0xfffffd1e>
80001198:	00000593          	li	a1,0
8000119c:	06400513          	li	a0,100
800011a0:	f24ff0ef          	jal	ra,800008c4 <OLED_DisplayStr>
800011a4:	00000013          	nop
800011a8:	00000013          	nop
800011ac:	00c12083          	lw	ra,12(sp)
800011b0:	00812403          	lw	s0,8(sp)
800011b4:	01010113          	addi	sp,sp,16
800011b8:	00008067          	ret

800011bc <ulong_to_hex>:
800011bc:	fc010113          	addi	sp,sp,-64
800011c0:	02812e23          	sw	s0,60(sp)
800011c4:	04010413          	addi	s0,sp,64
800011c8:	fca42623          	sw	a0,-52(s0)
800011cc:	fcb42423          	sw	a1,-56(s0)
800011d0:	800017b7          	lui	a5,0x80001
800011d4:	6087a583          	lw	a1,1544(a5) # 80001608 <ramod_val+0xfffffd26>
800011d8:	60878713          	addi	a4,a5,1544
800011dc:	00472603          	lw	a2,4(a4)
800011e0:	60878713          	addi	a4,a5,1544
800011e4:	00872683          	lw	a3,8(a4)
800011e8:	60878713          	addi	a4,a5,1544
800011ec:	00c72703          	lw	a4,12(a4)
800011f0:	fcb42c23          	sw	a1,-40(s0)
800011f4:	fcc42e23          	sw	a2,-36(s0)
800011f8:	fed42023          	sw	a3,-32(s0)
800011fc:	fee42223          	sw	a4,-28(s0)
80001200:	60878793          	addi	a5,a5,1544
80001204:	0107c783          	lbu	a5,16(a5)
80001208:	fef40423          	sb	a5,-24(s0)
8000120c:	00700793          	li	a5,7
80001210:	fef42623          	sw	a5,-20(s0)
80001214:	0500006f          	j	80001264 <ulong_to_hex+0xa8>
80001218:	fcc42783          	lw	a5,-52(s0)
8000121c:	0ff7f793          	andi	a5,a5,255
80001220:	00f7f793          	andi	a5,a5,15
80001224:	fef405a3          	sb	a5,-21(s0)
80001228:	fcc42783          	lw	a5,-52(s0)
8000122c:	0047d793          	srli	a5,a5,0x4
80001230:	fcf42623          	sw	a5,-52(s0)
80001234:	feb44703          	lbu	a4,-21(s0)
80001238:	fec42783          	lw	a5,-20(s0)
8000123c:	00278793          	addi	a5,a5,2
80001240:	fc842683          	lw	a3,-56(s0)
80001244:	00f687b3          	add	a5,a3,a5
80001248:	ff040693          	addi	a3,s0,-16
8000124c:	00e68733          	add	a4,a3,a4
80001250:	fe874703          	lbu	a4,-24(a4)
80001254:	00e78023          	sb	a4,0(a5)
80001258:	fec42783          	lw	a5,-20(s0)
8000125c:	fff78793          	addi	a5,a5,-1
80001260:	fef42623          	sw	a5,-20(s0)
80001264:	fec42783          	lw	a5,-20(s0)
80001268:	fa07d8e3          	bgez	a5,80001218 <ulong_to_hex+0x5c>
8000126c:	00000013          	nop
80001270:	03c12403          	lw	s0,60(sp)
80001274:	04010113          	addi	sp,sp,64
80001278:	00008067          	ret

8000127c <Dino_Start>:
8000127c:	fc010113          	addi	sp,sp,-64
80001280:	02112e23          	sw	ra,60(sp)
80001284:	02812c23          	sw	s0,56(sp)
80001288:	04010413          	addi	s0,sp,64
8000128c:	fe041723          	sh	zero,-18(s0)
80001290:	fe042223          	sw	zero,-28(s0)
80001294:	fe442783          	lw	a5,-28(s0)
80001298:	fef42023          	sw	a5,-32(s0)
8000129c:	03200793          	li	a5,50
800012a0:	fcf42e23          	sw	a5,-36(s0)
800012a4:	bf5ff0ef          	jal	ra,80000e98 <Dino_Tick>
800012a8:	800027b7          	lui	a5,0x80002
800012ac:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
800012b0:	02f05663          	blez	a5,800012dc <Dino_Start+0x60>
800012b4:	800027b7          	lui	a5,0x80002
800012b8:	8e07c703          	lbu	a4,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
800012bc:	00400793          	li	a5,4
800012c0:	00e7fe63          	bgeu	a5,a4,800012dc <Dino_Start+0x60>
800012c4:	800027b7          	lui	a5,0x80002
800012c8:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
800012cc:	0ff7f793          	andi	a5,a5,255
800012d0:	00078593          	mv	a1,a5
800012d4:	00000513          	li	a0,0
800012d8:	ab9ff0ef          	jal	ra,80000d90 <OLED_Line>
800012dc:	fe041723          	sh	zero,-18(s0)
800012e0:	0f80006f          	j	800013d8 <Dino_Start+0x15c>
800012e4:	fee41703          	lh	a4,-18(s0)
800012e8:	00100793          	li	a5,1
800012ec:	00f71a63          	bne	a4,a5,80001300 <Dino_Start+0x84>
800012f0:	800027b7          	lui	a5,0x80002
800012f4:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
800012f8:	00078513          	mv	a0,a5
800012fc:	e80ff0ef          	jal	ra,8000097c <OLED_Display_Dino>
80001300:	fee41703          	lh	a4,-18(s0)
80001304:	800027b7          	lui	a5,0x80002
80001308:	00271713          	slli	a4,a4,0x2
8000130c:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001310:	00f707b3          	add	a5,a4,a5
80001314:	0007a703          	lw	a4,0(a5)
80001318:	07d00793          	li	a5,125
8000131c:	0ae7c063          	blt	a5,a4,800013bc <Dino_Start+0x140>
80001320:	fee41703          	lh	a4,-18(s0)
80001324:	800027b7          	lui	a5,0x80002
80001328:	00271713          	slli	a4,a4,0x2
8000132c:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001330:	00f707b3          	add	a5,a4,a5
80001334:	0007a783          	lw	a5,0(a5)
80001338:	01079793          	slli	a5,a5,0x10
8000133c:	4107d793          	srai	a5,a5,0x10
80001340:	00078513          	mv	a0,a5
80001344:	929ff0ef          	jal	ra,80000c6c <OLED_Display_Cactus>
80001348:	fee41703          	lh	a4,-18(s0)
8000134c:	800027b7          	lui	a5,0x80002
80001350:	00271713          	slli	a4,a4,0x2
80001354:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001358:	00f707b3          	add	a5,a4,a5
8000135c:	0007a783          	lw	a5,0(a5)
80001360:	0ff7f793          	andi	a5,a5,255
80001364:	00878793          	addi	a5,a5,8
80001368:	0ff7f613          	andi	a2,a5,255
8000136c:	fee41783          	lh	a5,-18(s0)
80001370:	00178713          	addi	a4,a5,1
80001374:	800027b7          	lui	a5,0x80002
80001378:	00271713          	slli	a4,a4,0x2
8000137c:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
80001380:	00f707b3          	add	a5,a4,a5
80001384:	0007a783          	lw	a5,0(a5)
80001388:	0ff7f713          	andi	a4,a5,255
8000138c:	fee41683          	lh	a3,-18(s0)
80001390:	800027b7          	lui	a5,0x80002
80001394:	00269693          	slli	a3,a3,0x2
80001398:	8b878793          	addi	a5,a5,-1864 # 800018b8 <ramod_val+0xffffffd6>
8000139c:	00f687b3          	add	a5,a3,a5
800013a0:	0007a783          	lw	a5,0(a5)
800013a4:	0ff7f793          	andi	a5,a5,255
800013a8:	40f707b3          	sub	a5,a4,a5
800013ac:	0ff7f793          	andi	a5,a5,255
800013b0:	00078593          	mv	a1,a5
800013b4:	00060513          	mv	a0,a2
800013b8:	9d9ff0ef          	jal	ra,80000d90 <OLED_Line>
800013bc:	fee41783          	lh	a5,-18(s0)
800013c0:	01079793          	slli	a5,a5,0x10
800013c4:	0107d793          	srli	a5,a5,0x10
800013c8:	00178793          	addi	a5,a5,1
800013cc:	01079793          	slli	a5,a5,0x10
800013d0:	0107d793          	srli	a5,a5,0x10
800013d4:	fef41723          	sh	a5,-18(s0)
800013d8:	fee41703          	lh	a4,-18(s0)
800013dc:	00200793          	li	a5,2
800013e0:	f0e7d2e3          	bge	a5,a4,800012e4 <Dino_Start+0x68>
800013e4:	800027b7          	lui	a5,0x80002
800013e8:	8b87a703          	lw	a4,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
800013ec:	00f00793          	li	a5,15
800013f0:	18e7c063          	blt	a5,a4,80001570 <Dino_Start+0x2f4>
800013f4:	800027b7          	lui	a5,0x80002
800013f8:	8e07c703          	lbu	a4,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
800013fc:	00f00793          	li	a5,15
80001400:	16e7e863          	bltu	a5,a4,80001570 <Dino_Start+0x2f4>
80001404:	800027b7          	lui	a5,0x80002
80001408:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
8000140c:	02f05863          	blez	a5,8000143c <Dino_Start+0x1c0>
80001410:	fe0406a3          	sb	zero,-19(s0)
80001414:	800027b7          	lui	a5,0x80002
80001418:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
8000141c:	fef40623          	sb	a5,-20(s0)
80001420:	800027b7          	lui	a5,0x80002
80001424:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
80001428:	0ff7f793          	andi	a5,a5,255
8000142c:	01000713          	li	a4,16
80001430:	40f707b3          	sub	a5,a4,a5
80001434:	fef405a3          	sb	a5,-21(s0)
80001438:	1280006f          	j	80001560 <Dino_Start+0x2e4>
8000143c:	800027b7          	lui	a5,0x80002
80001440:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
80001444:	0ff7f793          	andi	a5,a5,255
80001448:	40f007b3          	neg	a5,a5
8000144c:	fef406a3          	sb	a5,-19(s0)
80001450:	fe040623          	sb	zero,-20(s0)
80001454:	800027b7          	lui	a5,0x80002
80001458:	8b87a783          	lw	a5,-1864(a5) # 800018b8 <ramod_val+0xffffffd6>
8000145c:	0ff7f793          	andi	a5,a5,255
80001460:	00878793          	addi	a5,a5,8
80001464:	fef405a3          	sb	a5,-21(s0)
80001468:	0f80006f          	j	80001560 <Dino_Start+0x2e4>
8000146c:	800027b7          	lui	a5,0x80002
80001470:	8e07c703          	lbu	a4,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80001474:	00800793          	li	a5,8
80001478:	04e7fa63          	bgeu	a5,a4,800014cc <Dino_Start+0x250>
8000147c:	fed44703          	lbu	a4,-19(s0)
80001480:	800027b7          	lui	a5,0x80002
80001484:	88878793          	addi	a5,a5,-1912 # 80001888 <ramod_val+0xffffffa6>
80001488:	00f707b3          	add	a5,a4,a5
8000148c:	0007c783          	lbu	a5,0(a5)
80001490:	00078693          	mv	a3,a5
80001494:	fec44703          	lbu	a4,-20(s0)
80001498:	800027b7          	lui	a5,0x80002
8000149c:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
800014a0:	00f707b3          	add	a5,a4,a5
800014a4:	0107c783          	lbu	a5,16(a5)
800014a8:	00078713          	mv	a4,a5
800014ac:	800027b7          	lui	a5,0x80002
800014b0:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
800014b4:	ff878793          	addi	a5,a5,-8
800014b8:	40f757b3          	sra	a5,a4,a5
800014bc:	00f6f7b3          	and	a5,a3,a5
800014c0:	08078463          	beqz	a5,80001548 <Dino_Start+0x2cc>
800014c4:	c39ff0ef          	jal	ra,800010fc <game_over>
800014c8:	0800006f          	j	80001548 <Dino_Start+0x2cc>
800014cc:	fed44703          	lbu	a4,-19(s0)
800014d0:	800027b7          	lui	a5,0x80002
800014d4:	88878793          	addi	a5,a5,-1912 # 80001888 <ramod_val+0xffffffa6>
800014d8:	00f707b3          	add	a5,a4,a5
800014dc:	0007c783          	lbu	a5,0(a5)
800014e0:	00078613          	mv	a2,a5
800014e4:	fec44703          	lbu	a4,-20(s0)
800014e8:	800027b7          	lui	a5,0x80002
800014ec:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
800014f0:	00f707b3          	add	a5,a4,a5
800014f4:	0007c783          	lbu	a5,0(a5)
800014f8:	00078713          	mv	a4,a5
800014fc:	800027b7          	lui	a5,0x80002
80001500:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80001504:	40f75733          	sra	a4,a4,a5
80001508:	fec44683          	lbu	a3,-20(s0)
8000150c:	800027b7          	lui	a5,0x80002
80001510:	89878793          	addi	a5,a5,-1896 # 80001898 <ramod_val+0xffffffb6>
80001514:	00f687b3          	add	a5,a3,a5
80001518:	0107c783          	lbu	a5,16(a5)
8000151c:	00078693          	mv	a3,a5
80001520:	800027b7          	lui	a5,0x80002
80001524:	8e07c783          	lbu	a5,-1824(a5) # 800018e0 <ramod_val+0xfffffffe>
80001528:	00078593          	mv	a1,a5
8000152c:	00800793          	li	a5,8
80001530:	40b787b3          	sub	a5,a5,a1
80001534:	00f697b3          	sll	a5,a3,a5
80001538:	00f767b3          	or	a5,a4,a5
8000153c:	00f677b3          	and	a5,a2,a5
80001540:	00078463          	beqz	a5,80001548 <Dino_Start+0x2cc>
80001544:	bb9ff0ef          	jal	ra,800010fc <game_over>
80001548:	fed44783          	lbu	a5,-19(s0)
8000154c:	00178793          	addi	a5,a5,1
80001550:	fef406a3          	sb	a5,-19(s0)
80001554:	fec44783          	lbu	a5,-20(s0)
80001558:	00178793          	addi	a5,a5,1
8000155c:	fef40623          	sb	a5,-20(s0)
80001560:	feb44783          	lbu	a5,-21(s0)
80001564:	fff78713          	addi	a4,a5,-1
80001568:	fee405a3          	sb	a4,-21(s0)
8000156c:	f00790e3          	bnez	a5,8000146c <Dino_Start+0x1f0>
80001570:	800027b7          	lui	a5,0x80002
80001574:	8dc7a783          	lw	a5,-1828(a5) # 800018dc <ramod_val+0xfffffffa>
80001578:	0017d793          	srli	a5,a5,0x1
8000157c:	fcf42c23          	sw	a5,-40(s0)
80001580:	800027b7          	lui	a5,0x80002
80001584:	8d87a783          	lw	a5,-1832(a5) # 800018d8 <ramod_val+0xfffffff6>
80001588:	fd842703          	lw	a4,-40(s0)
8000158c:	d0f70ce3          	beq	a4,a5,800012a4 <Dino_Start+0x28>
80001590:	800027b7          	lui	a5,0x80002
80001594:	fd842703          	lw	a4,-40(s0)
80001598:	8ce7ac23          	sw	a4,-1832(a5) # 800018d8 <ramod_val+0xfffffff6>
8000159c:	fc040823          	sb	zero,-48(s0)
800015a0:	06d00793          	li	a5,109
800015a4:	fcf407a3          	sb	a5,-49(s0)
800015a8:	06b00793          	li	a5,107
800015ac:	fcf40723          	sb	a5,-50(s0)
800015b0:	07800793          	li	a5,120
800015b4:	fcf402a3          	sb	a5,-59(s0)
800015b8:	03000793          	li	a5,48
800015bc:	fcf40223          	sb	a5,-60(s0)
800015c0:	fc440793          	addi	a5,s0,-60
800015c4:	00078593          	mv	a1,a5
800015c8:	fd842503          	lw	a0,-40(s0)
800015cc:	bf1ff0ef          	jal	ra,800011bc <ulong_to_hex>
800015d0:	fc440793          	addi	a5,s0,-60
800015d4:	00c00693          	li	a3,12
800015d8:	00078613          	mv	a2,a5
800015dc:	00000593          	li	a1,0
800015e0:	01000513          	li	a0,16
800015e4:	ae0ff0ef          	jal	ra,800008c4 <OLED_DisplayStr>
800015e8:	cbdff06f          	j	800012a4 <Dino_Start+0x28>

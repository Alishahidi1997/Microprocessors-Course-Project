
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _used=R4
	.DEF _used_msb=R5
	.DEF __lcd_x=R7
	.DEF __lcd_y=R6
	.DEF __lcd_maxx=R9

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0

_0x3:
	.DB  0x20,0x0,0x30,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x2E,0x0,0x2C,0x0,0x3F,0x0
	.DB  0x21,0x0,0x31,0x0,0x61,0x0,0x62,0x0
	.DB  0x63,0x0,0x32,0x0,0x0,0x0,0x64,0x0
	.DB  0x65,0x0,0x66,0x0,0x33,0x0,0x0,0x0
	.DB  0x67,0x0,0x68,0x0,0x69,0x0,0x34,0x0
	.DB  0x0,0x0,0x6A,0x0,0x6B,0x0,0x6C,0x0
	.DB  0x35,0x0,0x0,0x0,0x6D,0x0,0x6E,0x0
	.DB  0x6F,0x0,0x36,0x0,0x0,0x0,0x70,0x0
	.DB  0x71,0x0,0x72,0x0,0x73,0x0,0x37,0x0
	.DB  0x74,0x0,0x75,0x0,0x76,0x0,0x38,0x0
	.DB  0x0,0x0,0x77,0x0,0x78,0x0,0x79,0x0
	.DB  0x7A,0x0,0x39
_0x0:
	.DB  0x20,0x20,0x20,0x53,0x61,0x76,0x69,0x6E
	.DB  0x67,0x2E,0x2E,0x2E,0x2E,0x20,0x20,0x20
	.DB  0x0,0x25,0x33,0x64,0x0,0x20,0x20,0x20
	.DB  0x4C,0x6F,0x61,0x64,0x69,0x6E,0x67,0x2E
	.DB  0x2E,0x2E,0x20,0x20,0x20,0x0,0x25,0x73
	.DB  0x0,0x25,0x31,0x36,0x73,0x0,0x20,0x20
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x20,0x6E
	.DB  0x61,0x6D,0x65,0x3A,0x20,0x20,0x0,0x20
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x20,0x6E
	.DB  0x75,0x6D,0x62,0x65,0x72,0x3A,0x20,0x0
	.DB  0x43,0x68,0x6F,0x6F,0x73,0x65,0x20,0x74
	.DB  0x6F,0x20,0x64,0x65,0x6C,0x65,0x74,0x65
	.DB  0x0,0x4E,0x61,0x6D,0x65,0x2C,0x50,0x68
	.DB  0x6F,0x6E,0x65,0xA,0x0,0x25,0x73,0x2C
	.DB  0x25,0x73,0x0,0x20,0x20,0x20,0x50,0x68
	.DB  0x6F,0x6E,0x65,0x20,0x42,0x6F,0x6F,0x6B
	.DB  0x20,0x20,0x20,0x0,0x53,0x68,0x61,0x68
	.DB  0x69,0x64,0x69,0x20,0x20,0x41,0x64,0x69
	.DB  0x62,0x6E,0x69,0x61,0x0,0x52,0x65,0x70
	.DB  0x6F,0x72,0x74,0x0,0x55,0x6E,0x6B,0x6E
	.DB  0x6F,0x77,0x6E,0x20,0x43,0x6F,0x6D,0x6D
	.DB  0x61,0x6E,0x64,0x21,0xA,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x63
	.DW  _alpha
	.DW  _0x3*2

	.DW  0x11
	.DW  _0xBA
	.DW  _0x0*2+115

	.DW  0x11
	.DW  _0xBA+17
	.DW  _0x0*2+132

	.DW  0x07
	.DW  _0xBA+34
	.DW  _0x0*2+149

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 1/27/2018
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <delay.h>
;#include <stdio.h>
;#include <string.h>
;
;#define ISDATAREADY (UCSRA)&(1<<RXC)
;
;int alpha[10][5] = {
;    {' ','0',0x00,0x00,0x00},
;    {'.',',','?','!','1'},
;    {'a','b','c','2',0x00},
;    {'d','e','f','3',0x00},
;    {'g','h','i','4',0x00},
;    {'j','k','l','5',0x00},
;    {'m','n','o','6',0x00},
;    {'p','q','r','s','7'},
;    {'t','u','v','8',0x00},
;    {'w','x','y','z','9'},
;};

	.DSEG
;
;char db[32][27];
;int used = 0;
;eeprom char saved_db[32][32]; //1KB EEPORM
;char str[40];
;
;char get_key(){
; 0000 0032 char get_key(){

	.CSEG
_get_key:
; .FSTART _get_key
; 0000 0033     PORTB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x18,R30
; 0000 0034     PORTB.4 = 0;
	CBI  0x18,4
; 0000 0035     delay_ms(10);
	CALL SUBOPT_0x0
; 0000 0036     if ( !PINB.0 ) return 'D';
	SBIC 0x16,0
	RJMP _0x6
	LDI  R30,LOW(68)
	RET
; 0000 0037     if ( !PINB.1 ) return '#';
_0x6:
	SBIC 0x16,1
	RJMP _0x7
	LDI  R30,LOW(35)
	RET
; 0000 0038     if ( !PINB.2 ) return '0';
_0x7:
	SBIC 0x16,2
	RJMP _0x8
	LDI  R30,LOW(48)
	RET
; 0000 0039     if ( !PINB.3 ) return '*';
_0x8:
	SBIC 0x16,3
	RJMP _0x9
	LDI  R30,LOW(42)
	RET
; 0000 003A     PORTB.4 = 1;
_0x9:
	SBI  0x18,4
; 0000 003B     PORTB.5 = 0;
	CBI  0x18,5
; 0000 003C     delay_ms(10);
	CALL SUBOPT_0x0
; 0000 003D     if ( !PINB.0 ) return 'C';
	SBIC 0x16,0
	RJMP _0xE
	LDI  R30,LOW(67)
	RET
; 0000 003E     if ( !PINB.1 ) return '9';
_0xE:
	SBIC 0x16,1
	RJMP _0xF
	LDI  R30,LOW(57)
	RET
; 0000 003F     if ( !PINB.2 ) return '8';
_0xF:
	SBIC 0x16,2
	RJMP _0x10
	LDI  R30,LOW(56)
	RET
; 0000 0040     if ( !PINB.3 ) return '7';
_0x10:
	SBIC 0x16,3
	RJMP _0x11
	LDI  R30,LOW(55)
	RET
; 0000 0041     PORTB.5 = 1;
_0x11:
	SBI  0x18,5
; 0000 0042     PORTB.6 = 0;
	CBI  0x18,6
; 0000 0043     delay_ms(10);
	CALL SUBOPT_0x0
; 0000 0044     if ( !PINB.0 ) return 'B';
	SBIC 0x16,0
	RJMP _0x16
	LDI  R30,LOW(66)
	RET
; 0000 0045     if ( !PINB.1 ) return '6';
_0x16:
	SBIC 0x16,1
	RJMP _0x17
	LDI  R30,LOW(54)
	RET
; 0000 0046     if ( !PINB.2 ) return '5';
_0x17:
	SBIC 0x16,2
	RJMP _0x18
	LDI  R30,LOW(53)
	RET
; 0000 0047     if ( !PINB.3 ) return '4';
_0x18:
	SBIC 0x16,3
	RJMP _0x19
	LDI  R30,LOW(52)
	RET
; 0000 0048     PORTB.6 = 1;
_0x19:
	SBI  0x18,6
; 0000 0049     PORTB.7 = 0;
	CBI  0x18,7
; 0000 004A     delay_ms(10);
	CALL SUBOPT_0x0
; 0000 004B     if ( !PINB.0 ) return 'A';
	SBIC 0x16,0
	RJMP _0x1E
	LDI  R30,LOW(65)
	RET
; 0000 004C     if ( !PINB.1 ) return '3';
_0x1E:
	SBIC 0x16,1
	RJMP _0x1F
	LDI  R30,LOW(51)
	RET
; 0000 004D     if ( !PINB.2 ) return '2';
_0x1F:
	SBIC 0x16,2
	RJMP _0x20
	LDI  R30,LOW(50)
	RET
; 0000 004E     if ( !PINB.3 ) return '1';
_0x20:
	SBIC 0x16,3
	RJMP _0x21
	LDI  R30,LOW(49)
	RET
; 0000 004F     PORTB.7 = 1;
_0x21:
	SBI  0x18,7
; 0000 0050     return 0;
	LDI  R30,LOW(0)
	RET
; 0000 0051 }
; .FEND
;
;int write_alpha ( char name[17] ){
; 0000 0053 int write_alpha ( char name[17] ){
_write_alpha:
; .FSTART _write_alpha
; 0000 0054     int i, nowat=0, index=0;
; 0000 0055     char ch, tch;
; 0000 0056     while (1){
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,2
	CALL __SAVELOCR6
;	name -> Y+8
;	i -> R16,R17
;	nowat -> R18,R19
;	index -> R20,R21
;	ch -> Y+7
;	tch -> Y+6
	__GETWRN 18,19,0
	__GETWRN 20,21,0
_0x24:
; 0000 0057         ch = get_key();
	RCALL _get_key
	STD  Y+7,R30
; 0000 0058         if ( ch == 'D' && index > 0 )
	LDD  R26,Y+7
	CPI  R26,LOW(0x44)
	BRNE _0x28
	CLR  R0
	CP   R0,R20
	CPC  R0,R21
	BRLT _0x29
_0x28:
	RJMP _0x27
_0x29:
; 0000 0059             return 1;
	RJMP _0x208000E
; 0000 005A         if ( ch == 'D' && index == 0 )
_0x27:
	LDD  R26,Y+7
	CPI  R26,LOW(0x44)
	BRNE _0x2B
	CLR  R0
	CP   R0,R20
	CPC  R0,R21
	BREQ _0x2C
_0x2B:
	RJMP _0x2A
_0x2C:
; 0000 005B             return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x208000D
; 0000 005C         if ( ch == '*' && index > 0 ){
_0x2A:
	LDD  R26,Y+7
	CPI  R26,LOW(0x2A)
	BRNE _0x2E
	CLR  R0
	CP   R0,R20
	CPC  R0,R21
	BRLT _0x2F
_0x2E:
	RJMP _0x2D
_0x2F:
; 0000 005D             lcd_gotoxy(index,1);
	CALL SUBOPT_0x1
; 0000 005E             lcd_putchar(' ');
	LDI  R26,LOW(32)
	CALL SUBOPT_0x2
; 0000 005F             name[index]=' ';
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(32)
	ST   X,R30
; 0000 0060             index--;
	__SUBWRN 20,21,1
; 0000 0061             while ( get_key() != 0x00 );
_0x30:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x30
; 0000 0062         }
; 0000 0063         if ( ch >= '0' && ch <= '9' && index < 16 ){
_0x2D:
	LDD  R26,Y+7
	CPI  R26,LOW(0x30)
	BRLO _0x34
	CPI  R26,LOW(0x3A)
	BRSH _0x34
	__CPWRN 20,21,16
	BRLT _0x35
_0x34:
	RJMP _0x33
_0x35:
; 0000 0064             nowat=0;
	__GETWRN 18,19,0
; 0000 0065             lcd_gotoxy(index,1);
	CALL SUBOPT_0x1
; 0000 0066             lcd_putchar(alpha[ch-'0'][nowat%5]);
	CALL SUBOPT_0x3
	LD   R26,X
	CALL SUBOPT_0x2
; 0000 0067             name[index]=alpha[ch-'0'][nowat%5];
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x3
	LD   R30,X
	POP  R26
	POP  R27
	ST   X,R30
; 0000 0068             while ( get_key() != 0x00 );
_0x36:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x36
; 0000 0069             for ( i=0; i<30; i++ ){
	__GETWRN 16,17,0
_0x3A:
	__CPWRN 16,17,30
	BRGE _0x3B
; 0000 006A                 tch = get_key();
	RCALL _get_key
	STD  Y+6,R30
; 0000 006B                 if ( tch == 0x00 )
	CPI  R30,0
	BREQ _0x39
; 0000 006C                     continue;
; 0000 006D                 else if ( tch != ch )
	LDD  R30,Y+7
	LDD  R26,Y+6
	CP   R30,R26
	BRNE _0x3B
; 0000 006E                     break;
; 0000 006F                 else if ( tch == ch ){
	CP   R30,R26
	BRNE _0x40
; 0000 0070                     nowat++;
	__ADDWRN 18,19,1
; 0000 0071                     i=0;
	__GETWRN 16,17,0
; 0000 0072                     while ( get_key() != 0x00 );
_0x41:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x41
; 0000 0073                 }
; 0000 0074                 while ( alpha[ch-'0'][nowat%5] == 0x00 ) nowat++;
_0x40:
_0x44:
	CALL SUBOPT_0x3
	CALL __GETW1P
	SBIW R30,0
	BRNE _0x46
	__ADDWRN 18,19,1
	RJMP _0x44
_0x46:
; 0000 0075 lcd_gotoxy(index,1);
	CALL SUBOPT_0x1
; 0000 0076                 lcd_putchar(alpha[ch-'0'][nowat%5]);
	CALL SUBOPT_0x3
	LD   R26,X
	CALL SUBOPT_0x2
; 0000 0077                 name[index]=alpha[ch-'0'][nowat%5];
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x3
	LD   R30,X
	POP  R26
	POP  R27
	ST   X,R30
; 0000 0078             }
_0x39:
	__ADDWRN 16,17,1
	RJMP _0x3A
_0x3B:
; 0000 0079             index++;
	__ADDWRN 20,21,1
; 0000 007A         }
; 0000 007B         lcd_gotoxy(index,1);
_0x33:
	CALL SUBOPT_0x1
; 0000 007C         lcd_putchar('_');
	LDI  R26,LOW(95)
	CALL SUBOPT_0x2
; 0000 007D         name[index]=0x00;
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
; 0000 007E     }
	RJMP _0x24
; 0000 007F     return 1;
_0x208000E:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
_0x208000D:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; 0000 0080 }
; .FEND
;
;int write_number ( char number[12] ){
; 0000 0082 int write_number ( char number[12] ){
_write_number:
; .FSTART _write_number
; 0000 0083     int index=0;
; 0000 0084     char ch;
; 0000 0085     while (1){
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	number -> Y+4
;	index -> R16,R17
;	ch -> R19
	__GETWRN 16,17,0
_0x47:
; 0000 0086         ch = get_key();
	RCALL _get_key
	MOV  R19,R30
; 0000 0087         if ( ch == 'D' && index > 0 )
	CPI  R19,68
	BRNE _0x4B
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRLT _0x4C
_0x4B:
	RJMP _0x4A
_0x4C:
; 0000 0088             return 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __LOADLOCR4
	RJMP _0x2080008
; 0000 0089         if ( ch == 'D' && index == 0 )
_0x4A:
	CPI  R19,68
	BRNE _0x4E
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BREQ _0x4F
_0x4E:
	RJMP _0x4D
_0x4F:
; 0000 008A             return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __LOADLOCR4
	RJMP _0x2080008
; 0000 008B         if ( ch == '*' && index > 0 ){
_0x4D:
	CPI  R19,42
	BRNE _0x51
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRLT _0x52
_0x51:
	RJMP _0x50
_0x52:
; 0000 008C             lcd_gotoxy(index,1);
	CALL SUBOPT_0x4
; 0000 008D             lcd_putchar(' ');
	LDI  R26,LOW(32)
	CALL SUBOPT_0x5
; 0000 008E             number[index]=' ';
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(32)
	ST   X,R30
; 0000 008F             index--;
	__SUBWRN 16,17,1
; 0000 0090             while ( get_key() != 0x00 );
_0x53:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x53
; 0000 0091         }
; 0000 0092         if ( ch >= '0' && ch <= '9' && index < 11 ){
_0x50:
	CPI  R19,48
	BRLO _0x57
	CPI  R19,58
	BRSH _0x57
	__CPWRN 16,17,11
	BRLT _0x58
_0x57:
	RJMP _0x56
_0x58:
; 0000 0093             lcd_gotoxy(index,1);
	CALL SUBOPT_0x4
; 0000 0094             lcd_putchar(ch);
	MOV  R26,R19
	CALL SUBOPT_0x5
; 0000 0095             number[index]=ch;
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R19
; 0000 0096             index++;
	__ADDWRN 16,17,1
; 0000 0097             while ( get_key() != 0x00 );
_0x59:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x59
; 0000 0098         }
; 0000 0099         lcd_gotoxy(index,1);
_0x56:
	CALL SUBOPT_0x4
; 0000 009A         lcd_putchar('_');
	LDI  R26,LOW(95)
	CALL SUBOPT_0x5
; 0000 009B         number[index]=0x00;
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
; 0000 009C     }
	RJMP _0x47
; 0000 009D     return 1;
; 0000 009E }
; .FEND
;
;void save_to_eeprom(){
; 0000 00A0 void save_to_eeprom(){
_save_to_eeprom:
; .FSTART _save_to_eeprom
; 0000 00A1     int i,j;
; 0000 00A2     sprintf(str,"   Saving....   ");
	CALL SUBOPT_0x6
;	i -> R16,R17
;	j -> R18,R19
	__POINTW1FN _0x0,0
	CALL SUBOPT_0x7
; 0000 00A3     lcd_gotoxy(0,0);
; 0000 00A4     lcd_puts(str);
; 0000 00A5     lcd_gotoxy(9,1);
; 0000 00A6     lcd_putchar('%');
; 0000 00A7     for ( i=0; i<32; i++ )
_0x5D:
	__CPWRN 16,17,32
	BRGE _0x5E
; 0000 00A8         for ( j=0; j<27; j++ ){
	__GETWRN 18,19,0
_0x60:
	__CPWRN 18,19,27
	BRGE _0x61
; 0000 00A9             sprintf(str,"%3d",(((i*32)+j)*10)/101);
	CALL SUBOPT_0x8
; 0000 00AA             lcd_gotoxy(6,1);
; 0000 00AB             lcd_puts(str);
; 0000 00AC             saved_db[i][j]=db[i][j];
	MOVW R22,R30
	CALL SUBOPT_0x9
	LD   R30,Z
	MOVW R26,R22
	CALL __EEPROMWRB
; 0000 00AD         }
	__ADDWRN 18,19,1
	RJMP _0x60
_0x61:
	__ADDWRN 16,17,1
	RJMP _0x5D
_0x5E:
; 0000 00AE     delay_ms(1000);
	CALL SUBOPT_0xA
; 0000 00AF     lcd_clear();
; 0000 00B0 }
	RJMP _0x208000C
; .FEND
;
;int load_from_eeprom(){
; 0000 00B2 int load_from_eeprom(){
_load_from_eeprom:
; .FSTART _load_from_eeprom
; 0000 00B3     int i,j;
; 0000 00B4     sprintf(str,"   Loading...   ");
	CALL SUBOPT_0x6
;	i -> R16,R17
;	j -> R18,R19
	__POINTW1FN _0x0,21
	CALL SUBOPT_0x7
; 0000 00B5     lcd_gotoxy(0,0);
; 0000 00B6     lcd_puts(str);
; 0000 00B7     lcd_gotoxy(9,1);
; 0000 00B8     lcd_putchar('%');
; 0000 00B9     for ( i=0; i<32; i++ ){
_0x63:
	__CPWRN 16,17,32
	BRGE _0x64
; 0000 00BA         for ( j=0; j<27; j++ ){
	__GETWRN 18,19,0
_0x66:
	__CPWRN 18,19,27
	BRGE _0x67
; 0000 00BB             sprintf(str,"%3d",(((i*32)+j)*10)/101);
	CALL SUBOPT_0x8
; 0000 00BC             lcd_gotoxy(6,1);
; 0000 00BD             lcd_puts(str);
; 0000 00BE             if ( saved_db[i][j] == 0x00 || saved_db[i][j] == 0xFF )
	MOVW R26,R30
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ _0x69
	CPI  R30,LOW(0xFF)
	BRNE _0x68
_0x69:
; 0000 00BF                 db[i][j]=0x00;
	CALL SUBOPT_0x9
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0000 00C0             else
	RJMP _0x6B
_0x68:
; 0000 00C1                 db[i][j]=saved_db[i][j];
	CALL SUBOPT_0x9
	MOVW R0,R30
	MOVW R30,R16
	LSL  R30
	ROL  R31
	CALL __LSLW4
	SUBI R30,LOW(-_saved_db)
	SBCI R31,HIGH(-_saved_db)
	ADD  R30,R18
	ADC  R31,R19
	MOVW R26,R30
	CALL __EEPROMRDB
	MOVW R26,R0
	ST   X,R30
; 0000 00C2         }
_0x6B:
	__ADDWRN 18,19,1
	RJMP _0x66
_0x67:
; 0000 00C3         if ( db[i][0] == 0x00 ){
	__MULBNWRU 16,17,27
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	LD   R30,Z
	CPI  R30,0
	BRNE _0x6C
; 0000 00C4             lcd_clear();
	CALL _lcd_clear
; 0000 00C5             return i;
	MOVW R30,R16
	RJMP _0x208000C
; 0000 00C6         }
; 0000 00C7     }
_0x6C:
	__ADDWRN 16,17,1
	RJMP _0x63
_0x64:
; 0000 00C8     delay_ms(1000);
	CALL SUBOPT_0xA
; 0000 00C9     lcd_clear();
; 0000 00CA     return 32;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
_0x208000C:
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; 0000 00CB }
; .FEND
;
;int view_contact( int index ){
; 0000 00CD int view_contact( int index ){
_view_contact:
; .FSTART _view_contact
; 0000 00CE     char curr_name[17];
; 0000 00CF     char curr_num[12];
; 0000 00D0     char ch;
; 0000 00D1     int i;
; 0000 00D2     if ( used < 1 ) return -1;
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,29
	CALL __SAVELOCR4
;	index -> Y+33
;	curr_name -> Y+16
;	curr_num -> Y+4
;	ch -> R17
;	i -> R18,R19
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x6D
	RJMP _0x208000A
; 0000 00D3     if ( index >= used )
_0x6D:
	LDD  R26,Y+33
	LDD  R27,Y+33+1
	CP   R26,R4
	CPC  R27,R5
	BRLT _0x6E
; 0000 00D4         index = used-1;
	MOVW R30,R4
	SBIW R30,1
	STD  Y+33,R30
	STD  Y+33+1,R31
; 0000 00D5     curr_name[16] = 0x00;
_0x6E:
	LDI  R30,LOW(0)
	STD  Y+32,R30
; 0000 00D6     curr_num[11] = 0x00;
	STD  Y+15,R30
; 0000 00D7     lcd_clear();
	CALL _lcd_clear
; 0000 00D8     while (1){
_0x6F:
; 0000 00D9         ch = get_key();
	RCALL _get_key
	MOV  R17,R30
; 0000 00DA         if ( ch == 0x00 ) continue;
	CPI  R17,0
	BREQ _0x6F
; 0000 00DB         if ( ch == 'D' )
	CPI  R17,68
	BRNE _0x73
; 0000 00DC             return index;
	LDD  R30,Y+33
	LDD  R31,Y+33+1
	RJMP _0x208000B
; 0000 00DD         if ( ch == 'A' ){
_0x73:
	CPI  R17,65
	BRNE _0x74
; 0000 00DE             while ( get_key() != 0x00 );
_0x75:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x75
; 0000 00DF             return -1;
	RJMP _0x208000A
; 0000 00E0         }
; 0000 00E1         else if ( ch == '*' && index > 0 )
_0x74:
	CPI  R17,42
	BRNE _0x7A
	LDD  R26,Y+33
	LDD  R27,Y+33+1
	CALL __CPW02
	BRLT _0x7B
_0x7A:
	RJMP _0x79
_0x7B:
; 0000 00E2             index--;
	LDD  R30,Y+33
	LDD  R31,Y+33+1
	SBIW R30,1
	STD  Y+33,R30
	STD  Y+33+1,R31
; 0000 00E3         else if ( ch == '#' && index < used-1 )
	RJMP _0x7C
_0x79:
	CPI  R17,35
	BRNE _0x7E
	MOVW R30,R4
	SBIW R30,1
	LDD  R26,Y+33
	LDD  R27,Y+33+1
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x7F
_0x7E:
	RJMP _0x7D
_0x7F:
; 0000 00E4             index++;
	LDD  R30,Y+33
	LDD  R31,Y+33+1
	ADIW R30,1
	STD  Y+33,R30
	STD  Y+33+1,R31
; 0000 00E5         else if ( ch == '*' && index == 0 )
	RJMP _0x80
_0x7D:
	CPI  R17,42
	BRNE _0x82
	LDD  R26,Y+33
	LDD  R27,Y+33+1
	SBIW R26,0
	BREQ _0x83
_0x82:
	RJMP _0x81
_0x83:
; 0000 00E6             index=used-1;
	MOVW R30,R4
	SBIW R30,1
	STD  Y+33,R30
	STD  Y+33+1,R31
; 0000 00E7         else if ( ch == '#' && index == used-1 )
	RJMP _0x84
_0x81:
	CPI  R17,35
	BRNE _0x86
	MOVW R30,R4
	SBIW R30,1
	LDD  R26,Y+33
	LDD  R27,Y+33+1
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x87
_0x86:
	RJMP _0x85
_0x87:
; 0000 00E8             index=0;
	LDI  R30,LOW(0)
	STD  Y+33,R30
	STD  Y+33+1,R30
; 0000 00E9         for ( i=0; i<11; i++ )
_0x85:
_0x84:
_0x80:
_0x7C:
	__GETWRN 18,19,0
_0x89:
	__CPWRN 18,19,11
	BRGE _0x8A
; 0000 00EA             curr_num[i] = db[index][i];
	MOVW R30,R18
	MOVW R26,R28
	ADIW R26,4
	CALL SUBOPT_0xB
	ADD  R30,R18
	ADC  R31,R19
	LD   R30,Z
	__GETW2R 23,24
	ST   X,R30
	__ADDWRN 18,19,1
	RJMP _0x89
_0x8A:
; 0000 00EB for ( i=0; i<16; i++ )
	__GETWRN 18,19,0
_0x8C:
	__CPWRN 18,19,16
	BRGE _0x8D
; 0000 00EC             curr_name[i] = db[index][i+11];
	MOVW R30,R18
	MOVW R26,R28
	ADIW R26,16
	CALL SUBOPT_0xB
	MOVW R26,R30
	MOVW R30,R18
	ADIW R30,11
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	__GETW2R 23,24
	ST   X,R30
	__ADDWRN 18,19,1
	RJMP _0x8C
_0x8D:
; 0000 00ED lcd_clear();
	CALL SUBOPT_0xC
; 0000 00EE         sprintf(str,"%s",curr_name);
	__POINTW1FN _0x0,38
	CALL SUBOPT_0xD
	CALL SUBOPT_0xE
; 0000 00EF         lcd_gotoxy(0,0);
	CALL SUBOPT_0xF
; 0000 00F0         lcd_puts(str);
; 0000 00F1         sprintf(str,"%16s",curr_num);
	CALL SUBOPT_0x10
	__POINTW1FN _0x0,41
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,8
	CALL SUBOPT_0x11
	CALL SUBOPT_0xE
; 0000 00F2         lcd_gotoxy(0,1);
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
; 0000 00F3         lcd_puts(str);
	LDI  R26,LOW(_str)
	LDI  R27,HIGH(_str)
	CALL _lcd_puts
; 0000 00F4         while ( get_key() != 0x00 );
_0x8E:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x8E
; 0000 00F5     }
	RJMP _0x6F
; 0000 00F6     return -1;
_0x208000A:
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
_0x208000B:
	CALL __LOADLOCR4
	ADIW R28,35
	RET
; 0000 00F7 }
; .FEND
;
;void add_contact(){
; 0000 00F9 void add_contact(){
_add_contact:
; .FSTART _add_contact
; 0000 00FA     int i;
; 0000 00FB     char curr_name[17];
; 0000 00FC     char curr_num[12];
; 0000 00FD     if ( used > 31 ) return;
	SBIW R28,29
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16,R17
;	curr_name -> Y+14
;	curr_num -> Y+2
	LDI  R30,LOW(31)
	LDI  R31,HIGH(31)
	CP   R30,R4
	CPC  R31,R5
	BRGE _0x91
	RJMP _0x2080009
; 0000 00FE     lcd_clear();
_0x91:
	CALL SUBOPT_0xC
; 0000 00FF     sprintf(str,"  Enter  name:  ");
	__POINTW1FN _0x0,46
	CALL SUBOPT_0x12
; 0000 0100     lcd_gotoxy(0,0);
; 0000 0101     lcd_puts(str);
; 0000 0102     if ( !write_alpha(curr_name) )
	MOVW R26,R28
	ADIW R26,14
	RCALL _write_alpha
	SBIW R30,0
	BRNE _0x92
; 0000 0103         return;
	RJMP _0x2080009
; 0000 0104     while( get_key() != 0x00 );
_0x92:
_0x93:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x93
; 0000 0105     lcd_clear();
	CALL SUBOPT_0xC
; 0000 0106     sprintf(str," Enter  number: ");
	__POINTW1FN _0x0,63
	CALL SUBOPT_0x12
; 0000 0107     lcd_gotoxy(0,0);
; 0000 0108     lcd_puts(str);
; 0000 0109     if ( !write_number(curr_num) )
	MOVW R26,R28
	ADIW R26,2
	RCALL _write_number
	SBIW R30,0
	BREQ _0x2080009
; 0000 010A         return;
; 0000 010B     while( get_key() != 0x00 );
_0x97:
	RCALL _get_key
	CPI  R30,0
	BRNE _0x97
; 0000 010C     lcd_clear();
	RCALL _lcd_clear
; 0000 010D     for ( i=0; i<11; i++ )
	__GETWRN 16,17,0
_0x9B:
	__CPWRN 16,17,11
	BRGE _0x9C
; 0000 010E         db[used][i] = curr_num[i];
	CALL SUBOPT_0x13
	ADD  R30,R16
	ADC  R31,R17
	MOVW R0,R30
	MOVW R26,R28
	ADIW R26,2
	ADD  R26,R16
	ADC  R27,R17
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
	__ADDWRN 16,17,1
	RJMP _0x9B
_0x9C:
; 0000 010F for ( i=0; i<16; i++ )
	__GETWRN 16,17,0
_0x9E:
	__CPWRN 16,17,16
	BRGE _0x9F
; 0000 0110         db[used][i+11] = curr_name[i];
	CALL SUBOPT_0x13
	MOVW R26,R30
	MOVW R30,R16
	ADIW R30,11
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOVW R26,R28
	ADIW R26,14
	ADD  R26,R16
	ADC  R27,R17
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
	__ADDWRN 16,17,1
	RJMP _0x9E
_0x9F:
; 0000 0111 used++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0112     save_to_eeprom();
	RCALL _save_to_eeprom
; 0000 0113 }
_0x2080009:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,31
	RET
; .FEND
;
;void delete_contact(){
; 0000 0115 void delete_contact(){
_delete_contact:
; .FSTART _delete_contact
; 0000 0116     int i, j, to_delete;
; 0000 0117     if ( used < 1 ) return;
	CALL __SAVELOCR6
;	i -> R16,R17
;	j -> R18,R19
;	to_delete -> R20,R21
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0xA0
	RJMP _0x2080007
; 0000 0118     sprintf(str,"Choose to delete");
_0xA0:
	CALL SUBOPT_0x10
	__POINTW1FN _0x0,80
	CALL SUBOPT_0x12
; 0000 0119     lcd_gotoxy(0,0);
; 0000 011A     lcd_puts(str);
; 0000 011B     to_delete = view_contact(0);
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _view_contact
	MOVW R20,R30
; 0000 011C     if ( to_delete < 0 )
	TST  R21
	BRPL _0xA1
; 0000 011D         return;
	RJMP _0x2080007
; 0000 011E     for ( i=0; i<27; i++ )
_0xA1:
	__GETWRN 16,17,0
_0xA3:
	__CPWRN 16,17,27
	BRGE _0xA4
; 0000 011F         db[to_delete][i] = 0x00;
	__MULBNWRU 20,21,27
	CALL SUBOPT_0x14
	__ADDWRN 16,17,1
	RJMP _0xA3
_0xA4:
; 0000 0120 for ( i=to_delete; i<used-1; i++ )
	MOVW R16,R20
_0xA6:
	MOVW R30,R4
	SBIW R30,1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0xA7
; 0000 0121         for ( j=0; j<27; j++ )
	__GETWRN 18,19,0
_0xA9:
	__CPWRN 18,19,27
	BRGE _0xAA
; 0000 0122             db[i][j]=db[i+1][j];
	CALL SUBOPT_0x9
	MOVW R22,R30
	MOVW R30,R16
	ADIW R30,1
	LDI  R26,LOW(27)
	LDI  R27,HIGH(27)
	CALL __MULW12U
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	ADD  R30,R18
	ADC  R31,R19
	LD   R30,Z
	MOVW R26,R22
	ST   X,R30
	__ADDWRN 18,19,1
	RJMP _0xA9
_0xAA:
; 0000 0123 for ( i=0; i<27; i++ )
	__ADDWRN 16,17,1
	RJMP _0xA6
_0xA7:
	__GETWRN 16,17,0
_0xAC:
	__CPWRN 16,17,27
	BRGE _0xAD
; 0000 0124         db[used-1][i]= 0x00;
	MOVW R30,R4
	SBIW R30,1
	LDI  R26,LOW(27)
	LDI  R27,HIGH(27)
	CALL __MULW12U
	CALL SUBOPT_0x14
	__ADDWRN 16,17,1
	RJMP _0xAC
_0xAD:
; 0000 0125 lcd_clear();
	RCALL _lcd_clear
; 0000 0126     used--;
	MOVW R30,R4
	SBIW R30,1
	MOVW R4,R30
; 0000 0127     save_to_eeprom();
	RCALL _save_to_eeprom
; 0000 0128 }
_0x2080007:
	CALL __LOADLOCR6
_0x2080008:
	ADIW R28,6
	RET
; .FEND
;
;void send_report(){
; 0000 012A void send_report(){
_send_report:
; .FSTART _send_report
; 0000 012B     int i, j;
; 0000 012C     char curr_name[17];
; 0000 012D     char curr_num[12];
; 0000 012E     printf("Name,Phone\n");
	SBIW R28,29
	CALL __SAVELOCR4
;	i -> R16,R17
;	j -> R18,R19
;	curr_name -> Y+16
;	curr_num -> Y+4
	__POINTW1FN _0x0,97
	CALL SUBOPT_0x15
; 0000 012F     for ( j=0; j<used; j++ ){
	__GETWRN 18,19,0
_0xAF:
	__CPWRR 18,19,4,5
	BRLT PC+2
	RJMP _0xB0
; 0000 0130         for ( i=0; i<11; i++ )
	__GETWRN 16,17,0
_0xB2:
	__CPWRN 16,17,11
	BRGE _0xB3
; 0000 0131             curr_num[i] = db[j][i];
	MOVW R30,R16
	MOVW R26,R28
	ADIW R26,4
	CALL SUBOPT_0x16
	ADD  R30,R16
	ADC  R31,R17
	LD   R30,Z
	MOVW R26,R22
	ST   X,R30
	__ADDWRN 16,17,1
	RJMP _0xB2
_0xB3:
; 0000 0132 for ( i=0; i<16; i++ )
	__GETWRN 16,17,0
_0xB5:
	__CPWRN 16,17,16
	BRGE _0xB6
; 0000 0133             curr_name[i] = db[j][i+11];
	MOVW R30,R16
	MOVW R26,R28
	ADIW R26,16
	CALL SUBOPT_0x16
	MOVW R26,R30
	MOVW R30,R16
	ADIW R30,11
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	MOVW R26,R22
	ST   X,R30
	__ADDWRN 16,17,1
	RJMP _0xB5
_0xB6:
; 0000 0134 curr_num[11]=0x00;
	LDI  R30,LOW(0)
	STD  Y+15,R30
; 0000 0135         sprintf(str,"%s,%s",curr_name,curr_num);
	CALL SUBOPT_0x10
	__POINTW1FN _0x0,109
	CALL SUBOPT_0xD
	MOVW R30,R28
	ADIW R30,12
	CALL SUBOPT_0x11
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
; 0000 0136         puts(str);
	LDI  R26,LOW(_str)
	LDI  R27,HIGH(_str)
	CALL _puts
; 0000 0137     }
	__ADDWRN 18,19,1
	RJMP _0xAF
_0xB0:
; 0000 0138 }
	CALL __LOADLOCR4
	ADIW R28,33
	RET
; .FEND
;
;void main(void){
; 0000 013A void main(void){
_main:
; .FSTART _main
; 0000 013B // Declare your local variables here
; 0000 013C char ch;
; 0000 013D // Input/Output Ports initialization
; 0000 013E // Port A initialization
; 0000 013F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0140 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
;	ch -> R17
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0141 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0142 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0143 
; 0000 0144 // Port B initialization
; 0000 0145 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0146 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(240)
	OUT  0x17,R30
; 0000 0147 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0148 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0149 
; 0000 014A // Port C initialization
; 0000 014B // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 014C DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 014D // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 014E PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 014F 
; 0000 0150 // Port D initialization
; 0000 0151 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=Out Bit0=In
; 0000 0152 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (1<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(2)
	OUT  0x11,R30
; 0000 0153 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=0 Bit0=T
; 0000 0154 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0155 
; 0000 0156 // Timer/Counter 0 initialization
; 0000 0157 // Clock source: System Clock
; 0000 0158 // Clock value: Timer 0 Stopped
; 0000 0159 // Mode: Normal top=0xFF
; 0000 015A // OC0 output: Disconnected
; 0000 015B TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 015C TCNT0=0x00;
	OUT  0x32,R30
; 0000 015D OCR0=0x00;
	OUT  0x3C,R30
; 0000 015E 
; 0000 015F // Timer/Counter 1 initialization
; 0000 0160 // Clock source: System Clock
; 0000 0161 // Clock value: Timer1 Stopped
; 0000 0162 // Mode: Normal top=0xFFFF
; 0000 0163 // OC1A output: Disconnected
; 0000 0164 // OC1B output: Disconnected
; 0000 0165 // Noise Canceler: Off
; 0000 0166 // Input Capture on Falling Edge
; 0000 0167 // Timer1 Overflow Interrupt: Off
; 0000 0168 // Input Capture Interrupt: Off
; 0000 0169 // Compare A Match Interrupt: Off
; 0000 016A // Compare B Match Interrupt: Off
; 0000 016B TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 016C TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 016D TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 016E TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 016F ICR1H=0x00;
	OUT  0x27,R30
; 0000 0170 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0171 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0172 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0173 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0174 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0175 
; 0000 0176 // Timer/Counter 2 initialization
; 0000 0177 // Clock source: System Clock
; 0000 0178 // Clock value: Timer2 Stopped
; 0000 0179 // Mode: Normal top=0xFF
; 0000 017A // OC2 output: Disconnected
; 0000 017B ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 017C TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 017D TCNT2=0x00;
	OUT  0x24,R30
; 0000 017E OCR2=0x00;
	OUT  0x23,R30
; 0000 017F 
; 0000 0180 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0181 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 0182 
; 0000 0183 // External Interrupt(s) initialization
; 0000 0184 // INT0: Off
; 0000 0185 // INT1: Off
; 0000 0186 // INT2: Off
; 0000 0187 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 0188 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0189 
; 0000 018A // USART initialization
; 0000 018B // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 018C // USART Receiver: On
; 0000 018D // USART Transmitter: On
; 0000 018E // USART Mode: Asynchronous
; 0000 018F // USART Baud Rate: 9600
; 0000 0190 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 0191 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(24)
	OUT  0xA,R30
; 0000 0192 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0193 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0194 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 0195 
; 0000 0196 // Analog Comparator initialization
; 0000 0197 // Analog Comparator: Off
; 0000 0198 // The Analog Comparator's positive input is
; 0000 0199 // connected to the AIN0 pin
; 0000 019A // The Analog Comparator's negative input is
; 0000 019B // connected to the AIN1 pin
; 0000 019C ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 019D SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 019E 
; 0000 019F // ADC initialization
; 0000 01A0 // ADC disabled
; 0000 01A1 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 01A2 
; 0000 01A3 // SPI initialization
; 0000 01A4 // SPI disabled
; 0000 01A5 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 01A6 
; 0000 01A7 // TWI initialization
; 0000 01A8 // TWI disabled
; 0000 01A9 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 01AA 
; 0000 01AB // Alphanumeric LCD initialization
; 0000 01AC // Connections are specified in the
; 0000 01AD // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 01AE // RS - PORTC Bit 0
; 0000 01AF // RD - PORTC Bit 1
; 0000 01B0 // EN - PORTC Bit 2
; 0000 01B1 // D4 - PORTC Bit 4
; 0000 01B2 // D5 - PORTC Bit 5
; 0000 01B3 // D6 - PORTC Bit 6
; 0000 01B4 // D7 - PORTC Bit 7
; 0000 01B5 // Characters/line: 16
; 0000 01B6 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 01B7 
; 0000 01B8     used=load_from_eeprom();
	RCALL _load_from_eeprom
	MOVW R4,R30
; 0000 01B9 
; 0000 01BA     while (1){
_0xB7:
; 0000 01BB         lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _lcd_gotoxy
; 0000 01BC         lcd_puts("   Phone Book   ");
	__POINTW2MN _0xBA,0
	RCALL _lcd_puts
; 0000 01BD         lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _lcd_gotoxy
; 0000 01BE         lcd_puts("Shahidi  Adibnia");
	__POINTW2MN _0xBA,17
	RCALL _lcd_puts
; 0000 01BF         ch = get_key();
	RCALL _get_key
	MOV  R17,R30
; 0000 01C0         if ( ch == 'A' )
	CPI  R17,65
	BRNE _0xBB
; 0000 01C1             add_contact();
	RCALL _add_contact
; 0000 01C2         else if ( ch == 'B' )
	RJMP _0xBC
_0xBB:
	CPI  R17,66
	BRNE _0xBD
; 0000 01C3             view_contact(0);
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _view_contact
; 0000 01C4         else if ( ch == 'C' )
	RJMP _0xBE
_0xBD:
	CPI  R17,67
	BRNE _0xBF
; 0000 01C5             delete_contact();
	RCALL _delete_contact
; 0000 01C6         if ( ISDATAREADY ){
_0xBF:
_0xBE:
_0xBC:
	SBIS 0xB,7
	RJMP _0xC0
; 0000 01C7             scanf("%s",str);
	__POINTW1FN _0x0,38
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_str)
	LDI  R31,HIGH(_str)
	CALL SUBOPT_0x11
	LDI  R24,4
	CALL _scanf
	ADIW R28,6
; 0000 01C8             if ( !strcmp(str,"Report") )
	CALL SUBOPT_0x10
	__POINTW2MN _0xBA,34
	CALL _strcmp
	CPI  R30,0
	BRNE _0xC1
; 0000 01C9                 send_report();
	RCALL _send_report
; 0000 01CA             else
	RJMP _0xC2
_0xC1:
; 0000 01CB                 printf("Unknown Command!\n");
	__POINTW1FN _0x0,156
	CALL SUBOPT_0x15
; 0000 01CC         }
_0xC2:
; 0000 01CD     }
_0xC0:
	RJMP _0xB7
; 0000 01CE 
; 0000 01CF }
_0xC3:
	RJMP _0xC3
; .FEND

	.DSEG
_0xBA:
	.BYTE 0x29
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 13
	SBI  0x15,2
	__DELAY_USB 13
	CBI  0x15,2
	__DELAY_USB 13
	JMP  _0x2080006
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	JMP  _0x2080006
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R7,Y+1
	LDD  R6,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x17
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x17
	LDI  R30,LOW(0)
	MOV  R6,R30
	MOV  R7,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R7,R9
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R6
	MOV  R26,R6
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	JMP  _0x2080006
_0x2000007:
_0x2000004:
	INC  R7
	SBI  0x15,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x15,0
	JMP  _0x2080006
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	CALL SUBOPT_0x18
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	JMP  _0x2080005
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	LDD  R9,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x19
	CALL SUBOPT_0x19
	CALL SUBOPT_0x19
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
	JMP  _0x2080006
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_getchar:
; .FSTART _getchar
getchar0:
     sbis usr,rxc
     rjmp getchar0
     in   r30,udr
	RET
; .FEND
_putchar:
; .FSTART _putchar
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
_0x2080006:
	ADIW R28,1
	RET
; .FEND
_puts:
; .FSTART _puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020003:
	CALL SUBOPT_0x18
	BREQ _0x2020005
	MOV  R26,R17
	RCALL _putchar
	RJMP _0x2020003
_0x2020005:
	LDI  R26,LOW(10)
	RCALL _putchar
	LDD  R17,Y+0
	RJMP _0x2080005
; .FEND
_put_usart_G101:
; .FSTART _put_usart_G101
	ST   -Y,R27
	ST   -Y,R26
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	CALL SUBOPT_0x1A
_0x2080005:
	ADIW R28,3
	RET
; .FEND
_put_buff_G101:
; .FSTART _put_buff_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2020010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2020012
	__CPWRN 16,17,2
	BRLO _0x2020013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2020012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL SUBOPT_0x1A
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2020013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2020014
	CALL SUBOPT_0x1A
_0x2020014:
	RJMP _0x2020015
_0x2020010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2020015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x2080003
; .FEND
__print_G101:
; .FSTART __print_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2020016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2020018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x202001C
	CPI  R18,37
	BRNE _0x202001D
	LDI  R17,LOW(1)
	RJMP _0x202001E
_0x202001D:
	CALL SUBOPT_0x1B
_0x202001E:
	RJMP _0x202001B
_0x202001C:
	CPI  R30,LOW(0x1)
	BRNE _0x202001F
	CPI  R18,37
	BRNE _0x2020020
	CALL SUBOPT_0x1B
	RJMP _0x20200CC
_0x2020020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020021
	LDI  R16,LOW(1)
	RJMP _0x202001B
_0x2020021:
	CPI  R18,43
	BRNE _0x2020022
	LDI  R20,LOW(43)
	RJMP _0x202001B
_0x2020022:
	CPI  R18,32
	BRNE _0x2020023
	LDI  R20,LOW(32)
	RJMP _0x202001B
_0x2020023:
	RJMP _0x2020024
_0x202001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2020025
_0x2020024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020026
	ORI  R16,LOW(128)
	RJMP _0x202001B
_0x2020026:
	RJMP _0x2020027
_0x2020025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x202001B
_0x2020027:
	CPI  R18,48
	BRLO _0x202002A
	CPI  R18,58
	BRLO _0x202002B
_0x202002A:
	RJMP _0x2020029
_0x202002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202001B
_0x2020029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x202002F
	CALL SUBOPT_0x1C
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x1D
	RJMP _0x2020030
_0x202002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2020032
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1E
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2020033
_0x2020032:
	CPI  R30,LOW(0x70)
	BRNE _0x2020035
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1E
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x64)
	BREQ _0x2020039
	CPI  R30,LOW(0x69)
	BRNE _0x202003A
_0x2020039:
	ORI  R16,LOW(4)
	RJMP _0x202003B
_0x202003A:
	CPI  R30,LOW(0x75)
	BRNE _0x202003C
_0x202003B:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x202003D
_0x202003C:
	CPI  R30,LOW(0x58)
	BRNE _0x202003F
	ORI  R16,LOW(8)
	RJMP _0x2020040
_0x202003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2020071
_0x2020040:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x202003D:
	SBRS R16,2
	RJMP _0x2020042
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1F
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020043:
	CPI  R20,0
	BREQ _0x2020044
	SUBI R17,-LOW(1)
	RJMP _0x2020045
_0x2020044:
	ANDI R16,LOW(251)
_0x2020045:
	RJMP _0x2020046
_0x2020042:
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1F
_0x2020046:
_0x2020036:
	SBRC R16,0
	RJMP _0x2020047
_0x2020048:
	CP   R17,R21
	BRSH _0x202004A
	SBRS R16,7
	RJMP _0x202004B
	SBRS R16,2
	RJMP _0x202004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x202004D
_0x202004C:
	LDI  R18,LOW(48)
_0x202004D:
	RJMP _0x202004E
_0x202004B:
	LDI  R18,LOW(32)
_0x202004E:
	CALL SUBOPT_0x1B
	SUBI R21,LOW(1)
	RJMP _0x2020048
_0x202004A:
_0x2020047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x202004F
_0x2020050:
	CPI  R19,0
	BREQ _0x2020052
	SBRS R16,3
	RJMP _0x2020053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020054
_0x2020053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2020054:
	CALL SUBOPT_0x1B
	CPI  R21,0
	BREQ _0x2020055
	SUBI R21,LOW(1)
_0x2020055:
	SUBI R19,LOW(1)
	RJMP _0x2020050
_0x2020052:
	RJMP _0x2020056
_0x202004F:
_0x2020058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x202005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x202005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x202005A
_0x202005C:
	CPI  R18,58
	BRLO _0x202005D
	SBRS R16,3
	RJMP _0x202005E
	SUBI R18,-LOW(7)
	RJMP _0x202005F
_0x202005E:
	SUBI R18,-LOW(39)
_0x202005F:
_0x202005D:
	SBRC R16,4
	RJMP _0x2020061
	CPI  R18,49
	BRSH _0x2020063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020062
_0x2020063:
	RJMP _0x20200CD
_0x2020062:
	CP   R21,R19
	BRLO _0x2020067
	SBRS R16,0
	RJMP _0x2020068
_0x2020067:
	RJMP _0x2020066
_0x2020068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2020069
	LDI  R18,LOW(48)
_0x20200CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x202006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x1D
	CPI  R21,0
	BREQ _0x202006B
	SUBI R21,LOW(1)
_0x202006B:
_0x202006A:
_0x2020069:
_0x2020061:
	CALL SUBOPT_0x1B
	CPI  R21,0
	BREQ _0x202006C
	SUBI R21,LOW(1)
_0x202006C:
_0x2020066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2020059
	RJMP _0x2020058
_0x2020059:
_0x2020056:
	SBRS R16,0
	RJMP _0x202006D
_0x202006E:
	CPI  R21,0
	BREQ _0x2020070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x1D
	RJMP _0x202006E
_0x2020070:
_0x202006D:
_0x2020071:
_0x2020030:
_0x20200CC:
	LDI  R17,LOW(0)
_0x202001B:
	RJMP _0x2020016
_0x2020018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x20
	SBIW R30,0
	BRNE _0x2020072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x2020072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x20
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL SUBOPT_0x21
	LDI  R30,LOW(_put_buff_G101)
	LDI  R31,HIGH(_put_buff_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G101
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2080004:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND
_printf:
; .FSTART _printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	CALL SUBOPT_0x21
	LDI  R30,LOW(_put_usart_G101)
	LDI  R31,HIGH(_put_usart_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G101
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND
_get_usart_G101:
; .FSTART _get_usart_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020078
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x2020079
_0x2020078:
	RCALL _getchar
	MOV  R17,R30
_0x2020079:
	MOV  R30,R17
	LDD  R17,Y+0
_0x2080003:
	ADIW R28,5
	RET
; .FEND
__scanf_G101:
; .FSTART __scanf_G101
	PUSH R15
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR6
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STD  Y+8,R30
	STD  Y+8+1,R31
	MOV  R20,R30
_0x202007F:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2020081
	CALL SUBOPT_0x22
	BREQ _0x2020082
_0x2020083:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x23
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x2020086
	CALL SUBOPT_0x22
	BRNE _0x2020087
_0x2020086:
	RJMP _0x2020085
_0x2020087:
	CALL SUBOPT_0x24
	BRGE _0x2020088
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x2020088:
	RJMP _0x2020083
_0x2020085:
	MOV  R20,R19
	RJMP _0x2020089
_0x2020082:
	CPI  R19,37
	BREQ PC+2
	RJMP _0x202008A
	LDI  R21,LOW(0)
_0x202008B:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LPM  R19,Z+
	STD  Y+16,R30
	STD  Y+16+1,R31
	CPI  R19,48
	BRLO _0x202008F
	CPI  R19,58
	BRLO _0x202008E
_0x202008F:
	RJMP _0x202008D
_0x202008E:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202008B
_0x202008D:
	CPI  R19,0
	BRNE _0x2020091
	RJMP _0x2020081
_0x2020091:
_0x2020092:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x23
	POP  R20
	MOV  R18,R30
	MOV  R26,R30
	CALL _isspace
	CPI  R30,0
	BREQ _0x2020094
	CALL SUBOPT_0x24
	BRGE _0x2020095
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x2020095:
	RJMP _0x2020092
_0x2020094:
	CPI  R18,0
	BRNE _0x2020096
	RJMP _0x2020097
_0x2020096:
	MOV  R20,R18
	CPI  R21,0
	BRNE _0x2020098
	LDI  R21,LOW(255)
_0x2020098:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x202009C
	CALL SUBOPT_0x25
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x23
	POP  R20
	MOVW R26,R16
	ST   X,R30
	CALL SUBOPT_0x24
	BRGE _0x202009D
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x202009D:
	RJMP _0x202009B
_0x202009C:
	CPI  R30,LOW(0x73)
	BRNE _0x20200A6
	CALL SUBOPT_0x25
_0x202009F:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BREQ _0x20200A1
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x23
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x20200A3
	CALL SUBOPT_0x22
	BREQ _0x20200A2
_0x20200A3:
	CALL SUBOPT_0x24
	BRGE _0x20200A5
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x20200A5:
	RJMP _0x20200A1
_0x20200A2:
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	MOV  R30,R19
	POP  R26
	POP  R27
	ST   X,R30
	RJMP _0x202009F
_0x20200A1:
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x202009B
_0x20200A6:
	SET
	BLD  R15,1
	CLT
	BLD  R15,2
	MOV  R30,R19
	CPI  R30,LOW(0x64)
	BREQ _0x20200AB
	CPI  R30,LOW(0x69)
	BRNE _0x20200AC
_0x20200AB:
	CLT
	BLD  R15,1
	RJMP _0x20200AD
_0x20200AC:
	CPI  R30,LOW(0x75)
	BRNE _0x20200AE
_0x20200AD:
	LDI  R18,LOW(10)
	RJMP _0x20200A9
_0x20200AE:
	CPI  R30,LOW(0x78)
	BRNE _0x20200AF
	LDI  R18,LOW(16)
	RJMP _0x20200A9
_0x20200AF:
	CPI  R30,LOW(0x25)
	BRNE _0x20200B2
	RJMP _0x20200B1
_0x20200B2:
	RJMP _0x2080002
_0x20200A9:
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
	SET
	BLD  R15,0
_0x20200B3:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20200B5
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x23
	POP  R20
	MOV  R19,R30
	CPI  R30,LOW(0x21)
	BRSH _0x20200B6
	CALL SUBOPT_0x24
	BRGE _0x20200B7
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x20200B7:
	RJMP _0x20200B8
_0x20200B6:
	SBRC R15,1
	RJMP _0x20200B9
	SET
	BLD  R15,1
	CPI  R19,45
	BRNE _0x20200BA
	BLD  R15,2
	RJMP _0x20200B3
_0x20200BA:
	CPI  R19,43
	BREQ _0x20200B3
_0x20200B9:
	CPI  R18,16
	BRNE _0x20200BC
	MOV  R26,R19
	CALL _isxdigit
	CPI  R30,0
	BREQ _0x20200B8
	RJMP _0x20200BE
_0x20200BC:
	MOV  R26,R19
	CALL _isdigit
	CPI  R30,0
	BRNE _0x20200BF
_0x20200B8:
	SBRC R15,0
	RJMP _0x20200C1
	MOV  R20,R19
	RJMP _0x20200B5
_0x20200BF:
_0x20200BE:
	CPI  R19,97
	BRLO _0x20200C2
	SUBI R19,LOW(87)
	RJMP _0x20200C3
_0x20200C2:
	CPI  R19,65
	BRLO _0x20200C4
	SUBI R19,LOW(55)
	RJMP _0x20200C5
_0x20200C4:
	SUBI R19,LOW(48)
_0x20200C5:
_0x20200C3:
	MOV  R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R19
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	CLT
	BLD  R15,0
	RJMP _0x20200B3
_0x20200B5:
	CALL SUBOPT_0x25
	SBRS R15,2
	RJMP _0x20200C6
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __ANEGW1
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x20200C6:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	MOVW R26,R16
	ST   X+,R30
	ST   X,R31
_0x202009B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RJMP _0x20200C7
_0x202008A:
_0x20200B1:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x23
	POP  R20
	CP   R30,R19
	BREQ _0x20200C8
	CALL SUBOPT_0x24
	BRGE _0x20200C9
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x20200C9:
_0x2020097:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BRNE _0x20200CA
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x20200CA:
	RJMP _0x2020081
_0x20200C8:
_0x20200C7:
_0x2020089:
	RJMP _0x202007F
_0x2020081:
_0x20200C1:
_0x2080002:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
_0x2080001:
	CALL __LOADLOCR6
	ADIW R28,18
	POP  R15
	RET
; .FEND
_scanf:
; .FSTART _scanf
	PUSH R15
	MOV  R15,R24
	SBIW R28,3
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,1
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+3,R30
	STD  Y+3+1,R30
	MOVW R26,R28
	ADIW R26,5
	CALL SUBOPT_0x21
	LDI  R30,LOW(_get_usart_G101)
	LDI  R31,HIGH(_get_usart_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __scanf_G101
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	POP  R15
	RET
; .FEND

	.CSEG
_strcmp:
; .FSTART _strcmp
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strcmp0:
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strcmp1
    tst  r22
    brne strcmp0
strcmp3:
    clr  r30
    ret
strcmp1:
    sub  r22,r23
    breq strcmp3
    ldi  r30,1
    brcc strcmp2
    subi r30,2
strcmp2:
    ret
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG
_isdigit:
; .FSTART _isdigit
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,'0'
    brlo isdigit0
    cpi  r31,'9'+1
    brlo isdigit1
isdigit0:
    clr  r30
isdigit1:
    ret
; .FEND
_isspace:
; .FSTART _isspace
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,' '
    breq isspace1
    cpi  r31,9
    brlo isspace0
    cpi  r31,13+1
    brlo isspace1
isspace0:
    clr  r30
isspace1:
    ret
; .FEND
_isxdigit:
; .FSTART _isxdigit
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    subi r31,0x30
    brcs isxdigit0
    cpi  r31,10
    brcs isxdigit1
    andi r31,0x5f
    subi r31,7
    cpi  r31,10
    brcs isxdigit0
    cpi  r31,16
    brcs isxdigit1
isxdigit0:
    clr  r30
isxdigit1:
    ret
; .FEND

	.DSEG
_alpha:
	.BYTE 0x64
_db:
	.BYTE 0x360

	.ESEG
_saved_db:
	.BYTE 0x400

	.DSEG
_str:
	.BYTE 0x28
__base_y_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(10)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	ST   -Y,R20
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2:
	CALL _lcd_putchar
	MOVW R30,R20
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:69 WORDS
SUBOPT_0x3:
	LDD  R30,Y+7
	LDI  R31,0
	SBIW R30,48
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	SUBI R30,LOW(-_alpha)
	SBCI R31,HIGH(-_alpha)
	MOVW R22,R30
	MOVW R26,R18
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __MODW21
	MOVW R26,R22
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	ST   -Y,R16
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	CALL _lcd_putchar
	MOVW R30,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	CALL __SAVELOCR4
	LDI  R30,LOW(_str)
	LDI  R31,HIGH(_str)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0x7:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	LDI  R26,LOW(_str)
	LDI  R27,HIGH(_str)
	CALL _lcd_puts
	LDI  R30,LOW(9)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	LDI  R26,LOW(37)
	CALL _lcd_putchar
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(_str)
	LDI  R31,HIGH(_str)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,17
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R16
	LSL  R30
	ROL  R31
	CALL __LSLW4
	ADD  R30,R18
	ADC  R31,R19
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(101)
	LDI  R31,HIGH(101)
	CALL __DIVW21
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	LDI  R26,LOW(_str)
	LDI  R27,HIGH(_str)
	CALL _lcd_puts
	MOVW R30,R16
	LSL  R30
	ROL  R31
	CALL __LSLW4
	SUBI R30,LOW(-_saved_db)
	SBCI R31,HIGH(-_saved_db)
	ADD  R30,R18
	ADC  R31,R19
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x9:
	__MULBNWRU 16,17,27
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	ADD  R30,R18
	ADC  R31,R19
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xB:
	ADD  R30,R26
	ADC  R31,R27
	__PUTW1R 23,24
	LDD  R26,Y+33
	LDD  R27,Y+33+1
	LDI  R30,LOW(27)
	CALL __MULB1W2U
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xC:
	CALL _lcd_clear
	LDI  R30,LOW(_str)
	LDI  R31,HIGH(_str)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,20
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	LDI  R26,LOW(_str)
	LDI  R27,HIGH(_str)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(_str)
	LDI  R31,HIGH(_str)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x12:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	LDI  R30,LOW(0)
	ST   -Y,R30
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x13:
	MOVW R30,R4
	LDI  R26,LOW(27)
	LDI  R27,HIGH(27)
	CALL __MULW12U
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	ADD  R30,R16
	ADC  R31,R17
	LDI  R26,LOW(0)
	STD  Z+0,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x16:
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	__MULBNWRU 18,19,27
	SUBI R30,LOW(-_db)
	SBCI R31,HIGH(-_db)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x19:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1B:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1C:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1E:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x21:
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	MOV  R26,R19
	CALL _isspace
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x23:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x24:
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LD   R26,X
	CPI  R26,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x25:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	SBIW R30,4
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	ADIW R26,4
	LD   R16,X+
	LD   R17,X
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:

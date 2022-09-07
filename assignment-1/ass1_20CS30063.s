# Aman Sharma
# 20CS30063	
# Compilers Lab Assignment 1

	.file	"asgn1.c"											#Name of the source file
	.text														#Code section starts
	.section	.rodata											#Read only data section starts, any attempt to write to this section will result in a segmentation fault
	.align 8													#Align the data to 8 byte boundary
.LC0:															#Label for the string
	.string	"Enter the string (all lower case): "				#Stores the prompt to take input in a string
.LC1:															#Label for the string
	.string	"%s"												#Stores the format specifier for when we are taking input in the C code
.LC2:															#Label for the string
	.string	"Length of the string: %d\n"						#Stores the prompt to print the length of the string
	.align 8													#Align to 8 byte boundary
.LC3:															#Label for the string
	.string	"The string in descending order: %s\n"				#Stores the prompt to print the string in descending order
	.text														#Code section starts	
	.globl	main												#Defines main in a global context
	.type	main, @function										#Defines the type of main as a function
main:															#main function starts from here
.LFB0:
	.cfi_startproc												#Calls the frame information procedure
	endbr64														#This is a 64 bit end branch instruction
	pushq	%rbp												#Push the base pointer on to the stack 
	.cfi_def_cfa_offset 16														
	.cfi_offset 6, -16
	movq	%rsp, %rbp											#Move the stack pointer to the base pointer (rbp<-rsp)
	.cfi_def_cfa_register 6										
	subq	$80, %rsp											#Subtract 80 bytes from the stack pointer (rsp<-rsp-80) this is to allocate space for the local variables
	movq	%fs:40, %rax										#Move the value of the 40th byte of the frame pointer to the accumulator (rax<-fs:40)
	movq	%rax, -8(%rbp)										#Move the value of the accumulator to the 8th byte of the base pointer (rbp-8<-rax)
	xorl	%eax, %eax										    #Set the value of 32 bit accumulator to 0 (eax<-0)
	leaq	.LC0(%rip), %rax									#Load the address of the string in the read only data section to the accumulator (rax<-LC0)
	movq	%rax, %rdi											#Move the value of the accumulator to the first argument register (rdi<-rax)
	movl	$0, %eax											#Set the value of 32 bit accumulator to 0 (eax<-0)
	call	printf@PLT											#Call the printf function to print the prompt to take input, this corresponds to the C code for printf function in line 13
	leaq	-64(%rbp), %rax										#Load the address of the local variable to the accumulator (rax<-rbp-64)
	movq	%rax, %rsi											#Move the value of the accumulator to the second argument register (rsi<-rax)
	leaq	.LC1(%rip), %rax									#Load the address of the string in the read only data section to the accumulator (rax<-LC1)
	movq	%rax, %rdi											#Move the value of the accumulator to the first argument register (rdi<-rax)
	movl	$0, %eax											#Set the value of 32 bit accumulator to 0 (eax<-0)
	call	__isoc99_scanf@PLT									#Call the scanf function to take input, this corresponds to the C code for scanf function in line 14
	leaq	-64(%rbp), %rax										#Load the address of the local variable to the accumulator (rax<-rbp-64)
	movq	%rax, %rdi											#Move the value of the accumulator to the first argument register (rdi<-rax) so that the address of the string is passed to the length function
	call	length												#Call the length function to calculate the length of the string, this corresponds to the C code for length function in line 15. Code execution jumps to line 80 where the label length is defined
	movl	%eax, -68(%rbp)										#Move the value of the accumulator to the 68th byte of the base pointer (rbp-68<-rax)
	movl	-68(%rbp), %eax										#Move the value of the 68th byte of the base pointer to the accumulator (rax<-rbp-68)
	movl	%eax, %esi											#Move the value of the 32 bit accumulator to the second argument register (esi<-rax)
	leaq	.LC2(%rip), %rax									#Load the address of the string in the read only data section to the accumulator (rax<-LC2)
	movq	%rax, %rdi											#Move the value of the accumulator to the first argument register (rdi<-rax)
	movl	$0, %eax											#Set the value of 32 bit accumulator to 0 (eax<-0)
	call	printf@PLT											#Call the printf function to print the length of the string, this corresponds to the C code for printf function in line 16
	leaq	-32(%rbp), %rdx										#Load the address of the local variable to the data register (rdx<-rbp-32)
	movl	-68(%rbp), %ecx										#Move the value of the 68th byte of the base pointer to the counter register (ecx<-rbp-68) so that the pointer to the destination string is passed to the reverse function
	leaq	-64(%rbp), %rax										#Load the address of the local variable to the accumulator (rax<-rbp-64)
	movl	%ecx, %esi											#Move the value of the counter register to the second argument register (esi<-ecx) so that the length of the string is passed to the reverse function
	movq	%rax, %rdi											#Move the value of the accumulator to the first argument register (rdi<-rax) so that the pointer to the source string is passed to the reverse function
	call	sort												#Call the sort function to sort the string in ascending order, this corresponds to the C code for sort function in line 17. Code execution jumps to line 111 where the label sort is defined
	leaq	-32(%rbp), %rax										#Load the address of the local variable to the accumulator (rax<-rbp-32)
	movq	%rax, %rsi											#Move the value of the accumulator to the second argument register (rsi<-rax)
	leaq	.LC3(%rip), %rax									#Load the address of the string in the read only data section to the accumulator (rax<-LC3)
	movq	%rax, %rdi											#Move the value of the accumulator to the first argument register (rdi<-rax)
	movl	$0, %eax											#Set the value of 32 bit accumulator to 0 (eax<-0)
	call	printf@PLT											#Call the printf function to print the sorted and reversed string, this corresponds to the C code for printf function in line 18
	movl	$0, %eax											#Set the value of 32 bit accumulator to 0 (eax<-0)
	movq	-8(%rbp), %rdx										#Move the value of the 8th byte of the base pointer to the data register (rdx<-rbp-8)
	subq	%fs:40, %rdx										#Subtract the value of the 40th byte of the frame pointer from the data register (rdx<-rdx-fs:40)
	je	.L3														#If the value of the data register is 0, then jump to the label L3
	call	__stack_chk_fail@PLT								#Call the stack_chk_fail function to print the error message if there is a stack smashing detected
.L3:															#Label L3
	leave														#Restore the base pointer and the stack pointer to their values before the function call
	.cfi_def_cfa 7, 8									
	ret															#Return to the caller
	.cfi_endproc												#End of the frame
.LFE0:															
	.size	main, .-main										#Size of the main function
	.globl	length												#Make the length function global
	.type	length, @function									#Define the length function as a function
length:															#Label length
.LFB1:
	.cfi_startproc												#Start of the frame
	endbr64														#64 bit end of function prologue
	pushq	%rbp												#Push the base pointer to the stack
	.cfi_def_cfa_offset 16										
	.cfi_offset 6, -16
	movq	%rsp, %rbp											#Move the value of the stack pointer to the base pointer (rbp<-rsp)
	.cfi_def_cfa_register 6								
	movq	%rdi, -24(%rbp)										#Move the value of the first argument register to the 24th byte of the base pointer (rbp-24<-rdi)
	movl	$0, -4(%rbp)										#Set the value of the 4th byte of the base pointer to 0 (rbp-4<-0)
	jmp	.L5														#Jump to the label L5
.L6:
	addl	$1, -4(%rbp)										#Increment the value of the 4th byte of the base pointer by 1 (rbp-4<-rbp-4+1), this corresponds to the C code for i++ in line 25 in the for loop and maintains the count of the number of characters in the string
.L5:
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the accumulator (rax<-rax+rdx)
	movzbl	(%rax), %eax										#Move the value of the byte pointed to by the accumulator to the 32 bit accumulator (eax<-rax)
	testb	%al, %al											#Test the value of the 8 bit accumulator (al)
	jne	.L6														#If the value of the 8 bit accumulator is not 0, then jump to the label L6. This is where the code loops back to the label L6 to increment the count of the number of characters in the string
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	popq	%rbp												#Pop the base pointer from the stack
	.cfi_def_cfa 7, 8
	ret															#Return to the caller
	.cfi_endproc												#End of the frame
.LFE1:
	.size	length, .-length									#Size of the length function
	.globl	sort												#Make the sort function global
	.type	sort, @function										#Define the sort function as a function
sort:															#Label sort
.LFB2:
	.cfi_startproc												#Start of the frame
	endbr64														#64 bit end of function prologue
	pushq	%rbp												#Push the base pointer to the stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp											#Move the value of the stack pointer to the base pointer (rbp<-rsp)
	.cfi_def_cfa_register 6
	subq	$48, %rsp											#Subtract 48 from the stack pointer (rsp<-rsp-48)
	movq	%rdi, -24(%rbp)										#Move the value of the first argument register to the 24th byte of the base pointer (rbp-24<-rdi)
	movl	%esi, -28(%rbp)										#Move the value of the second argument register to the 28th byte of the base pointer (rbp-28<-rsi)
	movq	%rdx, -40(%rbp)										#Move the value of the third argument register to the 40th byte of the base pointer (rbp-40<-rdx)
	movl	$0, -8(%rbp)										#Set the value of the 8th byte of the base pointer to 0 (rbp-8<-0)
	jmp	.L9														#Jump to the label L9, this corresponds to the C code for i=0 in line 35 in the for loop(sort of), the for loop basically begins from here
.L13:
	movl	$0, -4(%rbp)										#Set the value of the 4th byte of the base pointer to 0 (rbp-4<-0)
	jmp	.L10													#Jump to the label L10, this corresponds to the C code for j=0 in line 36 in the for loop
.L12:
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the accumulator (rax<-rax+rdx)
	movzbl	(%rax), %edx										#Move the value of the byte pointed to by the accumulator to the 32 bit data register (edx<-rax)
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	movslq	%eax, %rcx											#Move the value of the 32 bit accumulator to the counter register (rcx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	addq	%rcx, %rax											#Add the value of the counter register to the accumulator (rax<-rax+rcx)
	movzbl	(%rax), %eax										#Move the value of the byte pointed to by the accumulator to the 32 bit accumulator (eax<-rax)
	cmpb	%al, %dl											#Compare the values of the 8 bit accumulator and the 8 bit data register (al,dl)
	jge	.L11													#If the value of the 8 bit accumulator is greater than or equal to the value of the 8 bit data register, then jump to the label L11, this corresponds to comparing str[i] and str[j] in line 37 in the C code
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the accumulator (rax<-rax+rdx)
	movzbl	(%rax), %eax										#Move the value of the byte pointed to by the accumulator to the 32 bit accumulator (eax<-rax)
	movb	%al, -9(%rbp)										#Move the value of the 8 bit accumulator to the 9th byte of the base pointer (rbp-9<-al)
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the accumulator (rax<-rax+rdx)
	movl	-8(%rbp), %edx										#Move the value of the 8th byte of the base pointer to the 32 bit data register (edx<-rbp-8)
	movslq	%edx, %rcx											#Move the value of the 32 bit data register to the counter register (rcx<-edx)
	movq	-24(%rbp), %rdx										#Move the value of the 24th byte of the base pointer to the data register (rdx<-rbp-24)
	addq	%rcx, %rdx											#Add the value of the counter register to the data register (rdx<-rdx+rcx)
	movzbl	(%rax), %eax										#Move the value of the byte pointed to by the accumulator to the 32 bit accumulator (eax<-rax)
	movb	%al, (%rdx)											#Move the value of the 8 bit accumulator to the byte pointed to by the data register (rdx<-al)
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	addq	%rax, %rdx											#Add the value of the accumulator to the data register (rdx<-rdx+rax)
	movzbl	-9(%rbp), %eax										#Move the value of the 9th byte of the base pointer to the 32 bit accumulator (eax<-rbp-9)
	movb	%al, (%rdx)											#Move the value of the 8 bit accumulator to the byte pointed to by the data register (rdx<-al)
.L11:
	addl	$1, -4(%rbp)										#Add 1 to the 4th byte of the base pointer (rbp-4<-rbp-4+1)
.L10:
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	cmpl	-28(%rbp), %eax										#Compare the value of the 28th byte of the base pointer and the 32 bit accumulator (rbp-28,eax)
	jl	.L12													#If the value of the 32 bit accumulator is less than the value of the 28th byte of the base pointer, then jump to the label L12, this loops back to L12 and the for loop for j continues
	addl	$1, -8(%rbp)										#Add 1 to the 8th byte of the base pointer (rbp-8<-rbp-8+1)
.L9:
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	cmpl	-28(%rbp), %eax										#Compare the value of the 28th byte of the base pointer and the 32 bit accumulator (rbp-28,eax)
	jl	.L13													#If the value of the 32 bit accumulator is less than the value of the 28th byte of the base pointer, then jump to the label L13, this loops back to L13 and the for loop for i continues
	movq	-40(%rbp), %rdx										#Move the value of the 40th byte of the base pointer to the data register (rdx<-rbp-40)
	movl	-28(%rbp), %ecx										#Move the value of the 28th byte of the base pointer to the counter register (ecx<-rbp-28)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the accumulator (rax<-rbp-24)
	movl	%ecx, %esi											#Move the value of the counter register to the source index (esi<-ecx)
	movq	%rax, %rdi											#Move the value of the accumulator to the destination index (rdi<-rax)
	call	reverse												#After setting the relevant registers in the lines above, call the reverse function
	nop															#¯\_(ツ)_/¯ No operation
	leave														#Restore the stack pointer to the value of the base pointer
	.cfi_def_cfa 7, 8
	ret															#Return from the function
	.cfi_endproc												#End of the frame
.LFE2:
	.size	sort, .-sort										#Set the size of the sort function to the difference between the end of the function and the start of the function
	.globl	reverse												#Make the reverse function global
	.type	reverse, @function									#Set the type of the reverse function to function
reverse:														#Reverse label
.LFB3:
	.cfi_startproc												#Start of the frame
	endbr64														#64 bit endbr
	pushq	%rbp												#Push the base pointer to the stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp											#Move the stack pointer to the base pointer
	.cfi_def_cfa_register 6								
	movq	%rdi, -24(%rbp)										#Move the value of the destination index to the 24th byte of the base pointer (rbp-24<-rdi)
	movl	%esi, -28(%rbp)										#Move the value of the source index to the 28th byte of the base pointer (rbp-28<-esi)
	movq	%rdx, -40(%rbp)										#Move the value of the data register to the 40th byte of the base pointer (rbp-40<-rdx)
	movl	$0, -8(%rbp)										#Move 0 to the 8th byte of the base pointer (rbp-8<-0), which corresponds to setting i to 0 at the start of the for loop in line 52 of the code
	jmp	.L15													#Jump to the label L15
.L20:
	movl	-28(%rbp), %eax										#Move the value of the 28th byte of the base pointer to the 32 bit accumulator (eax<-rbp-28)
	subl	-8(%rbp), %eax										#Subtract the value of the 8th byte of the base pointer from the 32 bit accumulator (eax<-eax-rbp-8)
	subl	$1, %eax											#Subtract 1 from the 32 bit accumulator (eax<-eax-1), this corresponds to decrementing j in the second for loop
	movl	%eax, -4(%rbp)										#Move the value of the 32 bit accumulator to the 4th byte of the base pointer (rbp-4<-eax)
	nop															#No operation
	movl	-28(%rbp), %eax										#Move the value of the 28th byte of the base pointer to the 32 bit accumulator (eax<-rbp-28)
	movl	%eax, %edx											#Move the value of the 32 bit accumulator to the data register (edx<-eax)
	shrl	$31, %edx											#Shift the value of the data register right by 31 bits (edx<-edx>>31)
	addl	%edx, %eax											#Add the value of the data register to the 32 bit accumulator (eax<-eax+edx)
	sarl	%eax												#Shift the value of the 32 bit accumulator right by 1 bit (eax<-eax>>1)
	cmpl	%eax, -4(%rbp)										#Compare the value of the 32 bit accumulator to the value of the 4th byte of the base pointer (rbp-4<eax)
	jl	.L18													#If the value of the 32 bit accumulator is less than the value of the 4th byte of the base pointer, jump to the label L18
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	cmpl	-4(%rbp), %eax										#Compare the value of the 4th byte of the base pointer to the value of the 32 bit accumulator (eax<rbp-4), this is comparing i to j which is line 54 of the C source code
	je	.L23													#If the value of the 4th byte of the base pointer is equal to the value of the 32 bit accumulator, jump to the label L23
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the data register (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the data register (rax<-rax+rdx)
	movzbl	(%rax), %eax										#Move the value of the 8 bit accumulator to the 32 bit accumulator (eax<-rax)
	movb	%al, -9(%rbp)										#Move the value of the 8 bit accumulator to the 9th byte of the base pointer (rbp-9<-al)
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the data register (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the data register (rax<-rax+rdx)
	movl	-8(%rbp), %edx										#Move the value of the 8th byte of the base pointer to the data register (edx<-rbp-8)
	movslq	%edx, %rcx											#Move the value of the data register to the data register (rcx<-edx)
	movq	-24(%rbp), %rdx										#Move the value of the 24th byte of the base pointer to the data register (rdx<-rbp-24)
	addq	%rcx, %rdx											#Add the value of the data register to the data register (rdx<-rdx+rcx)
	movzbl	(%rax), %eax										#Move the value of the 8 bit accumulator to the 32 bit accumulator (eax<-rax)
	movb	%al, (%rdx)											#Move the value of the 8 bit accumulator to the data register (rdx<-al)
	movl	-4(%rbp), %eax										#Move the value of the 4th byte of the base pointer to the 32 bit accumulator (eax<-rbp-4)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the data register (rax<-rbp-24)
	addq	%rax, %rdx											#Add the value of the data register to the data register (rdx<-rdx+rax)
	movzbl	-9(%rbp), %eax										#Move the value of the 9th byte of the base pointer to the 32 bit accumulator (eax<-rbp-9)			
	movb	%al, (%rdx)											#Move the value of the 8 bit accumulator to the data register (rdx<-al)
	jmp	.L18													#Jump to the label L18
.L23:
	nop															#No operation
.L18:
	addl	$1, -8(%rbp)										#Add 1 to the value of the 8th byte of the base pointer (rbp-8<-rbp-8+1), increments i
.L15:
	movl	-28(%rbp), %eax										#Move the value of the 28th byte of the base pointer to the 32 bit accumulator (eax<-rbp-28)
	movl	%eax, %edx											#Move the value of the 32 bit accumulator to the data register (edx<-eax)
	shrl	$31, %edx											#Shift the value of the data register right by 31 bits (edx<-edx>>31)
	addl	%edx, %eax											#Add the value of the data register to the 32 bit accumulator (eax<-eax+edx)
	sarl	%eax												#Shift the value of the 32 bit accumulator right by 1 bit (eax<-eax>>1)
	cmpl	%eax, -8(%rbp)										#Compare the value of the 8th byte of the base pointer to the 32 bit accumulator, if the value of the 8th byte of the base pointer is less than the value of the 32 bit accumulator, jump to the label L24
	jl	.L20													#Jump to the label L20
	movl	$0, -8(%rbp)										#Move 0 to the value of the 8th byte of the base pointer (rbp-8<-0)
	jmp	.L21													#Jump to the label L21
.L22:	
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-24(%rbp), %rax										#Move the value of the 24th byte of the base pointer to the data register (rax<-rbp-24)
	addq	%rdx, %rax											#Add the value of the data register to the data register (rax<-rax+rdx)
	movl	-8(%rbp), %edx										#Move the value of the 8th byte of the base pointer to the data register (edx<-rbp-8)
	movslq	%edx, %rcx											#Move the value of the data register to the data register (rcx<-edx)
	movq	-40(%rbp), %rdx										#Move the value of the 40th byte of the base pointer to the data register (rdx<-rbp-40)
	addq	%rcx, %rdx											#Add the value of the data register to the data register (rdx<-rdx+rcx)
	movzbl	(%rax), %eax										#Move the value of the 8 bit accumulator to the 32 bit accumulator (eax<-rax)
	movb	%al, (%rdx)											#Move the value of the 8 bit accumulator to the data register (rdx<-al)
	movl	-28(%rbp), %eax										#Move the value of the 28th byte of the base pointer to the 32 bit accumulator (eax<-rbp-28)
	movslq	%eax, %rdx											#Move the value of the 32 bit accumulator to the data register (rdx<-eax)
	movq	-40(%rbp), %rax										#Move the value of the 40th byte of the base pointer to the data register (rax<-rbp-40)
	addq	%rdx, %rax											#Add the value of the data register to the data register (rax<-rax+rdx)
	movb	$0, (%rax)											#Move 0 to the data register (rax<-0)
	addl	$1, -8(%rbp)										#Add 1 to the value of the 8th byte of the base pointer (rbp-8<-rbp-8+1), increments i
.L21:	
	movl	-8(%rbp), %eax										#Move the value of the 8th byte of the base pointer to the 32 bit accumulator (eax<-rbp-8)
	cmpl	-28(%rbp), %eax										#Compare the value of the 28th byte of the base pointer to the 32 bit accumulator, if the value of the 28th byte of the base pointer is less than the value of the 32 bit accumulator, jump to the label L22
	jl	.L22													#Jump to the label L22, this continues the for loop that is used to copy the string
	nop															#Useless(?)
	nop															#More useless(?)
	popq	%rbp												#Pop the value of the base pointer to the stack pointer (rbp->rsp)
	.cfi_def_cfa 7, 8											#Set the frame pointer to the stack pointer
	ret															#Return to the caller
	.cfi_endproc												#End the procedure
.LFE3:
	.size	reverse, .-reverse									#Set the size of the function reverse as the difference between the end of the function and the start of the function
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"				#Identify the compiler
	.section	.note.GNU-stack,"",@progbits					#Set the section to .note.GNU-stack
	.section	.note.gnu.property,"a"							
	.align 8													#Align the section to 8 bytes
	.long	1f - 0f												
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

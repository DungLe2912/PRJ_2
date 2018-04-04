# CSC10005.

# ---

.data
	menu_tbl: .asciiz "\n==================== MENU ====================\n\n  1. Nhap mang\n  2. Xuat mang\n  3. Liet ke so nguyen to trong mang\n  4. Liet ke so hoan thien trong mang\n  5. Tinh tong cac so chinh phuong trong mang\n  6. Tinh trung binh cong cac so doi xung trong mang\n  7. Tim gia tri lon nhat trong mang\n  8. Sap xep mang tang dan theo `Selection sort`\n  9. Sap xep mang giam dan theo `Bubble sort`\n\n 10. Thoat\n\n=============================================="
	menu_err: .asciiz "\n\nLUA CHON: "

	funct1_msg1: .asciiz "\nSo luong phan tu cua mang: "
	funct1_msg2: .asciiz "a["
	funct1_msg3: .asciiz "] = "

	funct2_msg1: .asciiz "\nMang vua nhap: "
	funct2_msg2: .asciiz "\nMang khong co phan tu nao ca."
	
	funct7_msg: .asciiz "Gia tri lon nhat trong mang: "
	
	arr_size: .word 0
	arr_data: .space 400
	
.text
	.globl main

# ---

main: # Ngo~ va`o chu+o+ng tri`nh.

	# Xua^'t `menu_tbl`.
	li $v0, 4
	la $a0, menu_tbl
	syscall

	# Nha^.p lu+.a cho.n.
	main.choice:

		# Xua^'t `menu_err`.
		li $v0, 4
		la $a0, menu_err
		syscall
	
		# Nha^.p lu+.a cho.n.
		li $v0, 5
		syscall
		move $s7, $v0 # cur_funct: .space 4 # `current_selected_functionality`.

		# Re~ dde^'n mo^.t trong ca'c chu+'c na(ng:
		beq $s7, 1, funct_1 # Nha^.p ma?ng.
		beq $s7, 2, funct_2 # Xua^'t ma?ng.
		beq $s7, 3, funct_3 # Lie^.t ke^ so^' nguye^n to^' trong ma?ng.
		beq $s7, 4, funct_4 # Lie^.t ke^ so^' hoa`n thie^.n trong ma?ng.	
		beq $s7, 5, funct_5 # Ti'nh to^?ng ca'c so^' chi'nh phu+o+ng trong ma?ng.
		beq $s7, 6, funct_6 # Ti'nh trung bi`nh co^.ng ca'c so^' ddo^'i xu'ng trong ma?ng.
		beq $s7, 7, funct_7 # Ti`m gia' tri. lo+'n nha^'t trong ma?ng.
		beq $s7, 8, funct_8 # Sa('p xe^'p ma?ng ta(ng da^`n theo `Selection sort`.
		beq $s7, 9, funct_9 # Sa('p xe^'p ma?ng gia?m da^`n theo `Bubble sort`.
		beq $s7, 10, exit # Ke^'t thu'c chu+o+ng tri`nh.
		
		# Xua^'t `menu_err`.
		li $v0, 4
		la $a0, menu_err # Tho^ng ba'o nha^.p la.i.
		syscall

		j main.choice # Nha^.p la.i.

# ---

funct_1: # Nha^.p ma?ng.

	# Xua^'t `funct1_msg1`.
	li $v0, 4
	la $a0, funct1_msg1
	syscall
	
	# Nha^.p so^' nguye^n.
	li $v0, 5
	syscall
	
	# Save va`o `arr_size`.
	sw $v0, arr_size
	
	# Load `arr_size` va`o `$s1`.
	lw $s1, arr_size
	
	# ---
	
	# Kho+?i ta.o vo`ng la(.p.
	li $t0, 0 # i = 0.
	la $s0, arr_data # Load ddi.a chi? cu?a ma?ng va`o `$s0`.

	funct_1.input_loop: # La(.p nha^.p.
	
		# Xua^'t `funct1_msg2`.
		li $v0, 4
		la $a0, funct1_msg2
		syscall
		
		# Xua^'t chi? so^' `i\`.
		li $v0, 1
		move $a0, $t0
		syscall
		
		# Xua^'t `funct1_msg3`.
		li $v0, 4
		la $a0, funct1_msg3
		syscall

		# Nha^.p so^' nguye^n.
		li $v0, 5
		syscall
		
		# Lu+u `a[i]` va`o `($s0)`.
		sw $v0, ($s0)
	
		# Ta(ng ddi.a chi? ma?ng.
		addi $s0, $s0, 4
		
		# Ta(ng chi? so^' `i\`.
		add $t0, $t0, 1
		
		# Kie^?m tra ddie^`u kie^.n la(.p.
		slt $t1, $t0, $s1 # i < n
		beq $t1, 1, funct_1.input_loop

	# ---

	j main.choice # Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.

# ---

funct_2: # Xua^'t ma?ng.

	# Kie^?m tra ma?ng co' ro^~ng hay kho^ng.
	bne $s1, $0, funct_2.output_arrary
	
	# Xua^'t `funct2_msg2`.
	li $v0, 4
	la $a0, funct2_msg2 # Ma?ng kho^ng co' pha^`n tu+? na`o ca?.
	syscall

	# ---

	j main.choice # Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.
		
	# ---
	
	funct_2.output_arrary: # Xua^'t toa'n bo^. pha^`n tu+? cu?a ma?ng.
	
		# Xua^'t `funct2_msg1`.
		li $v0, 4
		la $a0, funct2_msg1
		syscall
		
		# Kho+?i ta.o vo`ng la(.p.
		li $t0, 0
		la $s0, arr_data

		funct_2.output_loop:
		
			# Xua^'t `a[i]`.
			li $v0, 1
			lw $a0, ($s0)
			syscall			
		
			# Xua^'t khoa?ng tra('ng.
			li $v0, 11
			li $a0, 32 # 32 = ascii_code(SPACE_CHAR).
			syscall
			
			# Ta(ng ddi.a chi? ma?ng.
			addi $s0, $s0, 4
			
			# Ta(ng chi? so^' `i\`.
			addi $t0, $t0, 1
			
			# Kie^?m tra ddie^`u kie^.n la(.p.
			slt $t1, $t0, $s1 # i < n.
			beq $t1, 1, funct_2.output_loop

			# ---

			j main.choice # Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.

# ---

funct_3: # Lie^.t ke^ so^' nguye^n to^' trong ma?ng.

	# Truye^`n tham so^' cho ha`m.
	# ...

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# --
	
	# Vie^'t pha^`n ca`i dda(.t ha`m ta.i dda^y.
	# ...	

# ---

funct_4: # Lie^.t ke^ so^' hoa`n thie^.n trong ma?ng.

	# Truye^`n tham so^' cho ha`m.
	# ...

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# --
	
	# Vie^'t pha^`n ca`i dda(.t ha`m ta.i dda^y.
	# ...	

# ---

funct_5: # Ti'nh to+?ng ca'c so^' chi'nh phu+o+ng trong ma?ng.

	# Truye^`n tham so^' cho ha`m.
	# ...

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# --
	
	# Vie^'t pha^`n ca`i dda(.t ha`m ta.i dda^y.
	# ...	

# ---

funct_6: # Ti'nh trung bi`nh co^.ng ca'c so^' ddo^'i xu+'ng trong ma?ng.

	# Truye^`n tham so^' cho ha`m.
	# ...

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# --
	
	# Vie^'t pha^`n ca`i dda(.t ha`m ta.i dda^y.
	# ...	

# ---

funct_7: # Ti`m gia' tri. lo+'n nha^'t trong ma?ng.

	# Truye^`n tham so^' cho ha`m.
	move $a0, $s0
	jal funct_7.max
	
	# La^'y ke^'t qua? tra? ve^`.
	move $s2, $v0
	
	# Xua^'t `funct7_msg`.
	li $v0, 4
	la $a0, funct7_msg
	syscall
	
	# Xua^'t gia' tri. ca^`n ti`m.
	li $v0, 1
	move $a0, $s1
	syscall

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# ---

	# Ca`i dda(.t ha`m ti`m gia' tri. lo+'n nha^'t trong ma?ng.
	
		# Dau thu tuc.
		funct_7.max:
		
			# Khai ba'o ki'ch thu+o+'c cho stack.
			addi $sp, $sp, -16
			
			# Backup ca'c thanh ghi.
			sw $s0, ($sp) # max.
			sw $t0, 8($sp) # i.
			sw $t1, 12($sp) # ddie^`u kie^.n.
			sw $ra, 16($sp) # return address.
			
		# Tha^n thu? tu.c.
			li $s0, ($sp) # `$s0` la` gia' tri. lo+'n nha^'t hie^.n ta.i.
			addi $sp, $sp, 4 # Ta(ng ddi.a chi? ma?ng the^m.
		
			li $t0, 1 # i = 1.
				
			# Kie^?m tra ddie^`u kie^.n la(.p.
			slt $t1, $t0, $s1
		
			funct_7.max_loop:
			
		# Cuoi thu tuc.
		
			# Restore ca'c thanh ghi.
			lw $s0, ($sp)
			lw $t0, 4($sp)
			lw $t1, 8($sp)
			lw $ra, 12($sp)

			# Xoa stack.
			addi $sp, $sp, 16
			
			# Return address.
			jr $ra

# ---

funct_8: # Sa('p xe^'p ma?ng ta(ng da^`n theo `Selection sort`.

	# Truye^`n tham so^' cho ha`m.
	# ...

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# --
	
	# Vie^'t pha^`n ca`i dda(.t ha`m ta.i dda^y.
	# ...	

# ---

funct_9: # Sa('p xe^'p ma?ng gia?m da^`n theo `Bubble sort`.

	# Truye^`n tham so^' cho ha`m.
	# ...

	# ---

	# Lu+.a cho.n chu+'c na(ng ke^' tie^'p trong chu+o+ng tri`nh.	
	j main.choice

	# --
	
	# Vie^'t pha^`n ca`i dda(.t ha`m ta.i dda^y.
	# ...	

# ---

exit: # Ke^'t thu'c chu+o+ng tri`nh.
	li $v0, 10
	syscall

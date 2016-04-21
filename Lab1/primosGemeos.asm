.data
	oi: .asciiz "Digite i:"
	newl: .asciiz "\n"
	string1: .asciiz "Primos Gemeos("
	string2: .asciiz ")=("
	string3: .asciiz ","
	string4: .asciiz ")"

#LISTA DAS VARI�VEIS SALVAS
# $s0 = i de entrada
# $s1 = verifica
# $s2 = anterior
# $s3 = numero (usado dentro do Modulo)
# $s4 = primosGemeos
# $s5 = final
# $s6 = raiz

.text
	
MAIN:	li $v0, 4   #Imprime a mensagem inicial
	la $a0, oi
	syscall
	
	li $v0, 4  #Imprime o "\n" da mensagem incial 
	la $a0, newl
	syscall

	li $v0, 5 #Pega o valor de i
	syscall
	
	move $s0, $v0 # salva o valor de i
	#li $s0, 35 #DEBUG
			
	li $s1, 1 #Inicializa a vari�vel que verifica se um n�mero � primo ou n�o
	li $s2, -1  #Innicializa o n�mero que guarda o valor do n�mero primo anterior
	li $s3, 2  #Inicializa a vari�vel que avan�a para testar os n�meros primos
	li $s4, 0 #Inicializa o n�mero que conta os primos g�meos at� o i
	li $s6, 1 #Inicializa a var�vel raiz
	
while: 	move $a0, $s3
	jal Raiz  #Chama a fun��o que calcula o maior n�mero inteiro menor ou iagual a raiz do n�mero
	move $s6, $v0 #Salva o valor da raiz
	
	li $t0, 2 #Inicializa o for (n=2)
for: 	beq $s6, $t0, exit1 #Sai do for se n for iagual � raiz
	beq $s1, $zero, exit2 #Sai do for se o n�mero n�o for primo
	move $a0, $t0 #Coloca o n como argumento da fun��o Modulo
	jal Modulo #Chama a fun��o que calcula o m�dulo da divis�o entre o n�mero e o n
	move $s1, $v0 #Salva o resultado do m�dulo
	addi $t0, $t0, 1 #n++
	j for #Continua o for

exit1: 	sub $t1, $s3, $s2
	li $t2, 2
	bne $t1, $t2, exit3 
	addi $s4, $s4, 1
	move $s5, $s2

exit3:	move $s2, $s3
	j pulaE2

exit2:	addi $s1, $zero, 1
	
pulaE2:	addi $s3, $s3, 1
	slt $t3, $s4, $s0
	bne $t3, $zero, while

	jal show
	
	li $v0, 10
	syscall  #Encerra o programa :D
	

##########################################################################################################################
Raiz:	addi $a0, $a0, 1
	mul $t4, $a0, $a0
	slt $t5, $t4, $s3
	beq $t5, $zero, Mantem
	j return
Mantem:	addi $a0, $a0, -1
return: move $v0, $a0
	jr $ra

##########################################################################################################################
Modulo:	div $t4, $s3, $a0
	mul $t4, $a0, $t4
	sub $a0, $s3, $t4
	move $v0, $a0
	jr $ra

##########################################################################################################################
show: 	li $v0, 4   
	la $a0, string1
	syscall
	
	li $v0, 1
	move $a0, $s0 
	syscall
	
	li $v0, 4   
	la $a0, string2
	syscall
	
	li $v0, 1
	move $a0, $s5 
	syscall
	
	li $v0, 4   
	la $a0, string3
	syscall
	
	addi $s5, $s5, 2
	li $v0, 1
	move $a0, $s5 
	syscall
	
	li $v0, 4   
	la $a0, string4
	syscall
	
	li $v0,4  
	la $a0,newl
	syscall

	jr $ra
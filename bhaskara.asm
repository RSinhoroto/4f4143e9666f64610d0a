.data
	calculo: .asciiz "Calculo da raizes de um polinômio de segundo grau!"
	a: .asciiz "Digite a: "
	be: .asciiz "Digite b: "
	c: .asciiz "Digite c: "
	space: .asciiz " "
	raiz: .asciiz "R: "
	raiz1: .asciiz "R(1): "
	raiz2: .asciiz "R(2): "
	i: .asciiz "i"
	mais: .asciiz " + "
	menos: .asciiz " - "
	newl: .asciiz "\n"
	newl2: .asciiz "\n\n"  
	nexiste: .asciiz "Não existe raiz"
.text
li $v0, 4   #Imprime saudação
la $a0, calculo
syscall

li $v0, 4   #Pula linha
la $a0, newl2
syscall

li $v0, 4   
la $a0, a
syscall

li $v0,7 #Lê a do usuário 
syscall

mov.d $f2, $f0 #Coloca a em $f2

li $v0, 4   #Imprime msg
la $a0, be
syscall

li $v0,7 #Lê b do usuário 
syscall

mov.d $f4, $f0 #Coloca b em $f4

li $v0, 4   #Imprime msg
la $a0, c
syscall

li $v0, 7 #Lê c do usuário 
syscall

mov.d $f6, $f0 #Coloca c em $f6

cvt.w.d $f22, $f2 #Converte a para inteiro
mfc1 $t0, $f22   #Move a do coprocessador 1 para o registrador $t0

cvt.w.d $f24, $f4 #Converte a para inteiro
mfc1 $t1, $f24   #Move a do coprocessador 1 para o registrador $t0  

bnez $t0, BHASKARA #Se a =! 0, pula para bhaskara, se não, continua
beqz $t1, CZERO 

div.d $f8, $f6, $f4
li $t1, -1
mtc1 $t1, $f30        #Se a = 0, a raiz é -c/b
cvt.d.w $f18, $f30
mul.d $f8, $f8, $f18

li $v0, 4   #Pula linha
la $a0, newl
syscall

li $v0, 4   #Imprime raiz
la $a0, raiz
syscall

mov.d $f12, $f8
li $v0, 3      #Imprime o valor da raiz
syscall

li $v0, 10
syscall      #Finaliza o programa

CZERO:

li $v0, 4   #Pula linha
la $a0, newl
syscall

la $a0, newl
syscall
  
la $a0, nexiste #Pula linha
syscall

li $v0, 10   #Finaliza o programa
syscall

BHASKARA:

#Calcula o delta:

li $t4, 4
mtc1 $t4, $f26   #Move 4 para o coprocessador 1
cvt.d.w $f18, $f26  #Converte 4 de inteiro para double
mul.d $f8, $f4, $f4 #Calcula b^2 e coloca em $f8
mul.d $f10, $f2, $f6 #Calcula a.c e coloca em $f10
mul.d $f10, $f10, $f18   #Multiplica a expressão a.c por 4.
sub.d $f8, $f8, $f10 #Faz a subtração [b^2-(4.a.c)] e guarda em $f8
cvt.w.d $f30, $f8   #Converte o delta (double) em $f8, copiando-o em $f30 (inteiro)
mfc1 $t4, $f30     #Move o delta inteiro para o registrador $t4

bgtz $t4, REALDOIS      #Verifica se o delta é maior ou igual a 0. Se nenhuma dessas condições for atendida, ele continua
beqz $t4, REALZERO     

#Imaginário

li $t1, -1
mtc1 $t1, $f30
cvt.d.w $f18, $f30
li $t1, 2
mtc1 $t1, $f30
cvt.d.w $f20, $f30

mul.d $f10, $f4, $f18 #Gera -b e guarda em $f10
mul.d $f12, $f8, $f18 #Multiplica o delta por -1 e guarda em $f12
sqrt.d $f12, $f12 #Calcula a raiz do delta e guarda em $f6
mul.d $f14, $f2, $f20	#Multiplica a por dois.
div.d $f10, $f10, $f14    #Calcula a parte real da raiz e guarda em $f10
div.d $f14, $f12, $f14    #Calcula a parte imaginária e guarda em $f14
addi $sp, $sp, -20
sdc1 $f14, 8($sp)       #Empilha a parte imaginária
sdc1 $f10, 0($sp)       #Empilha a parte real
li $a3, 2               #Carrega $a3 com 2, indicando que possui duas raizes imaginárias
j SHOW                  #Pula para o procedimento SHOW

#################

REALDOIS:

li $t1, -1
mtc1 $t1, $f30    #Move -1 para o coprocessador 1
cvt.d.w $f18, $f30  #Converte 1 de inteiro para double
li $t1, 2         
mtc1 $t1, $f30    #Move 2 para o coprocessador 1
cvt.d.w $f20, $f30  #Converte 2 de inteiro para double

mul.d $f10, $f4, $f18  #Gera -b e guarda em $f10
sqrt.d $f8, $f8        #Calcula a raiz do delta e guarda em $f8
add.d $f12, $f10, $f8  #Calcula -b + sqrt(delta) e guarda em $f12
mul.d $f14, $f2, $f20  #Multiplica a por dois.
div.d $f16, $f12, $f14    #Calcula a primeira raiz e guarda em $f16
addi $sp, $sp, -20
sdc1 $f16, 8($sp)       #Empilha a primeira raiz
sub.d $f12, $f10, $f8   #Calcula -b - sqrt(delta)
div.d $f16 $f12, $f14   #Calcula a segunda raiz e guarda em $f8
sdc1 $f16, 0($sp)       #Empilha a segunda raiz
li $a3, 1               #Carrega o registrador $a3 com 1, indicando que possui duas raizes reais 
j SHOW                  #Pula para o procedimento SHOW

REALZERO:

li $t1, -1
mtc1 $t1, $f30    #Move -1 para o coprocessador 1
cvt.d.w $f18, $f30  #Converte 1 de inteiro para double
li $t1, 2         
mtc1 $t1, $f30    #Move 2 para o coprocessador 1
cvt.d.w $f20, $f30  #Converte 2 de inteiro para double

mul.d $f10, $f4, $f18   #Gera -b e guarda em $f10
mul.d $f8, $f2, $f20	#Multiplica a por dois.
div.d $f12, $f10, $f8   #Calcula a raiz e guarda em $f7
addi $sp, $sp, -20
sdc1 $f12, 8($sp)       #Empilha a raiz
sdc1 $f12, 0($sp)       #Empilha a raiz "De novo :("
li $a3, 1               #Carrega o registrador $a3 com 1, indicando que possui duas raizes reais 

SHOW:

li $v0, 4   #Pula linha
la $a0, newl
syscall

li $t0, 2 #Coloca 2 em $t0
beq $a3, $t0, PRINTIMAG   #Verifica se $a3 possui o valor 2, se possuir, chama o procedimento que printa raizes imaginárias

li $v0, 4   #Imprime raiz1
la $a0, raiz1
syscall

l.d $f12, 8($sp)   #Retira a primeira raiz da pilha e printa
li $v0, 3
syscall

li $v0, 4   #Pula linha
la $a0, newl
syscall

li $v0, 4   #Imprime raiz2
la $a0, raiz2
syscall
  
l.d $f12, 0($sp)   #Retira a segunda raiz da pilha e printa
li $v0, 3
syscall

addi $sp, $sp, 20  #Desaloca os elementos da pilha

li $v0, 10        #Finaliza o programa
syscall

PRINTIMAG:

li $v0, 4   #Imprime raiz1
la $a0, raiz1
syscall

l.d $f12, 0($sp)  #Retira a parte real da raiz da pilha e printa
li $v0, 3
syscall

li $v0, 4   #Imprime mais
la $a0, mais
syscall
  
l.d $f12, 8($sp) #Retira a parte imaginária raiz da pilha e printa
li $v0, 3
syscall

li $v0, 4   #Imprime i
la $a0, i
syscall

li $v0, 4   #Pula linha
la $a0, newl
syscall

li $v0, 4   #Imprime raiz2
la $a0, raiz2
syscall

l.d $f12, 0($sp)  #Retira a parte real da raiz da pilha e printa
li $v0, 3
syscall

li $v0, 4   #Imprime menos
la $a0, menos
syscall
  
l.d $f12, 8($sp)  #Retira a parte imaginária raiz da pilha e printa
li $v0, 3
syscall

li $v0, 4   #Imprime i
la $a0, i
syscall

addi $sp, $sp, 20  #Desaloca os elementos da pilha

li $v0, 10     #Finaliza o programa
syscall

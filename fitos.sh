#!/bin/bash

# Variaveis globais
inicio_eixoY=600
inicio_eixoX=320
fim_eixoY=500
fim_eixoX=1110
quadrado=55
orientacaoX=1
fishing_rod=''
spell=''
food=''
tempo_pesca=60

# Funções
obter_configuracoes() {
	diretorio=~/.config/fitos
	config="$diretorio/rc.conf"

	if [ ! -d $diretorio ]; then
		mkdir $diretorio
	fi
			
	if [ ! -f $config ]; then
		touch $config
		echo 'inicio_eixoY=600' >> $config
		echo 'inicio_eixoX=320' >> $config
		echo 'fim_eixoY=500' >> $config
		echo 'fim_eixoX=1110' >> $config
		echo "quadrado=55" >> $config
		echo "orientacaoX=1" >> $config
		echo "fishing_rod='F10'" >> $config
		echo "spell='F11'" >> $config
		echo "food='F12'" >> $config
		echo 'tempo_pesca=60' >> $config
	fi

	. $config

	if [[ -z "$fishing_rod" || -z "$spell" || -z "$food" ]]; then
		echo "Problemas com a configuração, favor verificar arquivo ~/.config/fitos/rc.conf"
		echo 'Acaso precise de um exemplo, favor abrir script fitos.sh com um edito de texto...'
		exit
	fi	
}

# Execução
obter_configuracoes
clear
echo
echo '███████╗██╗████████╗ ██████╗ ███████╗'
echo '██╔════╝██║╚══██╔══╝██╔═══██╗██╔════╝'
echo '█████╗  ██║   ██║   ██║   ██║███████╗'
echo '██╔══╝  ██║   ██║   ██║   ██║╚════██║'
echo '██║     ██║   ██║   ╚██████╔╝███████║'
echo '╚═╝     ╚═╝   ╚═╝    ╚═════╝ ╚══════╝'
echo
echo '        ║║║░░▄██║║║║░░░▄█░╔╗'
echo '        ╚╬╝░██▄█╬╬╬╬╬╬███░║║'
echo '        ░║░░░▀██║║║║░░░▀█░╠╝'
echo '        ░║░░░░░░░░░░░░░░░░║'     	
echo

if [ $orientacaoX -eq 1 ]; then
	echo "Orientação: X"
else
	echo "Orientação: Y"
fi

echo "Tamanho quadrado: $quadrado"
echo "Eixo X: $inicio_eixoX - $fim_eixoX"
echo "Eixo Y: $inicio_eixoY - $fim_eixoY"
echo "Fishing Rod: $fishing_rod"
echo "Spell: $spell"
echo "Food: $food"
echo
echo 'Pressione uma tecla para continuar...' 
read

tempo=0
voltar=0
x=$inicio_eixoX
y=$inicio_eixoY

while :
do
#---------------------------------------------------------------
#| 							Mouse							   |
#---------------------------------------------------------------
	if [ $orientacaoX -eq 1 ]; then
		if [ $x -gt $fim_eixoX ]; then
			x=$fim_eixoX
		elif [ $y -lt $fim_eixoY ]; then
			y=$fim_eixoY
		elif [ $x -lt $inicio_eixoX ]; then
			x=$inicio_eixoX
		elif [ $y -gt $inicio_eixoY ]; then
			y=$inicio_eixoY 
		fi
	
	else
		if [ $y -gt $fim_eixoY ]; then
			y=$fim_eixoY
		elif [ $x -lt $fim_eixoX ]; then
			x=$fim_eixoX
		elif [ $y -lt $inicio_eixoY ]; then
			y=$inicio_eixoY
		elif [ $x -gt $inicio_eixoX ]; then
			x=$inicio_eixoX
		fi		
	fi

	if [[ $x -eq $fim_eixoX && $y -eq $fim_eixoY ]]; then
		x=$inicio_eixoX
		y=$inicio_eixoY
	fi

	xte "mousemove $x $y" "key $fishing_rod" 'mouseclick 1' 'sleep 1'
	
	if [ $orientacaoX -eq 1 ]; then
		if [[ $x -eq $fim_eixoX && $y -eq $inicio_eixoY ]]; then
			((y=y - $quadrado))
			voltar=1
		elif [[ $x -eq $inicio_eixoX && $voltar -eq 1 && $y -lt $inicio_eixoY ]]; then
			((y=y - $quadrado))
			voltar=0
		elif [ $voltar -eq 1 ]; then
			((x=x - $quadrado))
		else
			((x=x + $quadrado))
		fi

	else
		if [[ $y -eq $fim_eixoY && $x -eq $inicio_eixoX ]]; then
			((x=x - $quadrado))
			voltar=1
		elif [[ $y -eq $inicio_eixoY && $voltar -eq 1 && $x -lt $inicio_eixoX ]]; then
			((x=x - $quadrado))
			voltar=0
		elif [ $voltar -eq 1 ]; then
			((y=y - $quadrado))
		else
			((y=y + $quadrado))
		fi
	fi

#---------------------------------------------------------------
#| 							Teclado							   |
#---------------------------------------------------------------
	# Incrementando tempo
	((tempo=tempo+1))

	# Validar se passou 1 minuto
	if [ $tempo -gt $tempo_pesca ]; then
		xte "key $spell" 'sleep 2' "key $spell"
		xte "key $food" 'sleep 1' "key $food" 'sleep 1' "key $food"
		tempo=0
	fi

done

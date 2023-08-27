# Fitos
Bot para tibia em shell script

## Configuração
_O arquivo de configuração se encontra em ~/.config/fitos/rc.conf, seguindo a syntax:_
```shell
inicio_eixoY=600   # O local inicial utilizado para o xte realizar o mousemove no eixo Y
inicio_eixoX=320   # O local inicial utilizado para o xte realizar o mousemove no eixo X
fim_eixoY=500      # O local final utilizado para o xte realizar o mousemove no eixo Y
fim_eixoX=1110     # O local final utilizado para o xte realizar o mousemove no eixo X
quadrado=55        # Valor utilizado para incrementar eixos X e Y até seu respectivo final
orientacaoX=1      # Indica se vai se orientar pelo eixo X ou Y (
fishing_rod='F10'  # Hotkey referente a vara de pesca (Colocar a Fishing Rod nela)
spell='F11'        # Hotkey referente a magia (Colocar a magia nela) a ser utilizada após para o tempo_pesca
food='F12'         # Hotkey para comer o peixe (Colocar o fish)
tempo_pesca=60     # Tempo em segundos em que o personagem vai pescar até soltar a magia e comer o peixe
```
_Acaso não exista configuração ao executar o script o mesmo sera criado com as configurações padrões._

## Observações
_O script utiliza o `xte` (obtém-se ao instalar o `xautomation`) para realizar movimento do mouse e teclar, por isso confirme se a KEY a ser utilizada possui no mesmo._  
_**Após ser solicitado para pressionar uma tecla, o mesmo só irá parar através do Ctrl + C.**_

#### Fishing Rod
---
_A forma de pescar se da através de incremento do eixo X ou Y (Com base na orientacaoX) para mover o mouse e realizar um click utilizando a hotkey determinada na variavel `fishing_rod`. A lógica se encontra entre as linhas 87 e 146 do script._ 

#### Spell
---
_A magia será lançada duas vezes com um tempo de espera de 2 segundos entre elas. A lógica se encontra entre as linhas 147 e 158 do script._

#### Food
---
_O personagem irá se alimentar 3 vezes com tempo de espera de 1 segundo entre as mesmas. A lógica se encontra entre as linhas 147 e 158 do script._

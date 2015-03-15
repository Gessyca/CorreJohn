-- Projeto: Corre John
-- Versão: 1.0

-- Para esconder a barra de status
display.setStatusBar(display.HiddenStatusBar)

-- Adicionando física ao jogo
local physics = require("physics")
physics.start()
-- Componentes do jogo
local origemx = display.contentWidth
local origemy = display.contentHeight

local meiox = display.contentCenterX
local  meioy = display.contentCenterY

local background = display.newImage("background.jpg")
background.alpha = 0

local cj = display.newImage( "cj.png", meiox,meioy)
cj.alpha=0

local pontuacaoTxt = display.newText( "Pontuação: ", 60, 15, "Helvetica", 20)
pontuacaoTxt:setTextColor ( 255, 0, 0 )
pontuacaoTxt.alpha=0
local pontuacao = 0
-- Adicionando Spritelocal folha =  { width=80, height=105, numFrames=12 }local imagem = graphics.newImageSheet("fat.png", folha)local comandos = {	{ name = "direita", start = 9, count = 4, time = 500, loopCount = 0 }, --idleDown = parado para baixo (é só um nome, vc quem nomeia como quiser)	-- name: nome desse movimento	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame		-- os outros vetores são da mesma forma, cada um com a sua animação    { name = "esquerda", start = 5, count = 4, time = 500, loopCount = 0 }, --parado pra esquerda}local player = display.newSprite(imagem, comandos)-- cria finalmente a sprite utilizando as propriedades vistas acimaplayer.x = meiox-150player.y = meioy+66player:setSequence("direita")player.alpha=0
-- funções do jogo
-- Funcao mudar o objeto de lado tocando no donutsfunction mudarLado()	if player.acao == "esquerda" then		player:setSequence("direita")		player.acao = "direita"	else		player:setSequence("esquerda")		player.acao = "esquerda"	end	player:play()end
local function mostrarNomeJogo()
transition.to ( cj, {time = 1000, alpha=1 ,xScale=2 , yScale=2} )
end

-- remove qualquer objeto através de um evento
function removerObjeto(event)
	local obj = event.target
	display.remove( obj ) 
--  o retorno garante que seja removido somente o objeto clicado
	return true
end

function startGame()

transition.to ( background, {time=3000, alpha=1, onComplete=mostrarNomeJogo} )
-- Função local para remover o nome da tela do jogo e inicar o jogo
local function removerNomeJogo(event)
	display.remove( cj )
	pontuacaoTxt.alpha = 1
	pontuacaoTxt.text = "Pontuação: " .. pontuacao	player.alpha=1
end	
cj:addEventListener ( "tap", removerNomeJogo )background:addEventListener("tap",mudarLado)
end

startGame()



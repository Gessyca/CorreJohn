-- Projeto: Corre John
-- Versão: 1.0

-- Para esconder a barra de status
display.setStatusBar(display.HiddenStatusBar)

-- Adicionando física ao jogo
local physics = require("physics")
physics.start()--Carregando o som na memórialocal somBack = audio.loadSound("som.wav") 
-- Componentes do jogo
local origemx = display.contentWidth
local origemy = display.contentHeight

local meiox = display.contentCenterX
local  meioy = display.contentCenterY

local scroll = 5local background = display.newImageRect("background.jpg",origemx,origemy)background.x = 0background.y = meioylocal background2 = display.newImageRect("background.jpg",origemx,origemy)background2.x = background.x + origemxbackground2.y = meioylocal background3 = display.newImageRect("background.jpg",origemx,origemy)background3.x = background2.x + origemxbackground3.y = meioylocal donuts = display.newImage("donut.png",meiox+180, meioy+110)donuts:scale(.1,.1)donuts.alpha = 0
local cj = display.newImage( "cj.png", meiox,meioy)
cj.alpha=0

local pontuacaoTxt = display.newText( "Pontuação: ", 60, 15, "Helvetica", 20)
pontuacaoTxt:setTextColor ( 255, 0, 0 )
pontuacaoTxt.alpha=0
local pontuacao = 0local texto = display.newText("Toque no nome acima para iniciar",meiox, meioy+130, "Helvetica", 20)texto.alpha = 0
-- Adicionando Spritelocal folha =  { width=80, height=105, numFrames=12 }local imagem = graphics.newImageSheet("fat.png", folha)local comandos = {	{ name = "direita", start = 9, count = 4, time = 500, loopCount = 0 }, --idleDown = parado para baixo (é só um nome, vc quem nomeia como quiser)	-- name: nome desse movimento	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame		-- os outros vetores são da mesma forma, cada um com a sua animação    { name = "esquerda", start = 5, count = 4, time = 500, loopCount = 0 }, --parado pra esquerda}local player = display.newSprite(imagem, comandos)-- cria finalmente a sprite utilizando as propriedades vistas acimaplayer.x = meiox-140player.y = meioy+87player:setSequence("direita")player.alpha=0
-- Funcao mudar o objeto de lado tocando no donutsfunction mudarLado()texto.text = ""	if player.acao == "esquerda" then		player:setSequence("direita")		player.acao = "direita"	else		player:setSequence("esquerda")		player.acao = "esquerda"	end	player:play()endfunction backgroundLoop(event)background.x = background.x - scrollbackground2.x = background2.x - scrollbackground3.x = background3.x - scroll	if (background.x + background.contentWidth) < 0 then		background:translate(origemx * 3,0)	end	if (background2.x + background2.contentWidth) < 0 then		background2:translate( origemx * 3,0 )	end	if (background3.x + background3.contentWidth) < 0 then		background3:translate( origemx * 3,0 )	endend-- Os dois métodos fazem o nome do jogo se mover recursivamentefunction mostrarNomeJogo()
transition.to ( cj, {time = 1000, alpha=1 ,xScale=1.3 , yScale=1.3, onComplete =moveNomeJogo} )endfunction moveNomeJogo()texto.alpha = 1transition.to ( cj, {time = 1000, alpha=1 ,xScale=1 , yScale=1, onComplete =mostrarNomeJogo} )end--function aparecerDonuts()donuts.alpha=1transition.to (donuts, {time = 1000, xScale = .15, yScale = .15, onComplete = moverDonuts})endfunction moverDonuts()transition.to (donuts, {time = 1000, xScale = .1, yScale = .1, onComplete = aparecerDonuts})end
-- remove qualquer objeto através de um evento
function removerObjeto(event)
	local obj = event.target
	display.remove( obj ) 
--  o retorno garante que seja removido somente o objeto clicado
	return true
end
function removerNomeJogo(event)	display.remove( cj )	texto.text = "Toque no donuts para pular"	pontuacaoTxt.alpha = 1	pontuacaoTxt.text = "Pontuação: " .. pontuacao	player.alpha=1	player:play()	audio.stop()	aparecerDonuts()end	
function startGame()
transition.to ( background, {time=1500, alpha=1, onComplete=mostrarNomeJogo} )Runtime:addEventListener("enterFrame", backgroundLoop)audio.play(somBack,{chanel=1,loops=-1, fadein=30000 })
cj:addEventListener ( "tap", removerNomeJogo )donuts:addEventListener("tap",mudarLado)
end

startGame()



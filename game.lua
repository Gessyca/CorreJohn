local composer = require( "composer" )
local scene = composer.newScene()
-- Adicionando física ao jogo
local physics = require("physics")
physics.start()
--physics.setDrawMode( "hybrid")

-- Componentes do jogo
local origemx = display.contentWidth
local origemy = display.contentHeight

local meiox = display.contentCenterX
local  meioy = display.contentCenterY

local scroll = 4
local background = display.newImageRect("background.png",origemx,origemy)
background.x = 0
background.y = meioy

local background2 = display.newImageRect("background.png",origemx,origemy)
background2.x = background.x + origemx
background2.y = meioy

local background3 = display.newImageRect("background.png",origemx,origemy)
background3.x = background2.x + origemx
background3.y = meioy

local pontuacaoTxt = display.newText( "Peso atual: "..pontuacao, 60, 15, "Helvetica", 20)
pontuacaoTxt:setTextColor ( 255, 0, 0 )
local meta = display.newText( "Meta: 50Kg", 200, 15, "Helvetica", 20)
local limite = display.newText( "Limite peso: 200Kg", 350, 15, "Helvetica", 20)
limite:setTextColor ( 255, 255, 0 )

-- alimentos saudáveis
cereja = display.newImage("comidas/s.png")
cereja.alpha = 0
cereja:scale(.05,.05)
cereja.name = "saudavel"
cereja.x = meiox
physics.addBody(cereja, { radius=20})
coco = display.newImage("comidas/s2.png")
coco.alpha = 0
coco.x = meiox
coco:scale(.08,.08)
coco.name = "saudavel"
physics.addBody(coco,  { radius=20})
salada = display.newImage("comidas/s3.png")
salada.name = "saudavel"
salada:scale(.05,.05)
salada.x = meiox
salada.alpha = 0
physics.addBody(salada, { radius=20})
abacaxi = display.newImage("comidas/s5.png")
abacaxi.name = "saudavel"
abacaxi.x = meiox
abacaxi:scale(.01,.01)
abacaxi.alpha = 0
physics.addBody(abacaxi, { radius=20})

cerveja = display.newImage("comidas/m.png")
cerveja.name = "gorduroso"
cerveja.x = meiox
cerveja.alpha = 0
cerveja:scale(.15,.15)
physics.addBody(cerveja,{ radius=20})
hotDog = display.newImage("comidas/m2.png")
hotDog.name = "gorduroso"
hotDog.x = meiox
hotDog.alpha = 0
hotDog:scale(.05,.05)
physics.addBody(hotDog,{ radius=20})
sorvete = display.newImage("comidas/m3.png")
sorvete.name = "gorduroso"
sorvete.x = meiox
sorvete.alpha = 0
sorvete:scale(.1,.1)
physics.addBody(sorvete,{ radius=20})
bolo = display.newImage("comidas/m5.png")
bolo.name = "gorduroso"
bolo.x = meiox
bolo:scale(.02,.02)
bolo.alpha = 0
physics.addBody(bolo,{ radius=30})
--audio
local eat = audio.loadSound('sons/eat.mp3');
-- Adicionando Sprite
local folha =  { width=80, height=107.3, numFrames=12 }
local imagem = graphics.newImageSheet("fat.png", folha)
local comandos = 
{
	{ name = "direita", start = 9, count = 4, time = 500, loopCount = 0 }, --idleDown = parado para baixo (é só um nome, vc quem nomeia como quiser)
	-- name: nome desse movimento
	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)
	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)
	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro
	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame
	
	-- os outros vetores são da mesma forma, cada um com a sua animação
    { name = "esquerda", start = 5, count = 4, time = 500, loopCount = 0 }, --parado pra esquerda
	
	{ name = "pular", start = 10, count = 1, time = 500, loopCount = 0 },
}

local player = display.newSprite(imagem, comandos)
player.x = meiox-160
player.y = meioy+93
player.name = "John"
local playerShape = { -0,-40, 20,45, -22,0 }
physics.addBody(player, "kinematic",{shape=playerShape, isSensor=true})
player:setSequence("direita")


listaAlimentos = {
[0] = cerveja,
[1] = cereja,
[2] = hotDog,
[3] = coco,
[4] = sorvete,
[5] = salada,
[6] = bolo,
[7] = abacaxi
}
local alimento
local alimento2
local alimento3
local alimento4
local alimento5
local tm
function scene:create( event )
    local sceneGroup = self.view
	composer.removeScene("menu")
	composer.removeScene("gameOver")
	playerGroup = display.newGroup()
	scene.view:insert(background)
	scene.view:insert(background2)
	scene.view:insert(background3)
	scene.view:insert(pontuacaoTxt)
	playerGroup:insert(player)
	alimentos = display.newGroup()
	scene.view:insert(alimentos)
	alimentos:insert( coco )
	alimentos:insert( cereja )
	alimentos:insert( salada )
	alimentos:insert( abacaxi )
	alimentos:insert( cerveja )
	alimentos:insert( hotDog )
	alimentos:insert( sorvete )
	alimentos:insert( bolo )
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase	
	local somMenu = audio.loadStream("sons/sgame.wav");
	audio.setVolume( 0.5 )
	local somBack = audio.play(somMenu,{chanel=1, loops=-1})
    if ( phase == "did" ) then
	player:play()
	Runtime:addEventListener("enterFrame", backgroundLoop)
	coco:addEventListener("touch", removerObjeto)
	cereja:addEventListener("touch", removerObjeto)
	salada:addEventListener("touch", removerObjeto)
	abacaxi:addEventListener("touch", removerObjeto)
	cerveja:addEventListener("touch", removerObjeto)
	hotDog:addEventListener("touch", removerObjeto)
	sorvete:addEventListener("touch", removerObjeto)
	bolo:addEventListener("touch", removerObjeto)
	tm = timer.performWithDelay( 4000,mostrarAlimentos ,0)
	Runtime:addEventListener("collision", colisao)
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

   if ( phase == "will" ) then
    timer.cancel(tm)
	coco:removeEventListener("touch", removerObjeto)
	cereja:removeEventListener("touch", removerObjeto)
	salada:removeEventListener("touch", removerObjeto)
	abacaxi:removeEventListener("touch", removerObjeto)
	cerveja:removeEventListener("touch", removerObjeto)
	hotDog:removeEventListener("touch", removerObjeto)
	sorvete:removeEventListener("touch", removerObjeto)
	bolo:removeEventListener("touch", removerObjeto)
	Runtime:removeEventListener("collision", colisao)
	Runtime:removeEventListener("enterFrame", backgroundLoop)
    end
end

function mostrarAlimentos(event)
local na = criarMaisAlimentos()
indice = math.random(0,7)
	alimento = listaAlimentos[indice]
	alimento.alpha = 1
	alimento.x = _W + 100
	alimento.y = math.random(meioy+50, meioy+110)
	transition.to( alimento, {time = 3500, rotation = -180, x = -100, y = alimento.y, onComplete = removerAlimento})
if(na >= 2) then
		indice = math.random(0,7)
		alimento2 = listaAlimentos[indice]
		alimento2.alpha = 1
		alimento2.x = _W + 100
		alimento2.y = math.random(meioy+30, meioy+120)
		transition.to( alimento2, {time = 3000, rotation = -180, x = -150, y = alimento2.y, onComplete = removerAlimento})
 end
  if(na == 3 or na > 3 ) then
		indice = math.random(0,7)
		alimento3 = listaAlimentos[indice]
		alimento3.alpha = 1
		alimento3.x = _W + 150
		alimento3.y = math.random(meioy+40, meioy+140)
		transition.to( alimento3, {time = 2800, rotation = -180, x = -100, y = alimento3.y, onComplete = removerAlimento})
  end
  if(na == 4) then
		indice = math.random(0,7)
		alimento4 = listaAlimentos[indice]
		alimento4.alpha = 1
		alimento4.x = _W + 150
		alimento4.y = math.random(meioy+20, meioy+140)
		transition.to( alimento4, {time = 3000, rotation = -180, x = -150, y = alimento4.y, onComplete = removerAlimento})
  end
end

function criarMaisAlimentos()
if (pontuacao <= 140 and pontuacao > 120) then
return 2
end
if (pontuacao <= 120 and pontuacao > 90) then
return 3
end
if (pontuacao <= 90) then
return 4
end
if(pontuacao > 140) then
return 1
end
end

function colisao(event)
if ( event.phase == "began" ) then
if(event.object1.name == "saudavel" and event.object2.name == "John" and event.object1.alpha == 1) then 
audio.play(eat,{duration = 30000})
event.object1.alpha = 0
pontuacao = pontuacao - 1
atualizarPontuacao()
end
if(event.object1.name == "John" and event.object2.name == "saudavel" and event.object2.alpha == 1) then
audio.play(eat,{duration = 30000})
event.object2.alpha = 0
pontuacao = pontuacao - 1
atualizarPontuacao()
end
if(event.object1.name == "gorduroso" and event.object2.name == "John" and event.object1.alpha == 1) then
audio.play(eat,{duration = 30000})
event.object1.alpha = 0
pontuacao = pontuacao + 1
atualizarPontuacao()
end
if(event.object1.name == "John" and event.object2.name == "gorduroso" and event.object2.alpha == 1) then
audio.play(eat,{duration = 30000})
event.object2.alpha = 0
pontuacao = pontuacao + 1
atualizarPontuacao()
end
end
compararPontuacaoMeta()
end

function atualizarPontuacao()
pontuacaoTxt.text = string.format( "Peso atual: %d", pontuacao)
end

function compararPontuacaoMeta()
if(pontuacao == 50)then
-- Ganhou!!!
end
if(pontuacao == 151) then
audio.stop()
display.remove(player)
composer.gotoScene("gameOver")
end
end

function moverMenu(event)
				transition.to ( menu, {time = 1000, alpha=1 ,xScale=0.12 , yScale=0.12, onComplete =moveNomeMenu} )
			end
			function moveNomeMenu()
				transition.to ( menu, {time = 1000, alpha=1 ,xScale=0.14 , yScale=0.14, onComplete =moverMenu} )
			end

function removerAlimento()
alimento.rotation = -45
alimento.alpha = 0
if(alimento2 ~= nil) then
alimento2.rotation = -45
alimento2.alpha = 0
end
if(alimento3 ~= nil) then
alimento3.rotation = -45
alimento3.alpha = 0
end
if(alimento4 ~= nil) then
alimento4.rotation = -45
alimento4.alpha = 0
end
end

-- remove qualquer objeto através de um evento
function removerObjeto(event)
	local obj = event.target
	obj.alpha = 0
	--display.remove( obj ) 
	return true
end

	function backgroundLoop(event)
		background.x = background.x - scroll
		background2.x = background2.x - scroll
		background3.x = background3.x - scroll

	if (background.x + background.contentWidth) < 0 then
		background:translate(origemx * 3,0)
	end
	if (background2.x + background2.contentWidth) < 0 then
		background2:translate( origemx * 3,0 )
	end
	if (background3.x + background3.contentWidth) < 0 then
		background3:translate( origemx * 3,0 )
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene
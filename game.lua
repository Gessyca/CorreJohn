local composer = require( "composer" )
local scene = composer.newScene()
-- Adicionando física ao jogo
local physics = require("physics")
physics.start()
physics.setDrawMode( "hybrid")

local physicsData = (require "shapedefs").physicsData(1.0)
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

local donuts = display.newImage("donut.png",meiox+220, meioy+130)
donuts:scale(.1,.1)

local pontuacao = 150
local pontuacaoTxt = display.newText( "Peso atual: "..pontuacao, 60, 15, "Helvetica", 20)
pontuacaoTxt:setTextColor ( 255, 0, 0 )
local Meta = display.newText( "Meta: 60Kg", 200, 15, "Helvetica", 20)

-- alimentos saudáveis
cereja = display.newImage("comidas/s.png")
cereja.alpha = 0
cereja:scale(.05,.05)
cereja.name = "saudavel"
physics.addBody(cereja, { radius=20, density=1.0, friction=0.3})
coco = display.newImage("comidas/s2.png")
coco.alpha = 0
coco:scale(.08,.08)
coco.name = "saudavel"
physics.addBody(coco,  { radius=20, density=1.0, friction=0.3})
salada = display.newImage("comidas/s3.png")
salada.name = "saudavel"
salada:scale(.05,.05)
salada.alpha = 0
physics.addBody(salada, { radius=20, density=1.0, friction=0.3})
abacaxi = display.newImage("comidas/s5.png")
abacaxi.name = "saudavel"
abacaxi:scale(.01,.01)
abacaxi.alpha = 0
physics.addBody(abacaxi, { radius=20, density=1.0, friction=0.3})

cerveja = display.newImage("comidas/m.png")
cerveja.name = "gorduroso"
cerveja.alpha = 0
cerveja:scale(.15,.15)
physics.addBody(cerveja,{ radius=20, density=1.0, friction=0.3})
hotDog = display.newImage("comidas/m2.png")
hotDog.name = "gorduroso"
hotDog.alpha = 0
hotDog:scale(.05,.05)
physics.addBody(hotDog,{ radius=20, density=1.0, friction=0.3})
sorvete = display.newImage("comidas/m3.png")
sorvete.name = "gorduroso"
sorvete.alpha = 0
sorvete:scale(.1,.1)
physics.addBody(sorvete,{ radius=20, density=1.0, friction=0.3})
bolo = display.newImage("comidas/m5.png")
bolo.name = "gorduroso"
bolo:scale(.02,.02)
bolo.alpha = 0
physics.addBody(bolo,{ radius=35, density=0.1, friction=0.1})
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
player.x = meiox-190
player.y = meioy+93
player.name = "John"
local playerShape = { -5,-55, 27,55, -35,0 }
physics.addBody(player, "kinematic",{shape=playerShape})
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
local tm
function scene:create( event )
    local sceneGroup = self.view
	playerGroup = display.newGroup()
	scene.view:insert(background)
	scene.view:insert(background2)
	scene.view:insert(background3)
	scene.view:insert(donuts)
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

    if ( phase == "did" ) then
	player:play()
	aparecerDonuts()
	Runtime:addEventListener("enterFrame", backgroundLoop)
	donuts:addEventListener("tap",pular)
	tm = timer.performWithDelay( 4000,mostrarAlimentos ,0)
	Runtime:addEventListener("collision", colisao)
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

   if ( phase == "will" ) then
    timer.cancel(tm)
	donuts:removeEventListener("tap",pular)
	Runtime:removeEventListener("collision", colisao)
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

function mostrarAlimentos(event)
	indice = math.random(0,7)
	alimento = listaAlimentos[indice]
	alimento.alpha = 1
	alimento.x = _W
	alimento.y = math.random(meioy, meioy+95 )
	--alimento.isSensor = true  
  transition.to( alimento, {time = 3000, rotation = -180, x = -50, y = alimento.y, onComplete = removerAlimento})
end

function colisao(event)

if ( event.phase == "began" ) then

if(event.object1.name == "saudavel" and event.object2.name == "John") then 
pontuacao = pontuacao - 0.5
atualizarPontuacao()
event.object1.alpha = 0
end
if(event.object1.name == "John" and event.object2.name == "saudavel") then
pontuacao = pontuacao - 0.5
atualizarPontuacao()
event.object2.alpha = 0
end
if(event.object1.name == "gorduroso" and event.object2.name == "John") then
pontuacao = pontuacao + 0.5
atualizarPontuacao()
event.object1.alpha = 0
end
if(event.object1.name == "John" and event.object2.name == "gorduroso") then
pontuacao = pontuacao + 0.5
atualizarPontuacao()
event.object2.alpha = 0
end
end
end

function atualizarPontuacao()
pontuacaoTxt.text = string.format( "Peso atual: %d", pontuacao)
end

function compararPontuacaoMeta()

-- Lógica Aqui

end
function removerAlimento()
alimento.rotation = -45
alimento.alpha = 0
end

function aparecerDonuts()
transition.to (donuts, {time = 1000, xScale = .15, yScale = .15, onComplete = moverDonuts})
end
function moverDonuts()
transition.to (donuts, {time = 1000, xScale = .1, yScale = .1, onComplete = aparecerDonuts})
end

function pular()
transition.to(player, {time=400, y = meioy, onComplete = descer})
end

function descer()
transition.to(player, {time=400, y = meioy+89})
end

-- remove qualquer objeto através de um evento
function removerObjeto(event)
	local obj = event.target
	display.remove( obj ) 
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
scene:addEventListener( "destroy", scene )

return scene
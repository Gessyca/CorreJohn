local composer = require( "composer" )
local scene = composer.newScene()
-- Adicionando física ao jogo
local physics = require("physics")
physics.start()
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

local pontuacaoTxt = display.newText( "Pontuação: ", 60, 15, "Helvetica", 20)
pontuacaoTxt:setTextColor ( 255, 0, 0 )
local pontuacao = 0

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
-- cria finalmente a sprite utilizando as propriedades vistas acima
player.x = meiox-190
player.y = meioy+93
player:setSequence("direita")

function scene:create( event )
    local sceneGroup = self.view
	playerGroup = display.newGroup()
	scene.view:insert(background)
	scene.view:insert(background2)
	scene.view:insert(background3)
	scene.view:insert(donuts)
	scene.view:insert(pontuacaoTxt)
	playerGroup:insert(player)

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
	player:play()
	aparecerDonuts()
	Runtime:addEventListener("enterFrame", backgroundLoop)
	donuts:addEventListener("tap",pular)
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

   if ( phase == "did" ) then
	donuts:removeEventListener("tap",pular)
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
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
--  o retorno garante que seja removido somente o objeto clicado
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
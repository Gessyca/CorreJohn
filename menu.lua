local composer = require("composer")
local scene = composer.newScene()
--Variaveis
local origemx = display.contentWidth
local origemy = display.contentHeight
local meiox = display.contentCenterX
local  meioy = display.contentCenterY

--Imagem de background
local background = display.newImage("background.png")

--Imagem com Nome do Jogo
local cj = display.newImage( "cj.png", meiox,meioy)
cj.alpha=0

--BOTÃO Play
local playButton = display.newImage("play.png");
playButton.xScale = .14;
playButton.yScale = .14;
playButton.x = (meiox + 200);
playButton.y = (meioy + 110);

--BOTÃO About

local about = display.newImage("about.png")
about.xScale = .14
about.yScale = .14
about.x = meiox - 200
about.y = meioy + 110
		
function scene:createScene(event)
			local scenegroup = self.view;
			scene.view:insert(background);
			scene.view:insert(cj);		
end

function scene:show( event )
    local sceneGroup = self.view
	composer.removeScene("about")
	composer.removeScene("gameOver")
	local phase = event.phase
	if (phase == "did") then
		playButton:addEventListener( "tap", startGame )
		about:addEventListener("tap", informacoes)
		mostrarNomeJogo()
	end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
	if (phase == "will") then
		playButton:removeEventListener( "tap", startGame )
		about:removeEventListener("tap", informacoes)
		transition.cancel(cj)
	end
end

function mostrarNomeJogo(event)
				transition.to ( cj, {time = 1000, alpha=1 ,xScale=0.3 , yScale=0.3, onComplete =moveNomeJogo} )
			end
function moveNomeJogo()
				transition.to ( cj, {time = 1000, alpha=1 ,xScale=0.2 , yScale=0.2, onComplete =mostrarNomeJogo} )
			end
			
function startGame( )
	display.remove(background)
	display.remove(cj)
	display.remove(playButton)
	display.remove(about)
	composer.gotoScene("game")
end

function informacoes( )
	display.remove(background);
	display.remove(cj);
	display.remove(playButton);
	display.remove(about);
	composer.gotoScene("about", { effect = "zoomOutIn"});
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
			
return scene


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
playButton = display.newImage("play.png");
playButton.xScale = 0.1;
playButton.yScale = 0.1;
playButton.x = (meiox + 210);
playButton.y = (meioy + 120);

--BOTÃO About

about = display.newImage("about.png")
about.xScale = 0.3
about.yScale = 0.3
about.x = meiox - 200
about.y = meioy + 120
		
function scene:createScene(event)
			local scenegroup = self.view;
			scene.view:insert(background);
			scene.view:insert(cj);		
end

function scene:show( event )
    local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then		
	elseif (phase == "did") then
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
	end
end

function mostrarNomeJogo(event)
				transition.to ( cj, {time = 1000, alpha=1 ,xScale=1.3 , yScale=1.3, onComplete =moveNomeJogo} )
			end
			function moveNomeJogo()
				transition.to ( cj, {time = 1000, alpha=1 ,xScale=1 , yScale=1, onComplete =mostrarNomeJogo} )
			end
			
function startGame( )
	display.remove(background);
	display.remove(cj);
	transition.cancel(cj);
	display.remove(playButton);
	display.remove(about);
	composer.gotoScene("game");
end

function informacoes( )
	display.remove(background);
	display.remove(cj);
	transition.cancel(cj);
	display.remove(playButton);
	display.remove(about);
	composer.gotoScene("about");
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
			
return scene


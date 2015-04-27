local composer = require("composer")
local scene = composer.newScene()
--Variaveis
local origemx = display.contentWidth
local origemy = display.contentHeight
local meiox = display.contentCenterX
local  meioy = display.contentCenterY

--Imagem de background
local background = display.newImage("background.png")

-- Texto About
local texto = display.newText("O jogo é sobre o personagem John que precisa emagrecer e para isso deverá evitar tentações que aparecerão durante o jogo e poderá pegar alguns bônus que irão facilitar no objetivo final que é emagrecer.", 60, 15, "Helvetica", 20)

function scene:createScene(event)
			local scenegroup = self.view;
			scene.view:insert(background);		
end

function scene:show( event )
    local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then		
	elseif (phase == "did") then
	end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
	if (phase == "will") then
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
			
return scene
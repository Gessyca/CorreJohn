local composer = require("composer")
local scene = composer.newScene()
--Variaveis
local origemx = display.contentWidth
local origemy = display.contentHeight
local meiox = display.contentCenterX
local  meioy = display.contentCenterY

--Imagem de background
local background = display.newImage("background.png")
menu = display.newImage("menu.png", meiox + 230, meioy + 110)
menu:scale(.14,.14);
local comojogar = display.newImage("comojogar.png",meiox,meioy - 100)
comojogar:scale(.08,.08)

-- Texto About
local texto = display.newText("Vamos ajudar o John a emagrecer?", meiox, meioy-50, "Helvetica", 20)
texto:setTextColor ( 0, 0, 255 )
local texto2 = display.newText("Para isso preciso que toque nos alimentos não saudáveis", meiox, meioy-30, "Helvetica", 20)
texto2:setTextColor ( 0, 0, 255 )
local texto3 = display.newText("A meta do John é 50kg e caso ele chegue a 200kg", meiox, meioy-10, "Helvetica", 20)
texto3:setTextColor ( 0, 0, 255 )
local texto4 = display.newText("terá problemas de saúde.", meiox, meioy+10, "Helvetica", 20)
texto4:setTextColor ( 0, 0, 255 )
local texto5 = display.newText("Vamos nessa e Bom jogo.", meiox, meioy+30, "Helvetica", 20)
texto5:setTextColor ( 255, 255, 0 )

function scene:createScene(event)
			local scenegroup = self.view;
			scene.view:insert(background);		
			scene.view:insert(comojogar);		
			scene.view:insert(texto);
			scene.view:insert(texto2);
			scene.view:insert(texto3);
			scene.view:insert(texto4);
			scene.view:insert(texto5);
			
end

function scene:show( event )
    local sceneGroup = self.view
	local phase = event.phase
	composer.removeScene("menu")
	if (phase == "will") then		
	elseif (phase == "did") then
	menu:addEventListener( "tap", irParaMenu )
	moverBotaoMenu()
	end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
	if (phase == "will") then
	menu:removeEventListener( "tap", irParaMenu )
	end
end

function irParaMenu(event)
audio.play(botao)
transition.cancel(menu)
display.remove(menu)
display.remove(background)
display.remove(comojogar)
display.remove(texto)
display.remove(texto2)
display.remove(texto3)
display.remove(texto4)
display.remove(texto5)
composer.gotoScene("menu")
end

function moverBotaoMenu()
				transition.to ( menu, {time = 1000 ,xScale=0.1 , yScale=0.1, onComplete =move} )
			end
			function move()
				transition.to ( menu, {time = 1000 ,xScale=0.15 , yScale=0.15, onComplete =moverBotaoMenu} )
			end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
			
return scene
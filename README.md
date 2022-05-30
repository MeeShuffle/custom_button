# Custom button
Easy to use custom button for everyone

# How to use

createCustomButton(x,y,width,height,text,font,scale,colorTXT,colorFilling,colorBG,colorLine,postGUI)

destroyCustomButton(button)

isButton(button)

customButtonSetSpeed(button,speedFilling,speedUnfilling)

addEventHandler("onCustomButtonClick",root,function(button,key)

# Create example

font = dxCreateFont("font.ttf",10,false,"antialiased")
b1 = exports["custom_button"]:createCustomButton(screenW * 0.4464, screenH * 0.3306, screenW * 0.1078, screenH * 0.0444,"Button 1",font,0.5,{255,255,255,255},{255,0,0,255},{80,80,80,150},{255,255,255,255},true);
b2 = exports["custom_button"]:createCustomButton(screenW * 0.4464, screenH * 0.5361, screenW * 0.1078, screenH * 0.0444,"Button 2",font,0.5,{255,255,255,255},{255,0,255,255},{80,80,80,150},{255,255,255,255},true);
exports["custom_button"]:customButtonSetSpeed(b2,3,3)

# Destroy example
if exports["custom_button"]:isButton(b1) then
	exports["custom_button"]:destroyCustomButton(b1)
end
if exports["custom_button"]:isButton(b2) then
	exports["custom_button"]:destroyCustomButton(b2)
end

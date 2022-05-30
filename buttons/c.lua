_buttons = {}
_buttons.button = {}
self = _buttons


self.events={
    "onCustomButtonClick",
};

for i=1,#self.events do
    addEvent(self.events[i],true) 
end 

self.freeID = function()
    if #self.button==0 then
        return 1
    end
    local count=0
    local rnd=math.random(1,1000)
    for _,v in ipairs(self.button)do
        if rnd==v["id"] then
            count=count+1
        end
    end
    if count>0 then
        customedit.freeID()
    elseif count==0 then
        return rnd
    end
end

self.create = function(x,y,w,h,text,font,scale,colortxt,color,colorbg,colorline,postgui)
    self.id = self.freeID()
    table.insert(self.button, {
        resource = sourceResource,
        x = x,
        y = y,
        w = w,
        h = h,
        text = text or "",
        font = font or "default",
        colortxt = colortxt or {255,255,255,255},
        color = color or {255,255,255,255},
        colorbg = colorbg or {255,255,255,255},
        colorline = colorline or {255,255,255,255},
        id = self.id,
        fill = 0,
        visible = true,
        postGui = postgui or false,
        speedplus = 7,
        speedminus = 7,
    })
    return self.id
end

self.cursor = function ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    
    return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end




self.render = function()
    if #self.button>0 then
        for i = 1,#self.button do
            dxDrawRectangle(self.button[i].x,self.button[i].y,self.button[i].w,self.button[i].h,tocolor(self.button[i].colorbg[1],self.button[i].colorbg[2],self.button[i].colorbg[3],self.button[i].colorbg[4]),self.button[i].postGui)
            if self.cursor(self.button[i].x,self.button[i].y,self.button[i].w,self.button[i].h) and self.button[i].visible then
                if self.button[i].fill<self.button[i].w then
                    self.button[i].fill = self.button[i].fill + self.button[i].speedplus
                end
            else
                if self.button[i].fill>0 then
                    self.button[i].fill = self.button[i].fill - self.button[i].speedminus
                elseif self.button[i].fill<=0 then
                    self.button[i].fill = 0
                end
            end
            dxDrawRectangle(self.button[i].x,self.button[i].y,self.button[i].fill,self.button[i].h,tocolor(self.button[i].color[1],self.button[i].color[2],self.button[i].color[3],self.button[i].color[4]),self.button[i].postGui)
            dxDrawText(self.button[i].text, self.button[i].x+1, self.button[i].y+1, (self.button[i].w+self.button[i].x)+1, (self.button[i].h+self.button[i].y)+1, tocolor(0, 0, 0, 255), self.button[i].scale, self.button[i].font, "center", "center", false, true, self.button[i].postGui, false, false)
            dxDrawText(self.button[i].text, self.button[i].x, self.button[i].y, (self.button[i].w+self.button[i].x), (self.button[i].h+self.button[i].y), tocolor(self.button[i].colortxt[1],self.button[i].colortxt[2],self.button[i].colortxt[3],self.button[i].colortxt[4], 255), self.button[i].scale, self.button[i].font, "center", "center", false, true, self.button[i].postGui, false, false)
            dxDrawLine(self.button[i].x,self.button[i].y,(self.button[i].x+self.button[i].w),self.button[i].y,tocolor(self.button[i].colorline[1],self.button[i].colorline[2],self.button[i].colorline[3],self.button[i].colorline[4]),2,self.button[i].postGui)
            dxDrawLine(self.button[i].x,self.button[i].y,self.button[i].x,(self.button[i].y+self.button[i].h),tocolor(self.button[i].colorline[1],self.button[i].colorline[2],self.button[i].colorline[3],self.button[i].colorline[4]),2,self.button[i].postGui)
            dxDrawLine(self.button[i].x,(self.button[i].y+self.button[i].h),(self.button[i].x+self.button[i].w),(self.button[i].y+self.button[i].h),tocolor(self.button[i].colorline[1],self.button[i].colorline[2],self.button[i].colorline[3],self.button[i].colorline[4]),2,self.button[i].postGui)
            dxDrawLine((self.button[i].x+self.button[i].w),self.button[i].y,(self.button[i].x+self.button[i].w),(self.button[i].y+self.button[i].h),tocolor(self.button[i].colorline[1],self.button[i].colorline[2],self.button[i].colorline[3],self.button[i].colorline[4]),2,self.button[i].postGui)
        end
    end
end
addEventHandler("onClientRender",root,self.render)

self.clear = function(res)
    for k,v in ipairs(self.button)do
        if v["resource"]==res then
            table.remove(self.button,k)
            self.clear(res)
            break
        end
    end
end
addEventHandler("onClientResourceStop",root,self.clear)

self.click = function(k,s)
    if k=="left" and s=="down" then
        for i = 1,#self.button do
            if self.cursor(self.button[i].x,self.button[i].y,self.button[i].w,self.button[i].h) and self.button[i].visible then
                triggerEvent("onCustomButtonClick",localPlayer,self.button[i].id)
            end
        end
    end
end
addEventHandler("onClientClick",root,self.click)

self.destroy = function(button)
    if button then
        for k,v in ipairs(self.button)do
            if v["id"]==button then
                table.remove(self.button,k)
                return true
            end
        end
    end
    return false
end

self.isbutton = function(button)
    if button then
        for k,v in ipairs(self.button)do
            if v["id"]==button then
                return true
            end
        end
    end
    return false
end

self.setspeed = function(button,speedminus,speedplus)
    if button then
        if not speedminus then speedminus = 7 end
        if not speedplus then speedplus = 7 end
        for k,v in ipairs(self.button)do
            if v["id"]==button then
                v["speedplus"] = tonumber(speedplus)
                v["speedminus"] = tonumber(speedminus)
                return true
            end
        end
    end
    return false
end
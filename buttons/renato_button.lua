local Rgb = require "classes.rgb"

--FUNCTION FOR RENATO_BUTTON--

function func(self)
    print(self.tp, self.subtp, self.id)
    if math.random() > .66 then
        self.color = Rgb.purple()
    elseif math.random() > .33 then
        self.color = Rgb.pink()
    else
        self.color = Rgb.orange()
    end
end

return func
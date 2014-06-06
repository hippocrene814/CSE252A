function hw2_q1()
    function L = l(x,y)
        L = x.^2+y.^2+3
    end
    function FS = fs(x,y)
        FS = 1./(1+x.^2+y.^2);
    end
    function res = double(x,y)
        res = l(x,y).*fs(x,y).*fs(x,y);
    end

h = @double
res = quad2d(h, -3,3,-2,2)
end


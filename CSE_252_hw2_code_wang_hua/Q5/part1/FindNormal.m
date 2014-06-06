function [normal, alb] = FindNormal(I, L)
    
   I = I';
   g  = L\I;
   alb  = norm(g);
   normal  = g/alb;

end

function [match score] = SSDmatch(template, image, threshold)       
        
        lr = template;
        lrm = mean(lr(:));
        lr = lr - lrm;
        
        rr = image;
        rrm = mean(rr(:));
        
        t = (lr-(rr-rrm)).^2;
        s = sum(t(:));
        score=s;
        
        if(s<threshold)
            match=1;
        else
            match=0;
        end
        
        

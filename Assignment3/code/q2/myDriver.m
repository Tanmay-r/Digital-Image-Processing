function myDriver(q_no,param)

if(q_no==2)
    if(param==1)
        k=[1,2,3,5,10,20,30,50,75,100,125,150,170,175];
    else
        k=[1,2,3,5,10,20,30,50,60,65,75];
    end

    recog_rate=k;

    for i=1:size(k,2)
        recog_rate(1,i)=q2a(k(1,i),param,0,0);
    end
    recog_rate
    
elseif(q_no==3)    
    q2a(175,1,1,0);
end
    

function myDriver()

k=[1,2,3,5,10,20,30,50,75,100,125,150,170,171];
recog_rate=k;

for i=1:size(k,2)
    recog_rate(1,i)=q2a(k(1,i));
end

recog_rate

    
    

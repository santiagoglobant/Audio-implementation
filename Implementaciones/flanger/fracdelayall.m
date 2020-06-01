classdef fracdelayall < handle
   properties
        buffer
        long
        pw
        pr
        pr2
        m
        n
        dec
        ultout
    end
    methods
        function obj=fracdelayall(m)
            ent=floor(m);
            obj.ultout=0;
            obj.dec=m-ent;                        
            obj.m=ent;                        
            obj.long=44100;
            obj.buffer=zeros(1,obj.long);
            obj.pw=0;
            obj.pr=obj.long-obj.m;
            obj.pr2=obj.long-obj.m-1;
            obj.dec=0;
        end
        
        function out=process(obj,in)
            r=mod(obj.pr,obj.long)+1;
            w=mod(obj.pw,obj.long)+1;
            r2=mod(obj.pr2,obj.long)+1;
            
            obj.buffer(1,w)=in;
            out2=obj.buffer(1,r2);
            out1=obj.buffer(1,r);            
            out=out1*(1-obj.dec)+out2-obj.ultout*(1-obj.dec);
            obj.ultout=out;
            
            obj.pr=obj.pr+1;
            obj.pr2=obj.pr2+1;
            obj.pw=obj.pw+1;
        end
        
        function setdelay(obj,n)
            ent=floor(n);
            obj.dec=n-ent;                        
            obj.m=ent;
            obj.pr=obj.pw-obj.m; 
            obj.pr2=obj.pw-obj.m-1;   
        end
        
        end
end
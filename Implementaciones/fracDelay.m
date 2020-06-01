classdef fracDelay<handle
    properties
        M
        maxDelay
        buffer
        pW
        pR
        interpolation
        lastOut
    end
    methods
        function obj=fracDelay(M,i)
            obj.maxDelay=44100;
            obj.interpolation=i;
            obj.lastOut=0;
            if M>obj.maxDelay   %Restriccion de delay maximo
                obj.M=obj.maxDelay;
            else
                obj.M=M;
            end
            obj.buffer=zeros(1,obj.maxDelay);
            obj.pW=obj.maxDelay;
            obj.pR=obj.pW-floor(obj.M);
        end
        function out=process(obj,x)
            wI=mod(obj.pW,obj.maxDelay)+1;
            rI=mod(obj.pR,obj.maxDelay)+1;
            rI2=mod(obj.pR-1,obj.maxDelay)+1;
            frac=obj.M-floor(obj.M);
            
            obj.buffer(wI)=x;
            switch obj.interpolation
                case 'Linear'
                    out=frac*obj.buffer(rI2) + (1-frac)*obj.buffer(rI); 
                case 'AllPass'
                    out=obj.buffer(rI2)+(1-frac)*(obj.buffer(rI)-obj.lastOut);
                    obj.lastOut=out;
            end
                                  
            obj.pW=obj.pW+1;
            obj.pR=obj.pR+1;
            a=[obj.pW;obj.pR]
        end
        function setDelay(obj,M)
            if M>obj.maxDelay   %Restriccion de delay maximo
                obj.M=obj.maxDelay;
            else
                obj.M=M;
            end
            obj.pR=obj.pW-floor(obj.M);
        end
    end
end